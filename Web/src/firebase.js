import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// import firebase from "firebase";
import {
    getFirestore
} from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyBT-kLbhsbPylhLdEJhcMqNlCb9ZUhHI2c",
    authDomain: "hackmanthan-lostminds.firebaseapp.com",
    projectId: "hackmanthan-lostminds",
    storageBucket: "hackmanthan-lostminds.appspot.com",
    messagingSenderId: "175124542913",
    appId: "1:175124542913:web:bb5cf553f4088a4430ab40",
    measurementId: "G-02V476G918"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

const db = getFirestore(app)

export default db;