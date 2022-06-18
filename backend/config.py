import os
basepath = os.path.dirname(os.path.realpath(__file__))

config_firebase ={
  "type": "service_account",
  "project_id": "hackmanthan-lostminds",
  "private_key_id": "e3417f892c775b6a501443583ada3c00136fd1ba",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQDD5ynjjLxtFvBk\nNAEwdJ+gMei/JEWUFd3h0ysJlr6Fo8MHs36wtDHfxw7l70T3t52XCdmMGilFZqoh\nECFDamqwQZM//RMxTU5NFNu4noAU0fLsl+FZwNjdD0BycJk2HqX+rtgxG3hSyolx\n5V1dVKWZF8KyMAOU3Js3EqrfmAxgUnHoHoVGGmTMTVFPVRxyApE2MJMEik0Ujr9F\nsgxc2LHDUfafKK/f3fVK73jAWq3/TbeTFNeMP2X3ZtJP+9bqBV4MhUqs+AC0lU0J\n4i33Zn4eBVyEV9xFd3igDhtlKutCz2tlzXfSApAGSYjszZV5v37lt+XMPQp5Ap/1\nEs/TbcTDAgMBAAECgf8uALlZkCSWtNWDJPzlER2eJYa8o53kUFjZrdBcBJBEH3EY\ngbTrddfRzFhN5e9VVw+M7F/g/lAAkJcfT084q22jyyrF1tgkyw3KRWJNOtKZbS6+\nMTHf3qnXAfAK2ySUDMlrFoMYklnKqLCRqQY4apbOhHT5hcOrpw/iYO1nPBsgo7m2\nMDYDk89GKRrswHDdZ4QkNBEP3F0SoxWApG6iY3tNKrorP3nPMgxV4ZUOdNHNtHFn\np/bM3OBrObRlIqqTlkMgGyRdSdC7EQDzpyerH1RlJGyUGkHvCHkVZuUeO0Jio7BI\nTL75GpxCnHE6YL8Du6O3dNgWbeD0jGLRPTTcwBECgYEA7H3JX3ulXnGPkMUMbg71\nl8NTeDZ2t7Co+UZTkIeuFiCS1JEDzfMMDfbxljSREWOD7+VINlYVc3Kebu4L1D7P\nIBS6J9MpRgB0xe0Pzbcoddr5nJmykmPySZ36o0HnKS/atUHDdgTrUtu8guAo3yLR\nKF07SRTlpKQb10+j/oRA/hECgYEA1BA70vrmREHlgxf3eWR56vIFutkmmo/Kdwfx\nup3E/BssOzb6OhGvECUxunEM9owZMpM7BW/Cf2oq2GKitJp/ERUbiaOYlIA8GFDb\nZGsTk0A8TJPl+32OFKvFTrYrjBLgTANIE4M5aTKismrbKOgHMsXGPvZcU9vn+IDx\nJLew0ZMCgYEAjAOZAsgAy16uogaX6l0++GAzffu4495a3GLPvMUnw3/7jpBg0UEx\nhN8Mf2KV9NaXWaPE0i67OoPE22ZiaIHbPWIoKMXzLLe+aySEc8YZ1VUU7atttxAn\ndYBr0NaG1rK3aRMLd0dIT+E6xb2TVTCW5q/0Fruhjo1+0kYbkOeaVxECgYBKL8+t\n9GY/9Mmk/epuhk78eWS1xCf0JF+RGq9fOLhj9eGYaZhKXktfG5P1BH2jdsmN3uHj\n+gAR8QNCJeeDxRS01iyHDzteoCnl28uUqrzzY6J0q7zmKTteUeU5rxM28peTIAbE\nBME94x/1yNoYymtSQMwk1KziDWlujzVNQhHSjwKBgAkd2/hawMOZr7lYsoX3h/lc\nDnt0+Hh/aEMi0RWyjC+9uYc99AqeA82bDY/gX8vfFPNflt1kFWqoxQiKXdvzfsTS\nGOhkuBdxSIuMDcPzjYnIRnIqyA9/nfxtZpNy4TIZyFcuZJSX+N/iDMBpdsh2CbEM\nUbQi1gkPH0HWN5XepP9+\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-wenu3@hackmanthan-lostminds.iam.gserviceaccount.com",
  "client_id": "107259094300644066352",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-wenu3%40hackmanthan-lostminds.iam.gserviceaccount.com"
}

model_path = os.path.join(basepath,"models","violent_crime.sav") 

model_path_2 = os.path.join(basepath,"models","predict_crime")

upload = os.path.join(basepath,"static")


temp_path = basepath.split("/")
temp_path.remove("backend")
basepath2 = '/'.join(temp_path)


graph1 = os.path.join(basepath2,"data","graphs","001_most_freq_event.json")
graph2 = os.path.join(basepath2,"data","graphs","002_no_event_updated_by_date.json")
graph3 = os.path.join(basepath2,"data","graphs","003_no_event_updated_by_days.json")
graph4 = os.path.join(basepath2,"data","graphs","004_no_event_updated_by_hour.json")
graph5 = os.path.join(basepath2,"data","graphs","005_event_byevent_type_001.json")
graph6 = os.path.join(basepath2,"data","graphs","006_event_by_hour_002.json")
graph7 = os.path.join(basepath2,"data","graphs","007_scatter_plot_peek_time_crime.json")
graph8 = os.path.join(basepath2,"data","graphs","008_no_of_cases_in_important_event_type.json")