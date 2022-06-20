import { Formik, Form, Field, ErrorMessage } from "formik";
import { TextField } from "@mui/material";
import { makeStyles } from '@material-ui/core/styles'
import { useState } from "react";
import { blue } from "@mui/material/colors";
import { border, color, fontWeight } from "@mui/system";
import db from "src/firebase";
import { query, onSnapshot, getDocs, collection, doc, setDoc, addDoc } from "firebase/firestore"
import Select from 'react-select'


const DataForm = () => {

    const [circle, setCrime] = useState("")
    const [district, setDistrict] = useState("")
    const [eventType, setEventType] = useState("")
    const [subEventType, setSubEventType] = useState("")
    const [isLive, setIsLive] = useState(false)
    const [isLiveLabel, setIsLiveLabel] = useState("False")
    const [isViolent, setIsViolent] = useState(false)
    const [isViolentLabel, setIsViolentLabel] = useState("False")
    const [lat, setLat] = useState(0)
    const [long, setLong] = useState(0)
    const [policeStation, setPoliceStation] = useState("")
    const [source, setSouce] = useState("")
    const [time, setTime] = useState("")
    const [value, onChange] = useState(new Date());

    const options = [
        { value: true, label: 'True' },
        { value: false, label: 'False' },
    ]

    const handleReset = () => {
        setCrime("")
        setDistrict("")
        setEventType("")
        setSubEventType("")
        setIsLive("")
        setIsViolent("")
        setLat("")
        setLong("")
        setPoliceStation("")
        setSouce("")
        setTime("")
    }

    const handleChange = ({ value, label }) => {
        setIsLive(value)
        setIsLiveLabel(label)
    }

    const handleChangeViolent = ({ value, label }) => {
        setIsViolent(value)
        setIsViolentLabel(label)
    }

    const handleSubmit = async () => {
        console.log(circle, district, eventType, subEventType, isLive)
        var today = new Date()
        // console.log(today.getFullYear(), today.getMonth(), today.getDate())
        const timeArr = time.split(":")
        console.log(timeArr)
        let timestamp = new Date(today.getFullYear(), today.getMonth(), today.getDate(), timeArr[0], timeArr[1])
        const res = await addDoc(collection(db, "crimes"), {
            circle: circle,
            district: district,
            eventType: eventType,
            subEventType: subEventType,
            isLive: isLive,
            isViolent: isViolent,
            lat: parseFloat(lat),
            long: parseFloat(long),
            policeStation: policeStation,
            source: source,
            time: timestamp
        });
        console.log(res)
        handleReset()
    }


    return <>
        <Formik
            initialValues={{ name: "", email: "", acceptedTerms: false }}
            validate={(values) => {
                const errors = {};
                if (circle) {
                    errors.name = "Required";
                }

                if (district) {
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
                    <TextFieldData label={"Circle"} value={circle} setValue={setCrime} />
                    <TextFieldData label={"District"} value={district} setValue={setDistrict} multiline={false} />
                    <TextFieldData label={"Event Type"} value={eventType} setValue={setEventType} multiline={false} />
                    <TextFieldData label={"Event Sub Type"} value={subEventType} setValue={setSubEventType} multiline={false} />
                    <div style={{
                        marginTop: 30,
                        marginBottom: 10,
                        width: "80%",
                    }}>
                        <label style={{
                            marginLeft: 8,
                            display: "grid",
                            gridTemplateColumns: "17% 80%",
                            flexDirection: "row",
                            alignItems: "center"
                        }}>
                            <div style={{
                                fontSize: 20
                            }}>
                                {"Is Live"}
                            </div>
                            <Select
                                options={options}
                                value={{ value: isLive, label: isLiveLabel }}
                                onChange={(value) => handleChange(value)}
                                style={{
                                    innerHeight: 40,
                                    outerHeight: 40
                                }}
                            />
                        </label>
                    </div>
                    <div style={{
                        marginTop: 30,
                        marginBottom: 10,
                        width: "80%",
                    }}>
                        <label style={{
                            marginLeft: 8,
                            display: "grid",
                            gridTemplateColumns: "17% 80%",
                            flexDirection: "row",
                            alignItems: "center"
                        }}>
                            <div style={{
                                fontSize: 20
                            }}>
                                {"Is Violent"}
                            </div>
                            <Select
                                options={options}
                                value={{ value: isViolent, label: isViolentLabel }}
                                onChange={(value) => handleChangeViolent(value)}
                                style={{
                                    innerHeight: 40,
                                    outerHeight: 40
                                }}
                            />
                        </label>
                    </div>
                    {/* <TextFieldData label={"Is Live"} value={isLive} setValue={setIsLive} multiline={false} /> */}
                    {/* <TextFieldData label={"Is Violent"} value={isViolent} setValue={setIsViolent} multiline={false} /> */}
                    <TextFieldData label={"Latitude"} value={lat} setValue={setLat} multiline={false} />
                    <TextFieldData label={"Longitude"} value={long} setValue={setLong} multiline={false} />
                    <TextFieldData label={"Police Station"} value={policeStation} setValue={setPoliceStation} multiline={false} />
                    <TextFieldData label={"Source"} value={source} setValue={setSouce} multiline={false} />
                    <TextFieldData label={"Time"} value={time} setValue={setTime} multiline={false} />
                    <p>Please enter time in HH:MM form and in 24hr form</p>
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

export default DataForm;

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