from flask import Flask, render_template

app = Flask(__name__)

@app.route('/home')
def home():
    # Render the HTML file (index.html) from the templates folder
    return render_template('index.html')

if __name__ == '__main__':
    # Run the Flask app on port 5001 and make it accessible externally
    app.run(host='0.0.0.0')

