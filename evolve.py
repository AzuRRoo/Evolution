import tkinter as tk
import clips as clp # type: ignore
import json

question_map = {}
# GlobalOptions = []

def reset(root):
    root.destroy()
    main()

def load_questions_from_json(json_file):
    with open(json_file, 'r') as f:
        return json.load(f)

def get_questions_and_options(env):
    """ Extract all questions and their available options from the CLIPS environment """
    questions = {}
    for fact in env.facts():
        if fact.template.name == "response-to-query":
            query = fact["query"]
            options = fact["options"]
            questions[query] = options

    return questions



def ask_question(env, root, question, options, question_frame):

    for widget in question_frame.winfo_children():
        widget.destroy()

    if question in question_map:
        text = question_map[question]
        question_label = tk.Label(question_frame, text=text, font=("Arial", 14))
        question_label.pack(pady=10)

    selected_option = tk.StringVar()

    for option in options:
        rb = tk.Radiobutton(question_frame, text=option, variable=selected_option, value=option, font=("Arial", 12))
        rb.pack(anchor="w", padx=20)

    def submit():
        user_choice = selected_option.get()
        if user_choice:

            template_black = env.find_template("to-change")
            template_black.assert_fact(query = question,response = user_choice)
            env.run()

            for fact in env.facts():
                if fact.template.name == "result-animal":
                        for widget in question_frame.winfo_children():
                            widget.destroy()
                        result_label = tk.Label(question_frame, text=fact["animal"], font=("Arial", 14))
                        result_label.pack(pady=10)
                        reset_button = tk.Button(question_frame,text="RESET",command=lambda: reset(root),font=("Comic Sans", 12))
                        reset_button.pack(pady=20)

                        return
            

            root.after(500, run, env, root, question_frame)

    submit_button = tk.Button(question_frame, text="Submit", command=submit, font=("Arial", 12))
    submit_button.pack(pady=20)

    reset_button = tk.Button(question_frame,text="RESET",command=lambda: reset(root),font=("Comic Sans", 12))
    reset_button.pack(pady=20)


def run(env, root,question_frame):
    """ Main function to run the application, show questions and collect responses """

    env.run()  

    next_question = None
    for fact in env.facts():  
        if fact.template.name == "request":
            next_question = fact["query"] 
            break

    if not next_question:
        for fact in env.facts():
            if fact.template.name == "result-animal":
                    result_label = tk.Label(question_frame, text=fact["animal"], font=("Arial", 14))
                    result_label.pack(pady=10)
        return  



    questions = get_questions_and_options(env)
    
    ask_question(env, root, next_question, questions.get(next_question, []), question_frame)

def init():
    """ Initialize the main tkinter window """
    root = tk.Tk()
    root.title("What species did you evolve from?")
    root.geometry("400x400")

    question_frame = tk.Frame(root)
    question_frame.pack(pady=20)
    global question_map
    question_map = load_questions_from_json('fullName.json')
    return root, question_frame

def main():

    """ Main entry point for the application """
    env = clp.Environment()  
    env.load('Rule_based_engine.clp')  

    root, question_frame = init()  
    run(env,root, question_frame) 
    root.mainloop() 

if __name__ == "__main__":
    main()