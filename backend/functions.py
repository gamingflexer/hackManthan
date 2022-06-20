from gevent import config
from pandas_profiling import ProfileReport
import pandas as pd
import os
from translate import Translator
from config import *

import pickle
import joblib
from geopy.geocoders import Nominatim

import matplotlib.pyplot as plt
# from sklearn.cluster import KMeans
import seaborn as sns; sns.set()
import csv
import pandas as pd

def translator(text):
    translator= Translator(from_lang="hindi",to_lang="english")
    translation = translator.translate(text)
    return translation

def pandas_profiling(file_path):
    data1 = pd.read_csv(file_path)
    
    file_name = os.path.splitext(file_path)[0]
    profile = ProfileReport (data1, title='Report - Crime Analysis', explorative=True)
    path_of_file = basepath+"/static/"+f'{file_name}_anylasis.html'
    profile.to_widgets()
    profile.to_file(path_of_file)
    
    return path_of_file


def kmeans_centers(file): #type of input
    data = pd.read_csv(file)
    data.dropna(axis=0,how='any',subset=['Latitude','Longitude'],inplace=True)
    
    X=data.loc[:,['Event','Latitude','Longitude']]

    K_clusters = range(1,10)
    kmeans = [KMeans(n_clusters=i) for i in K_clusters]
    Y_axis = data[['Latitude']]
    X_axis = data[['Longitude']]
    score = [kmeans[i].fit(Y_axis).score(Y_axis) for i in range(len(kmeans))]
    
    kmeans = KMeans(n_clusters = 3, init ='k-means++')
    kmeans.fit(X[X.columns[1:3]]) # Compute k-means clustering.
    X['cluster_label'] = kmeans.fit_predict(X[X.columns[1:3]])
    centers = kmeans.cluster_centers_ # Coordinates of cluster centers.
    labels = kmeans.predict(X[X.columns[1:3]]) # Labels of each point
    
    return {"centers":centers[0]}


def predict_violent(file): #type of input - change the input also 
    data = pd.read_csv(file)
    loaded_model = pickle.load(open(model_path, 'rb'))
    prediction = loaded_model.predict(data)
    return prediction
    
def predict_crime(address,DT):
    
    #load
    geolocator = Nominatim(user_agent="surve790@gmail.com")
    rfc = joblib.load(model_path_2)
    
    #function start
    location = geolocator.geocode(address,timeout=None)
    lat=[location.latitude]
    log=[location.longitude]
    latlong=pd.DataFrame({'latitude':lat,'longitude':log})
    print(latlong)

    latlong['timestamp']=DT
    data=latlong
    cols = data.columns.tolist()
    cols = cols[-1:] + cols[:-1]
    data = data[cols]

    data['timestamp'] = pd.to_datetime(data['timestamp'].astype(str), errors='coerce')
    data['timestamp'] = pd.to_datetime(data['timestamp'], format = '%d/%m/%Y %H:%M:%S')
    column_1 = data['timestamp']
    DT=pd.DataFrame({"year": column_1.dt.year,
            "month": column_1.dt.month,
            "day": column_1.dt.day,
            "hour": column_1.dt.hour,
            "dayofyear": column_1.dt.dayofyear,
            "week": column_1.dt.week,
            "weekofyear": column_1.dt.weekofyear,
            "dayofweek": column_1.dt.dayofweek,
            "weekday": column_1.dt.weekday,
            "quarter": column_1.dt.quarter,
            })
    data=data.drop('timestamp',axis=1)
    final=pd.concat([DT,data],axis=1)
    X=final.iloc[:,[1,2,3,4,6,10,11]].values
    my_prediction = rfc.predict(X)
    if my_prediction[0][0] == 1:
        my_prediction='Predicted crime : Act 379-Robbery'
    elif my_prediction[0][1] == 1:
        my_prediction='Predicted crime : Act 13-Gambling'
    elif my_prediction[0][2] == 1:
        my_prediction='Predicted crime : Act 279-Accident'
    elif my_prediction[0][3] == 1:
        my_prediction='Predicted crime : Act 323-Violence'
    elif my_prediction[0][4] == 1:
        my_prediction='Predicted crime : Act 302-Murder'
    elif my_prediction[0][5] == 1:
        my_prediction='Predicted crime : Act 363-kidnapping'
    else:
        my_prediction='Place is safe no crime expected at that timestamp.'
        
    return my_prediction
