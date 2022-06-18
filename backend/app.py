from email.mime import base
from flask import *
import firebase_admin
from firebase_admin import credentials, firestore, initialize_app, storage
import os
import pyrebase
from werkzeug.utils import secure_filename
from werkzeug.datastructures import  FileStorage
from functions import pandas_profiling
from config import *
import json

# Initialize Flask App
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = upload
app.config['SECRET_KEY'] = 'cairocoders-ednalan'

ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# Initialize Firestore DB
try:
    cred = credentials.Certificate("/Users/cosmos/Desktop/hackManthan/backend/config/serviceAccountKey.json")

    firebase_admin.initialize_app(cred, {'storageBucket': 'hackmanthan-lostminds.appspot.com'})

    db = firestore.client()
    bucket = storage.bucket()
    print("---------------------------> IN <--------------------------")
except:
    print("--------------------------------------> Not Logged in !")
    
    
@app.route('/get-clusters',methods=["POST", "GET"])
def clusters():
    #get crimes
    data = {}
    crime_ref = db.collection(u'crimes')
    docs = crime_ref.stream()

    for doc in docs:
        data1 = data.update({doc.id : doc.to_dict()})
        
    #change the fields acc to kmeans
    
    
    return data1


@app.route('/file-upload', methods=['POST'])
def upload_file():
    # check if the post request has the file part
    if 'file' not in request.files:
        resp = jsonify({'message' : 'No file part in the request'})
        resp.status_code = 400
        return resp
    file = request.files['file']
    if file.filename == '':
        resp = jsonify({'message' : 'No file selected for uploading'})
        resp.status_code = 400
        return resp
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        resp = jsonify({'message' : 'File successfully uploaded'})
        resp.status_code = 201
        path = pandas_profiling(basepath+"/"+filename)
        print(path)
        bucket = storage.bucket()
        blob = bucket.blob(path)
        blob.upload_from_filename(path)
        blob.make_public()
        return {"url":blob.public_url}
    else:
        resp = jsonify({'message' : 'Allowed file types are txt, pdf, png, jpg, jpeg, gif'})
        resp.status_code = 400
        return resp


#-------------------------------------->

@app.route('/001',methods=["POST", "GET"])
def graph_001():
    f = open(graph1)
    data1 = json.load(f)
    return data1

@app.route('/002',methods=["POST", "GET"])
def graph_002():
    f = open(graph2)
    data1 = json.load(f)
    return data1

@app.route('/003',methods=["POST", "GET"])
def graph_003():
    f = open(graph3)
    data1 = json.load(f)
    return data1

@app.route('/004',methods=["POST", "GET"])
def graph_004():
    f = open(graph4)
    data1 = json.load(f)
    return data1

@app.route('/005',methods=["POST", "GET"])
def graph_005():
    f = open(graph5)
    data1 = json.load(f)
    return data1

@app.route('/006',methods=["POST", "GET"])
def graph_006():
    f = open(graph6)
    data1 = json.load(f)
    return data1

@app.route('/007',methods=["POST", "GET"])
def graph_007():
    f = open(graph7)
    data1 = json.load(f)
    return data1

@app.route('/008',methods=["POST", "GET"])
def graph_008():
    f = open(graph8)
    data1 = json.load(f)
    return data1

#-------------------------------------->

port = int(os.environ.get('PORT', 8888))
if __name__ == '__main__':
    app.run(threaded=True,port=port,debug=True)