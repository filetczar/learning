from flask import Flask, request
app = Flask(__name__)


@app.route('/')
def index():
    user_agent = request.headers.get('User-Agent')
    return '<p>Your browser is {}</p>'.format(user_agent)


@app.route('/user/<name>')
def user(name):
    if name == 'Phil':
        text = 'I hope you enjoy some beers and laughs!'
    elif name == "Michelle":
        text = "Please don't try to steal a goat...again."
    else:
        text = "Have a wonderful day!"

    return '<h1>Hello, %s!</h1><br><h2>%s</h2>' % (name,text)
