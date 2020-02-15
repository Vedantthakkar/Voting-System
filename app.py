import simplejson as json
from web3 import Web3
from flask import Flask,request
import requests


app = Flask(__name__)
@app.route('/')
def hello_world():
    return "Hello world"

@app.route('/vote',methods=['POST'])
def hello():
    print("hello")
    return "HELLO"   


if __name__ == "__main__":
    app.run(host='127.0.0.1',port='8000')