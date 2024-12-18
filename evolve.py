import tkinter as tk
import clips as clp # type: ignore
import json

question_map = {}
GlobalOptions = []

def reset(root):
    root.destroy()
    main()

def load_questions_from_json(json_file):
    with open(json_file, 'r') as f:
        return json.load(f)

def get_questions_and_options(env):
    """ Extract all questions and their available options from the CLIPS environment """
    questions = {}

    env.run()  # Process rules and facts to get the current state

    # Loop through all facts in the environment and gather questions with options
    for fact in env.facts():
        if fact.template.name == "response-to-query":
            query = fact["query"]
            #query = question_map.get(query, query)  # Default to query if not found in map
            options = fact["options"]
            questions[query] = options
    
    return questions


def back(env, root, query, options, questions_asked, question_frame): 

    template_starszyBrat = env.find_template("set-to-undefined")

    template_Jagiello = env.find_template("return")
    
    template_Jagiello.assert_fact(query = query)

    template_starszyBrat.assert_fact(query = questions_asked[-2])

    #env.assert_string(fact_string_change)  # Assert the to-change fact

    #(f"Modyfing fact: {fact_string}")
    env.run()
    # for fact in env.facts():
    #     print(fact)
    global GlobalOptions
    questions_asked = questions_asked[:-1]
    if GlobalOptions:
        GlobalOptions = GlobalOptions[:-1]
    print(questions_asked)
    print(GlobalOptions)
    ask_question(env, root, questions_asked[-2], GlobalOptions[-1], questions_asked[:-1], question_frame)#change question options questions_asked

def ask_question(env, root, question, options, questions_asked, question_frame):
    """ Create a question and present options using tkinter widgets """
    # Clear the previous widgets (if any) in the frame
    for widget in question_frame.winfo_children():
        widget.destroy()
    
    if question in question_map:
        text = question_map[question]
    # Create a label for the current question
        question_label = tk.Label(question_frame, text=text, font=("Arial", 14))
        question_label.pack(pady=10)

    # Variable to store the user's selected option
    selected_option = tk.StringVar()

    # Create radio buttons for each option
    for option in options:
        rb = tk.Radiobutton(question_frame, text=option, variable=selected_option, value=option, font=("Arial", 12))
        rb.pack(anchor="w", padx=20)
    

    # Function to handle the submission and update facts
    def submit():
        user_choice = selected_option.get()
        if user_choice:
            # Create a fact string to update the response in CLIPS
            #fact_string = f"(to-change (query \"{question}\") (response \"{user_choice}\"))"
            #(f"Asserting fact: {fact_string}")
            #env.assert_string(fact_string)  # Update the CLIPS environment with the user's choice
            
            # template_black = env.find_template("to-change")
            # template_black.assert_fact(query = question,response = user_choice)
            template_starszyBrat = env.find_template("set-to-undefined")

            template_Jagiello = env.find_template("return")
            
            template_Jagiello.assert_fact(query = question)

            template_starszyBrat.assert_fact(query = questions_asked[-1])

            env.run()

            for fact in env.facts():
                # print(fact)
                if fact.template.name == "result-animal":
                        result_label = tk.Label(question_frame, text=fact, font=("Arial", 14))
                        result_label.pack(pady=10)


                        
            # Mark the current question as answered
            questions_asked.append(question)

            # Call run again to show the next question
            root.after(500, run, env, root, questions_asked, question_frame)  # 500 ms delay to refresh the GUI

    # Create a submit button to confirm the user's selection
    submit_button = tk.Button(question_frame, text="Submit", command=submit, font=("Arial", 12))
    submit_button.pack(pady=20)

    reset_button = tk.Button(question_frame,text="RESET",command=lambda: reset(root),font=("Comic Sans", 12))
    reset_button.pack(pady=20)
    
    back_button = tk.Button(question_frame,text="Back",command=lambda: back(env, root, question, options, questions_asked, question_frame),font=("Arial",12))
    back_button.pack(pady=20)

    if len(questions_asked) <= 1:
        back_button.pack_forget()


def run(env, root, questions_asked, question_frame):
    """ Main function to run the application, show questions and collect responses """
    env.run()  # Run the CLIPS engine to process rules and facts

    # Check if this is the first question to ask
    if not questions_asked:
        # Retrieve all questions and options
        questions = get_questions_and_options(env)
    
        # Select the first question from the environment
        first_question = list(questions.keys())[0]
        options = questions[first_question]
        GlobalOptions.append(options)
        # Mark this question as asked
        questions_asked.append(first_question)

        # Ask the first question
        ask_question(env, root, first_question, options, questions_asked, question_frame)
        return  # Return early to avoid processing request facts in the first run

        #After the first question, dynamically check for the `request` fact
    next_question = None
    for fact in env.facts():  # Iterate over all facts in the CLIPS environment
        print(fact)
        if fact.template.name == "request": 
                if "query" in fact and "options" in fact:
                    query = fact["query"]
                    options = fact["options"]
                    print(f"Current question: {query}")
                    print(f"Available options: {options}")
                else:
                    print("The expected slots 'query' or 'options' are missing in this fact.")
            #print(fact)
            
                    next_question = fact["query"]  # Extract the query value (question name)
                    print(next_question)
                    break  # Stop after finding the first request fact

    if not next_question:
        # If no request fact is found, assume the questioning process is complete
        final_message = tk.Label(question_frame, text="Thank you for your responses!", font=("Arial", 16))
        final_message.pack(pady=20)
        return  # End the questioning process



    # Retrieve the options for the next question
    questions = get_questions_and_options(env)
    options = questions.get(next_question, [])
    GlobalOptions.append(options)
    # Mark this question as asked to avoid asking it again
    if next_question not in questions_asked:
        questions_asked.append(next_question)

    # Ask the next question
    ask_question(env, root, next_question, options, questions_asked, question_frame)

def init():
    """ Initialize the main tkinter window """
    root = tk.Tk()
    root.title("What species did you evolve from?")

    
    # Create a frame to hold all question-related widgets (to prevent window from growing uncontrollably)
    question_frame = tk.Frame(root)
    question_frame.pack(pady=20)
    global question_map
    question_map = load_questions_from_json('fullName.json')
    return root, question_frame

def main():

    """ Main entry point for the application """
    env = clp.Environment()  # Initialize CLIPS environment
    env.load('Rule_based_engine.clp')  # Load the CLIPS rule file
    template = env.find_template("return")

    root, question_frame = init()  # Initialize tkinter window
    questions_asked = []  # Track which questions have been asked
    run(env,root, questions_asked, question_frame)  # Start the questioning process
    root.mainloop()  # Start the tkinter event loop

if __name__ == "__main__":
    main()