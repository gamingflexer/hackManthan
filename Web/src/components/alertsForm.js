import { Formik, Form, Field, ErrorMessage } from "formik";
import { TextField } from "@mui/material";
import { makeStyles } from '@material-ui/core/styles'
import { useState } from "react";
import { blue } from "@mui/material/colors";
import { border, color, fontWeight } from "@mui/system";

const DataForm = () => {

    const [title, setTitle] = useState("")
    const [message, setMessage] = useState("")
    const [sendTo, setSendTo] = useState("")
    const [priority, setPriority] = useState("")
    const [label4, setLabel4] = useState("")

    const handleReset = () => {
        setTitle("")
        setMessage("")
        setSendTo("")
        setPriority("")
        setLabel4("")
    }

    const handleSubmit = () => {
        console.log(title, message, sendTo, priority, label4)
    }


    return <>
        <Formik
            initialValues={{ name: "", email: "", acceptedTerms: false }}
            validate={(values) => {
                const errors = {};
                if (title) {
                    errors.name = "Required";
                }

                if (message) {
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
                    <TextFieldData label={"Message"} value={message} setValue={setMessage} multiline={true} />
                    <TextFieldData label={"Send To"} value={sendTo} setValue={setSendTo} multiline={false} />
                    <TextFieldData label={"Priority"} value={priority} setValue={setPriority} multiline={false} />
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