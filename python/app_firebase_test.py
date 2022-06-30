import firebase_admin
from firebase_admin import credentials, firestore
import threading
from time import sleep

cred1 = credentials. Certificate(
    "/Users/cosmos/Desktop/hackManthan/backend/config/serviceAccountKey.json")
firebase_admin.initialize_app(cred1)

db = firestore.client()

# read data
users_ref = db.collection(u'users')
docs = users_ref.stream()

for doc in docs:
    print(f'{doc.id} => {doc.to_dict()}')

#docs = clus_ref.where(u'lastUpdated', u'==', 'x@x.com').stream()

# # add data crimes
# doc_ref = db.collection(u'crimes').document(u'id2')
# doc_ref.set(
#   {'day': 16, 'min': 0, 'eventId': 'P01042100004', 'source': 'Phone', 'sec': 0, 'dayOfWeek': 'Thursday', 'circle': 'C1', 'year': '2022', 'hr': 10, 'eventType\t': 'Threat In Person', 'policeStation\t': 'PS1', 'month': 6, 'eventSubType\t': 'Attack', 'district': 'Lucknow'}
# )

# add data users
doc_ref = db.collection(u'users').document(u'id2')
doc_ref.set({'policeStation': 'PS1CS', 'ward': 'P1', 'district': 'Bilaspur', 'email': 'user1@police.com', 'uid': '2022PS1', 'post': 'Chief Officer', 'lastUpdated': 0, 'currentGeo': 0, 'name': 'Shri Ashok Juneja', 'policeld': '2022PID001'})