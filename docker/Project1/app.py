from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World version 2!</p>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)  # Make sure the app runs on all interfaces (0.0.0.0)
