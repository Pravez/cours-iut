from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Bonjour l'IUT ! Depuis Terraform !</p>"

app.run(host='0.0.0.0')