from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('career_recommendation_form.html')  # Serving the HTML page

@app.route('/get_recommendation', methods=['POST'])
def get_recommendation():
    # Get form data from the front-end
    academic_score = request.form['academicScore']
    skills = request.form.getlist('skills')  # Multiple selected options
    interests = request.form.getlist('interests')  # Multiple selected options
    openness = request.form['openness']
    conscientiousness = request.form['conscientiousness']
    extraversion = request.form['extraversion']
    neuroticism = request.form['neuroticism']

    # Career recommendation logic based on form data
    career_path = ''
    short_term_goals = []
    medium_term_goals = []
    long_term_goals = []

    if 'Programming' in skills and 'Technology' in interests:
        career_path = "Software Development"
        short_term_goals = ["Learn Python or Java", "Build Projects"]
        medium_term_goals = ["Apply for internships in tech companies"]
        long_term_goals = ["Become a Senior Software Engineer or CTO"]
    elif 'Design' in skills and 'Art' in interests:
        career_path = "Creative Design"
        short_term_goals = ["Learn graphic design tools (e.g., Photoshop)"]
        medium_term_goals = ["Freelance as a designer or join a creative agency"]
        long_term_goals = ["Become a Creative Director or Animator"]
    elif 'Leadership' in skills and 'Business' in interests:
        career_path = "Management"
        short_term_goals = ["Develop team management skills"]
        medium_term_goals = ["Work as a project manager"]
        long_term_goals = ["Climb to senior leadership roles like CEO"]
    else:
        career_path = "Generalist"
        short_term_goals = ["Explore multiple skills"]
        medium_term_goals = ["Work in roles like content writer or teacher"]
        long_term_goals = ["Specialize based on further experience"]

    # Return the results as a dictionary
    return render_template('result.html',
                           career_path=career_path,
                           short_term_goals=short_term_goals,
                           medium_term_goals=medium_term_goals,
                           long_term_goals=long_term_goals)

if __name__ == '__main__':
    app.run(debug=True)
