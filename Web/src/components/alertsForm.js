import { Formik, Form, Field, ErrorMessage } from "formik";
import { TextField } from "@mui/material";
import { makeStyles } from '@material-ui/core/styles'
import { useState } from "react";
import { blue } from "@mui/material/colors";
import { border, color, fontWeight } from "@mui/system";
import Select from '@mui/material/Select';
import MenuItem from '@mui/material/MenuItem';
import db from "src/firebase";
import { query, onSnapshot, getDocs, collection, doc, setDoc, addDoc } from "firebase/firestore"


const DataForm = () => {

    const [title, setTitle] = useState("")
    const [description, setDescription] = useState("")
    const [lat, setLat] = useState("")
    const [long, setLong] = useState("")
    const [priority, setPriority] = useState("")
    const [label4, setLabel4] = useState("")
    const listOfWards = ["Ward1", "Ward2", "Ward3"]
    const priotityList = ["high", "medium", "low"]

    const handleReset = () => {
        setTitle("")
        setDescription("")
        setLat("")
        setPriority("")
        setLong("")
    }

    const handleSubmit = async () => {
        // console.log(title, description, ward, priority, label4)
        // db.collection("alerts").add({
        // alert: message,
        // authBy: authBy,
        // ward: ward,
        // priority: priority
        // })

        const res = await addDoc(collection(db, "alerts"), {
            title: title,
            description: description,
            lat: parseFloat(lat),
            long: parseFloat(long),
            priority: priority
        });
        console.log(res)
        handleReset()
        // const q = query(collection(db, "alerts"))
        // console.log(q)
        // console.log(await getDocs(collection(db, "alerts")))
        // await getDocs(collection(db, "alerts")).then((querySnapshot) => {

        //     // Loop through the data and store
        //     // it in array to display
        //     querySnapshot.forEach(element => {
        //         var data = element.data();
        //         console.log(data)
        //     });
        // })
        // firestore
        // .getDocs(firestore.collection(db, "quiz"))
        // .then((querySnapshot) => {
        //     querySnapshot.forEach((doc) => {
        //         console.log(`${doc.id} => ${doc.data()}`);
        //     });
        // });
    }


    return <>
        <Formik
            initialValues={{ name: "", email: "", acceptedTerms: false }}
            validate={(values) => {
                const errors = {};
                if (title) {
                    errors.name = "Required";
                }

                if (description) {
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
                    <TextFieldData label={"Title"} value={title} setValue={setTitle} />
                    <TextFieldData label={"Description"} value={description} setValue={setDescription} multiline={true} />
                    <TextFieldData label={"Latitude"} value={lat} setValue={setLat} />
                    <TextFieldData label={"Longitude"} value={long} setValue={setLong} />
                    {/* <SelectData value={ward} setValue={setWard} label={"Ward"} listOfValues={listOfWards} /> */}
                    <SelectData value={priority} setValue={setPriority} label={"Priority"} listOfValues={priotityList} />
                    {/* <TextFieldData label={"Send To"} value={ward} setValue={setWard} multiline={false} /> */}
                    {/* <TextFieldData label={"Priority"} value={priority} setValue={setPriority} multiline={false} /> */}
                    {/* <TextFieldData label={"Label4"} value={label4} setValue={setLabel4} multiline={true} /> */}
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
                            Send
                        </button>
                    </div>

                </Form>
            )}
        </Formik>
    </>
};

export default DataForm;


const SelectData = ({ value, setValue, label, listOfValues }) => {

    const classes = useStyles()


    return <div style={{
        display: "grid",
        marginTop: 30,
        marginBottom: 10,
        width: "80%",
        marginLeft: 8,
        display: "grid",
        gridTemplateColumns: "14% 86%",
        flexDirection: "row",
        alignItems: "center"
    }}>
        <div style={{
            fontSize: 20
        }}>
            {label}
        </div>
        <Select
            labelId="demo-simple-select-label"
            id="demo-simple-select"
            value={value}
            label={label}
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
                marginLeft: 20
            }}
        >
            {listOfValues.map((value) => (
                <MenuItem value={value}>{value}</MenuItem>
            ))}
        </Select>
    </div>
}

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