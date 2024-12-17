import tkinter as tk
import clips as clp
import json

def load_questions_from_json(json_file):
    with open(json_file, 'r') as f:
        return json.load(f)

def get_questions_and_options(env):
    """ Extract all questions and their available options from the CLIPS environment """
    questions = {}
    question_map = load_questions_from_json('fullName.json')
    env.run()  # Process rules and facts to get the current state

    # Loop through all facts in the environment and gather questions with options
    for fact in env.facts():
        if fact.template.name == "response-to-query":
            query = fact["query"]
            query = question_map.get(query, query)  # Default to query if not found in map
            options = fact["options"]
            questions[query] = options
    
    return questions

def ask_question(env, root, question, options, questions_asked, question_frame):
    """ Create a question and present options using tkinter widgets """
    # Clear the previous widgets (if any) in the frame
    for widget in question_frame.winfo_children():
        widget.destroy()

    # Create a label for the current question
    question_label = tk.Label(question_frame, text=question, font=("Arial", 14))
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
            fact_string = f"(to-change (query \"{question}\") (response \"{user_choice}\"))"
            print(f"Asserting fact: {fact_string}")
            env.assert_string(fact_string)  # Update the CLIPS environment with the user's choice
            env.run()

            for fact in env.facts():
                if fact.template.name == "result-animal":
                        result_label = tk.Label(question_frame, text=fact, font=("Arial", 14))
                        result_label.pack(pady=10)
                        print(fact)
            # Mark the current question as answered
            questions_asked.append(question)

            # Call run again to show the next question
            root.after(500, run, env, root, questions_asked, question_frame)  # 500 ms delay to refresh the GUI

    # Create a submit button to confirm the user's selection
    submit_button = tk.Button(question_frame, text="Submit", command=submit, font=("Arial", 12))
    submit_button.pack(pady=20)

def run(env, root, questions_asked, question_frame):
    """ Main function to run the application, show questions and collect responses """
    # Retrieve questions and their options from the CLIPS environment
    questions = get_questions_and_options(env)

    # Check if there are any questions left to ask
    remaining_questions = {q: options for q, options in questions.items() if q not in questions_asked}

    # Get the next question from the remaining ones
    next_question = list(remaining_questions.keys())[0]
    options = remaining_questions[next_question]

    # Call the function to ask the current question and present options
    ask_question(env, root, next_question, options, questions_asked, question_frame)

def init():
    """ Initialize the main tkinter window """
    root = tk.Tk()
    root.title("What species did you evolve from?")

    # Create a frame to hold all question-related widgets (to prevent window from growing uncontrollably)
    question_frame = tk.Frame(root)
    question_frame.pack(pady=20)

    return root, question_frame

def main():

    """ Main entry point for the application """
    env = clp.Environment()  # Initialize CLIPS environment
    env.load('Rule_based_engine.clp')  # Load the CLIPS rule file
    root, question_frame = init()  # Initialize tkinter window
    questions_asked = []  # Track which questions have been asked
    run(env, root, questions_asked, question_frame)  # Start the questioning process
    root.mainloop()  # Start the tkinter event loop

if __name__ == "__main__":
    main()