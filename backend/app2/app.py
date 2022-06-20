from email.mime import base
from flask import *
import firebase_admin
from firebase_admin import credentials, firestore, initialize_app, storage
import os
import time
import pandas as pd
import pyrebase
from flask_cors import CORS, cross_origin
from werkzeug.utils import secure_filename
from werkzeug.datastructures import  FileStorage
from functions import pandas_profiling,predict_crime,kmeans_centers,delete_collection
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
        
    #doc delete old
    cluster_ref = db.collection(u'cluster_test')
    delete_collection(cluster_ref,3)
    #add new ones
    for i in event_type:
        a = data.loc[data["eventType"] == i]
        centers = kmeans_centers(a)
        try:
            out_fin = pd.DataFrame(centers).to_json(orient='split')
            print(out_fin)
            res = json.loads(out_fin)
            test = {"eventType":i,"center1":res['data'][0],"center2":res['data'][1],"center3":res['data'][2],"lastUpdated":firestore.SERVER_TIMESTAMP}
            print(test)
            db.collection("cluster_test").add(test)
        except:
            pass
    return "OK ADDED"



#-------------------------------------->

port = int(os.environ.get('PORT', 8889))
if __name__ == '__main__':
    app.run(host='0.0.0.0',threaded=True,port=port,debug=True)