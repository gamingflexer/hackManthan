from crypt import methods
from distutils.log import debug
from logging import exception
import os
from os.path import join
import time
import pyrebase
from pexpect import ExceptionPexpect
from flask import Flask, request, jsonify, render_template
from firebase_admin import credentials, firestore, initialize_app, storage
from flask_cors import CORS, cross_origin
from model import ocr,spacy_700
#from config import config_firebase
import random as ran



# Initialize Flask App
app = Flask(__name__)
CORS(app, support_credentials=True)

@app.route('/list',methods=["POST", "GET"])
def main():
    return

port = int(os.environ.get('PORT', 8080))
if __name__ == '__main__':
    app.run(threaded=True,port=port,debug=True)