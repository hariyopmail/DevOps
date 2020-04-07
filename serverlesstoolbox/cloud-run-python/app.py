import os

from flask import Flask
from flask import render_template, request

app = Flask(__name__)


@app.route('/')
def form():
    return render_template('form.html')


@app.route('/', methods=['POST'])
def my_form_post():
    milli = request.form['milli']
    inches = round((float(milli) / 25.4), 4)
    return render_template('form.html',
                           milli=milli,
                           inches=inches)


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0',
            port=int(os.environ.get(
                     'PORT', 8080)))
