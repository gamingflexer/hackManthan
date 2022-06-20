from email.mime import base
from flask import *
import firebase_admin
from firebase_admin import credentials, firestore, initialize_app, storage
import os
import time
import pyrebase
from flask_cors import CORS, cross_origin
from werkzeug.utils import secure_filename
from werkzeug.datastructures import  FileStorage
from functions import pandas_profiling,predict_crime
from config import *
import json

#constant functions
def _build_cors_preflight_response():
    response = make_response()
    response.headers.add("Access-Control-Allow-Origin", "*")
    response.headers.add('Access-Control-Allow-Headers', "*")
    response.headers.add('Access-Control-Allow-Methods', "*")
    return response

def _corsify_actual_response(response):
    response.headers.add("Access-Control-Allow-Origin", "*")
    return response

# Initialize Flask App
app = Flask(__name__)
CORS(app, resources={r"/api/": {"origins": ""}})
cors = CORS(app, supports_credentials=True)


app.config['CORS_HEADERS'] = 'Content-Type'
app.config['UPLOAD_FOLDER'] = upload
app.config['SECRET_KEY'] = 'cairocoders-ednalan'

ALLOWED_EXTENSIONS = {'csv'}

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
           
def format_server_time():
  server_time = time.localtime()
  return time.strftime("%I:%M:%S %p", server_time)
           

# Initialize Firestore DB
try:
    cred = credentials.Certificate(basepath+"/config/serviceAccountKey.json")

    firebase_admin.initialize_app(cred, {'storageBucket': 'hackmanthan-lostminds.appspot.com'})

    db = firestore.client()
    bucket = storage.bucket()
    print("---------------------------> IN <--------------------------")
except Exception as e:
    print(e)
    print("--------------------------------------> Not Logged in !")
    
    
@app.route('/index')
@cross_origin()
def index():
    context = { 'server_time': format_server_time() }
    return render_template('index.html', context=context)

#-------------------------------------->

@app.route('/get-clusters',methods=["POST", "GET"])
@cross_origin()
def clusters():
    #get crimes
    data = {}
    crime_ref = db.collection(u'crimes')
    docs = crime_ref.stream()

    for doc in docs:
        data1 = data.update({doc.id : doc.to_dict()})
    print(data1)
    #change the fields acc to kmeans
    return {"data":data1}


@app.route('/predict-voilent',methods=["POST", "GET"])
@cross_origin()
def voilent():
    #take all from the firebase
    #convert them for the model
    #get the output and make the firebase update request
    #send response okay
    resp = jsonify({'message' : 'testing'})
    resp.status_code = 201
    return resp

#-------------------------------------->

@app.route('/predict-crime',methods=["POST", "GET"])
@cross_origin()
def crime():
    data_base = {}
    crime_ref = db.collection(u'predict_crime')
    docs = crime_ref.stream()
    #fetch
    for doc in docs:
        data1 = data_base.update({doc.id : doc.to_dict()})
    #diff in vvariables
    for i in data_base:
        if data_base[i]['prediction']== "":
            address = data_base[i]['location']
            DT = data_base[i]['date']
            out = predict_crime(address,DT)
    return {"prediction":out}

#-------------------------------------->

@app.route('/file-upload', methods=['POST'])
@cross_origin()
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
        print(filename)
        print(basepath+"/static/"+filename+"#-------------------------------------->")
        path = pandas_profiling(basepath+"/static/"+filename)
        bucket = storage.bucket()
        blob = bucket.blob(path)
        blob.upload_from_filename(path)
        blob.make_public()
        return {"url":blob.public_url}
    else:
        resp = jsonify({'message' : 'Allowed file types are CSV'})
        resp.status_code = 400
        return resp


#-------------------------------------->

@app.route('/001',methods=["POST", "GET"])
@cross_origin()
def graph_001():
    if request.method == "OPTIONS": # CORS preflight
        return _build_cors_preflight_response()
    elif request.method == "GET":
        f = open(graph1)
        data1 = json.load(f)
        return data1

@app.route('/002',methods=["POST", "GET"])
@cross_origin()
def graph_002():
    f = open(graph2)
    data1 = json.load(f)
    return data1

@app.route('/003',methods=["POST", "GET"])
@cross_origin()
def graph_003():
    f = open(graph3)
    data1 = json.load(f)
    return data1

@app.route('/004',methods=["POST", "GET"])
@cross_origin()
def graph_004():
    f = open(graph4)
    data1 = json.load(f)
    return data1

@app.route('/005',methods=["POST", "GET"])
@cross_origin()
def graph_005():
    f = open(graph5)
    data1 = json.load(f)
    return data1

@app.route('/006',methods=["POST", "GET"])
@cross_origin()
def graph_006():
    f = open(graph6)
    data1 = json.load(f)
    return data1

@app.route('/007',methods=["POST", "GET"])
@cross_origin()
def graph_007():
    f = open(graph7)
    data1 = json.load(f)
    return data1

@app.route('/008',methods=["POST", "GET"])
@cross_origin()
def graph_008():
    f = open(graph8)
    data1 = json.load(f)
    return data1

@app.route('/test',methods=["POST", "GET"])
@cross_origin()
def test():
    return "OK 200"

#-------------------------------------->

port = int(os.environ.get('PORT', 8888))
if __name__ == '__main__':
    app.run(host='0.0.0.0',threaded=True,port=port,debug=True)