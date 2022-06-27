import { Formik, Form, Field, ErrorMessage } from "formik";
import { TextField } from "@mui/material";
import { makeStyles } from '@material-ui/core/styles'
import { useState } from "react";
import { blue } from "@mui/material/colors";
import { border, color, fontWeight } from "@mui/system";
import db from "src/firebase";
import { query, onSnapshot, getDocs, collection, doc, setDoc, addDoc } from "firebase/firestore"
import axios from 'axios';


const PredictForm = () => {
    const [time, setTime] = useState("")
    const [location, setLocation] = useState("")
    const [prediction, setprediction] = useState("")


    const handleReset = () => {
        setTime("")
        setLocation("")
    }

    const handleSubmit = async () => {
        // console.log(time, location, eventType, subEventType, isLive)
        var today = new Date()
        // console.log(today.getFullYear(), today.getMonth(), today.getDate())
        const timeArr = time.split(":")
        console.log(timeArr)
        let timestamp = new Date(today.getFullYear(), today.getMonth(), today.getDate(), timeArr[0], timeArr[1])
        console.log(timestamp)
        const res = await addDoc(collection(db, "predict_crime"), {
            location: location,
            date: timestamp,
            prediction: ""
        });
        console.log(res)

        fetch(
            "http://20.26.235.201:8888/predict-crime", {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
            .then((res) => res.json())
            .then((json) => {
                console.log("Hi")
                console.log(json)
                // setprediction(json)
            })
            .catch((error) => {
                console.log(error)
            })

        // handleReset()
    }


    return <>
        <Formik
            initialValues={{ name: "", email: "", acceptedTerms: false }}
            validate={(values) => {
                const errors = {};
                if (time) {
                    errors.name = "Required";
                }

                if (location) {
                    errors.email = "Required";
                } else if (
                    !/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i.test(values.email)
                ) {
                    errors.email = "Invalid email address";
                }
                return errors;
            }}
            onSubmit={(values, { setSubmitting }) => {
                // post data to server
                alert(JSON.stringify(values, null, 2));
                setSubmitting(false);
            }}
        >
            {({ isSubmitting, dirty }) => (
                <Form >
                    <TextFieldData label={"Location"} value={location} setValue={setLocation} multiline={false} />
                    <TextFieldData label={"Time"} value={time} setValue={setTime} multiline={false} />
                    <div style={{
                        display: "flex",
                        flexDirection: "row",
                        justifyContent: "center",
                        width: "80%",
                        marginTop: 40,
                        gap: 30
                    }}>
                        <button
                            type="button"
                            onClick={handleReset}
                            style={{
                                alignSelf: "center",
                                width: "20%",
                                padding: 10,
                                cursor: "pointer",
                                fontSize: 18,
                                backgroundColor: "blue",
                                border: 0,
                                color: "white",
                                fontWeight: 200,
                                borderRadius: 10
                            }}>
                            Reset
                        </button>
                        <button type="submit" disabled={isSubmitting}
                            onClick={handleSubmit}
                            style={{
                                alignSelf: "center",
                                width: "20%",
                                padding: 10,
                                cursor: "pointer",
                                fontSize: 18,
                                backgroundColor: "blue",
                                border: 0,
                                color: "white",
                                fontWeight: 200,
                                borderRadius: 10
                            }}>
                            Submit
                        </button>
                    </div>

                </Form>
            )}
        </Formik>
    </>
};

export default PredictForm;

const TextFieldData = ({ value, setValue, label, multiline }) => {
    const classes = useStyles()

    return <div style={{
        marginTop: 30,
        marginBottom: 10,
        width: "80%",
    }}>
        <label style={{
            marginLeft: 8,
            display: "grid",
            gridTemplateColumns: "15% 85%",
            flexDirection: "row",
            alignItems: "center"
        }}>
            <div style={{
                fontSize: 20
            }}>
                {label}
            </div>
            <TextField type="text" name="name"
                multiline={multiline}
                minRows={multiline ? 3 : 1}
                value={value}
                onChange={(e) => { setValue(e.target.value) }}
                InputLabelProps={{
                    classes: {
                        root: classes.textFieldLabel,
                        focused: classes.textFieldLabelFocused
                    }
                }}
                InputProps={{
                    classes: {
                        root: classes.textFieldRoot,
                        focused: classes.textFieldFocused,
                        notchedOutline: classes.textFieldNotchedOutline
                    }
                }}
                style={{
                    width: "100%",
                    marginLeft: 15,
                }} />
        </label>
        <ErrorMessage name={label} component="span" />
    </div>
}

const useStyles = makeStyles(theme => ({
    textFieldFocused: {},
    textFieldNotchedOutline: {
        borderWidth: '1px',
        borderColor: 'black !important'
    }
}));