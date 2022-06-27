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
    const [eventTypeLabel, setEventTypeLabel] = useState("")
    const [subEventType, setSubEventType] = useState("")
    const [subEventTypeLabel, setSubEventTypeLabel] = useState("")
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

    const eventTypeOptions = [
        { value: 'Information Against Police', label: 'Information Against Police' },
        { value: 'Threat In Person', label: 'Threat In Person' },
        { value: 'Dispute', label: 'Dispute' },
        { value: 'Gambling', label: 'Gambling' },
        { value: 'Missing', label: 'Missing' },
        { value: 'Theft', label: 'Theft' },
        { value: 'Domestic Violence', label: 'Domestic Violence' },
        { value: 'Property Disputes', label: 'Property Disputes' },
        { value: 'Illegal Mining', label: 'Illegal Mining' },
        { value: 'Suicide', label: 'Suicide' },
        { value: 'Corona', label: 'Corona' },
        { value: 'Cyber Crimes', label: 'Cyber Crimes' },
        { value: 'Female Sexual Harrassment', label: 'Female Sexual Harrassment' },
        { value: 'Unclaimed Information', label: 'Unclaimed Information' },
        { value: 'Encroachment', label: 'Enroachment' },
        { value: 'Crime On Phone Mobile Social Media Internet', label: 'Crime On Phone Mobile Social Media Internet' },
        { value: 'Animals Related', label: 'Animals Related' },
        { value: 'Unknown', label: 'Unknown' },
        { value: 'Robbery', label: 'Robbery' },
        { value: 'Pollution', label: 'Pollution' },
        { value: 'Information Against Other Government Departments', label: 'Information Against Other Government Departments' },
        { value: 'Medium Fire', label: 'Medium Fire' },
        { value: 'Child Crime(Sexual Abuse)', label: 'Child Crime(Sexual Abuse)' },
        { value: 'Found Deadbody', label: 'Found Deadbody' },
        { value: 'Suspicious Object Information', label: 'Suspicious Object Information' },
        { value: 'Threat On Phone Email Social Media', label: 'Threat On Phone Email Social Media' },
        { value: 'Dacoity', label: 'Dacoity' },
        { value: 'Attempted Murder', label: 'Attempted Murder' },
        { value: 'Suspicious Person Information', label: 'Suspicious Person Information' },
        { value: 'Forgery', label: 'Forgery' },
        { value: 'Female Harrassment', label: 'Female Harrassment' },
        { value: 'Kidnap', label: 'Kidnap' },
        { value: 'Excise Act Offenses', label: 'Excise Act Offenses' },
        { value: 'Accident', label: 'Accident' },
        { value: 'Ndps Act Offenses', label: 'Ndps Act Offenses' },
        { value: 'Police Help Required By 108', label: 'Police Help Required By 108' },
        { value: 'Escort For Safety', label: 'Escort For Safety' },
        { value: 'Traffic Jam', label: 'Traffic Jam' },
        { value: 'Differently Abled People', label: 'Differently Abled People' },
        { value: 'Sos', label: 'Sos' },
        { value: 'Murder', label: 'Murder' },
        { value: 'Assault/Riot/Commotion', label: 'Assault/Riot/Commotion' },
        { value: 'Major Fire', label: 'Major Fire' },
        { value: 'Child Crime', label: 'Child Crime' },
        { value: 'Dowry Related Crime', label: 'Dowry Related Crime' },
        { value: 'Small Fire', label: 'Small Fire' },
        { value: 'Pick Pocket', label: 'Pick Pocket' },
        { value: 'Election Offences-Violation Of Model Code Of Conduct', label: 'Election Offences-Violation Of Model Code Of Conduct' },
        { value: 'Animals Smugling', label: 'Animals Smugling' },
        { value: 'Accident Explosive', label: 'Accident Explosive' },
        { value: 'Personally Threat', label: 'Personally Threat' },
        { value: 'Human Trafficking', label: 'Human Trafficking' },
        { value: 'Police Help Required By 1090', label: 'Police Help Required By 1090' },
        { value: 'Suicide Attempt', label: 'Suicide Attempt' }
    ]


    const subEventsTypeLabel = [
        { value: 'Misbehavior By Prv', label: 'Misbehavior By Prv' },
        { value: 'Attack', label: 'Attack' },
        { value: 'Dispute In Hospital', label: 'Dispute In Hospital' },
        { value: 'Play Cards', label: 'Play Cards' },


    ]

    const subTypeOptions = [{ "value": "Misbehavior By Prv", "label": "Misbehavior By Prv" }, { "value": "Attack", "label": "Attack" }, { "value": "Dispute In Hospital", "label": "Dispute In Hospital" }, { "value": "Play Cards", "label": "Play Cards" }, { "value": "Grp- Person Accident By Train ", "label": "Grp- Person Accident By Train " }, { "value": "Misbehavior By Ps Incharge", "label": "Misbehavior By Ps Incharge" }, { "value": "Gold Shop", "label": "Gold Shop" }, { "value": "Dispute With Drunk Person", "label": "Dispute With Drunk Person" }, { "value": "Money Transactions Dispute", "label": "Money Transactions Dispute" }, { "value": "Family Dispute With Sr. Citizen", "label": "Family Dispute With Sr. Citizen" }, { "value": "Threatening To Kill", "label": "Threatening To Kill" }, { "value": "House Capture", "label": "House Capture" }, { "value": "No Action Has Been Taken By Ps Incharge For Delivery Of Person Vehicle Goods By ", "label": "No Action Has Been Taken By Ps Incharge For Delivery Of Person Vehicle Goods By " }, { "value": "Boundary Dispute", "label": "Boundary Dispute" }, { "value": "Beat Children By Familymembers", "label": "Beat Children By Familymembers" }, { "value": "Other Dispute", "label": "Other Dispute" }, { "value": "Other Location", "label": "Other Location" }, { "value": "Two Wheeler Vehicle", "label": "Two Wheeler Vehicle" }, { "value": "Illegal Mining Land", "label": "Illegal Mining Land" }, { "value": "By Hanging", "label": "By Hanging" }, { "value": "Residential Building", "label": "Residential Building" }, { "value": "Husband To Beat Wife", "label": "Husband To Beat Wife" }, { "value": "Suspect Found Infected", "label": "Suspect Found Infected" }, { "value": "Bank Account Hacking", "label": "Bank Account Hacking" }, { "value": "Teasing On Public Place", "label": "Teasing On Public Place" }, { "value": "Unclaimed Men", "label": "Unclaimed Men" }, { "value": "Expellinghouse Wife By Husband Or Family Members From House", "label": "Expellinghouse Wife By Husband Or Family Members From House" }, { "value": "Government Land", "label": "Government Land" }, { "value": "Abuse Men", "label": "Abuse Men" }, { "value": "Sewer Dispute", "label": "Sewer Dispute" }, { "value": "Found Injured Animal", "label": "Found Injured Animal" }, { "value": "Unknown", "label": "Unknown" }, { "value": "Women", "label": "Women" }, { "value": "Cow Carcass And Slaughtering", "label": "Cow Carcass And Slaughtering" }, { "value": "On Road", "label": "On Road" }, { "value": "Help For Other", "label": "Help For Other" }, { "value": "With Neighbor", "label": "With Neighbor" }, { "value": "Dispute With Service Provider Or Vendor", "label": "Dispute With Service Provider Or Vendor" }, { "value": "Prv Has Taken Money From The Caller", "label": "Prv Has Taken Money From The Caller" }, { "value": "Illegal Mining", "label": "Illegal Mining" }, { "value": "Black Marketing Over Stocking", "label": "Black Marketing Over Stocking" }, { "value": "Dispute Between Ride And Driver", "label": "Dispute Between Ride And Driver" }, { "value": "Abuse Women", "label": "Abuse Women" }, { "value": "Pollution By Dj/Band/Cracker/Others Means", "label": "Pollution By Dj/Band/Cracker/Others Means" }, { "value": "Beating Senior Citizen", "label": "Beating Senior Citizen" }, { "value": "Notice Of Negligence In Work", "label": "Notice Of Negligence In Work" }, { "value": "Betting", "label": "Betting" }, { "value": "Open School/Coaching Institution/College/Office", "label": "Open School/Coaching Institution/College/Office" }, { "value": "Demand For Money By Ps Station Incharge", "label": "Demand For Money By Ps Station Incharge" }, { "value": "Dispute With Unknown Person", "label": "Dispute With Unknown Person" }, { "value": "Help For Food Items", "label": "Help For Food Items" }, { "value": "Gathering On Street Park", "label": "Gathering On Street Park" }, { "value": "Gathering Funeral Other Celebration", "label": "Gathering Funeral Other Celebration" }, { "value": "Building Res Insti Auditorial Academic Professional Indus Storage Multiplex Etc", "label": "Building Res Insti Auditorial Academic Professional Indus Storage Multiplex Etc" }, { "value": "Husband Relatives To Beat Wife", "label": "Husband Relatives To Beat Wife" }, { "value": "Obtain Illegally Atm / Bank  Information", "label": "Obtain Illegally Atm / Bank  Information" }, { "value": "Dispute Between Hijras", "label": "Dispute Between Hijras" }, { "value": "Threaten Women", "label": "Threaten Women" }, { "value": "Male Dead Body", "label": "Male Dead Body" }, { "value": "Gathering Vegetable Market", "label": "Gathering Vegetable Market" }, { "value": "Information About Suspicious Object In Building/Campus/Location", "label": "Information About Suspicious Object In Building/Campus/Location" }, { "value": "House", "label": "House" }, { "value": "Four Wheeler Vehicle", "label": "Four Wheeler Vehicle" }, { "value": "Beaten With Lathi/Stick", "label": "Beaten With Lathi/Stick" }, { "value": "Threaten Men", "label": "Threaten Men" }, { "value": "Information About Suspicious Person In Building/Campus/Place", "label": "Information About Suspicious Person In Building/Campus/Place" }, { "value": "Other Kind Torturing To Senior Citizen", "label": "Other Kind Torturing To Senior Citizen" }, { "value": "Attempted Rape In Building Or Campus", "label": "Attempted Rape In Building Or Campus" }, { "value": "Forged Signature", "label": "Forged Signature" }, { "value": "Gathering Crowd Market", "label": "Gathering Crowd Market" }, { "value": "Sound Pollution", "label": "Sound Pollution" }, { "value": "Pollution From Industry", "label": "Pollution From Industry" }, { "value": "Mobile", "label": "Mobile" }, { "value": "Insult", "label": "Insult" }, { "value": "Child Kidnap", "label": "Child Kidnap" }, { "value": "Obscene Message / Picture Post Of Women", "label": "Obscene Message / Picture Post Of Women" }, { "value": "Iilegal Sale", "label": "Iilegal Sale" }, { "value": "Domestic Violence Against Men Or Boy Or Seniormen", "label": "Domestic Violence Against Men Or Boy Or Seniormen" }, { "value": "Business Establishment", "label": "Business Establishment" }, { "value": "Public Gathering", "label": "Public Gathering" }, { "value": "Landlord And Tenant", "label": "Landlord And Tenant" }, { "value": "Serious Road Accident", "label": "Serious Road Accident" }, { "value": "Illegally Transfer Money From Bank", "label": "Illegally Transfer Money From Bank" }, { "value": "Kidnapping", "label": "Kidnapping" }, { "value": "Men Kidnap", "label": "Men Kidnap" }, { "value": "Quarantine Violation", "label": "Quarantine Violation" }, { "value": "Other Animal Carcass", "label": "Other Animal Carcass" }, { "value": "Sale Of Meat In Open", "label": "Sale Of Meat In Open" }, { "value": "For Parking", "label": "For Parking" }, { "value": "Women Kidnap", "label": "Women Kidnap" }, { "value": "Police Help Required By 108", "label": "Police Help Required By 108" }, { "value": "Pan Card", "label": "Pan Card" }, { "value": "Iilegal Construction", "label": "Iilegal Construction" }, { "value": "Alone", "label": "Alone" }, { "value": "Dangerous Animals/Dog Residential Area", "label": "Dangerous Animals/Dog Residential Area" }, { "value": "Family Members Beat Wife", "label": "Family Members Beat Wife" }, { "value": "Due To Illegal Parking", "label": "Due To Illegal Parking" }, { "value": "Obscene Talks Women", "label": "Obscene Talks Women" }, { "value": "House Arrest", "label": "House Arrest" }, { "value": "Child", "label": "Child" }, { "value": "Mad /Retarded Person", "label": "Mad /Retarded Person" }, { "value": "Crash Between Light Vehicles", "label": "Crash Between Light Vehicles" }, { "value": "Dispute Between Relatives", "label": "Dispute Between Relatives" }, { "value": "Paving Dispute", "label": "Paving Dispute" }, { "value": "Prostitution", "label": "Prostitution" }, { "value": "Due To Vehicle Damage", "label": "Due To Vehicle Damage" }, { "value": "Unclaimed Vehicle", "label": "Unclaimed Vehicle" }, { "value": "Between Worker And Boss", "label": "Between Worker And Boss" }, { "value": "Shop", "label": "Shop" }, { "value": "Gathering Playing In Open", "label": "Gathering Playing In Open" }, { "value": "Insult Of Senior Citizen", "label": "Insult Of Senior Citizen" }, { "value": "Email Hacking", "label": "Email Hacking" }, { "value": "Indecent Talks", "label": "Indecent Talks" }, { "value": "Unclaimed Women", "label": "Unclaimed Women" }, { "value": "Information About Suspicious Object In The Vehicle", "label": "Information About Suspicious Object In The Vehicle" }, { "value": "Farm Forest Agriculture", "label": "Farm Forest Agriculture" }, { "value": "In Private Vehicle", "label": "In Private Vehicle" }, { "value": "Other Campus", "label": "Other Campus" }, { "value": "Teasing In Building Or Premise", "label": "Teasing In Building Or Premise" }, { "value": "No Proper Medical Support From Hospital Doctor", "label": "No Proper Medical Support From Hospital Doctor" }, { "value": "Hit And Run", "label": "Hit And Run" }, { "value": "Sharp Weapons", "label": "Sharp Weapons" }, { "value": "Prv Has Taken Money From The Vehicle", "label": "Prv Has Taken Money From The Vehicle" }, { "value": "Gathering Open Walk In Group", "label": "Gathering Open Walk In Group" }, { "value": "Misbehaviour With Child By Outsider", "label": "Misbehaviour With Child By Outsider" }, { "value": "Offensive/Obscene Material Post On Social Site", "label": "Offensive/Obscene Material Post On Social Site" }, { "value": "Aadhar Card", "label": "Aadhar Card" }, { "value": "Sos", "label": "Sos" }, { "value": "Other Means", "label": "Other Means" }, { "value": "Woman Dead Body", "label": "Woman Dead Body" }, { "value": "Consuming Poison", "label": "Consuming Poison" }, { "value": "Making Fake Papers", "label": "Making Fake Papers" }, { "value": "Between Other Groups", "label": "Between Other Groups" }, { "value": "Electrical Equipment", "label": "Electrical Equipment" }, { "value": "Help For Transport", "label": "Help For Transport" }, { "value": "Dispute Between Hijras And Men", "label": "Dispute Between Hijras And Men" }, { "value": "Hit By Dividers", "label": "Hit By Dividers" }, { "value": "Gathering Kotedaar Ration Shop", "label": "Gathering Kotedaar Ration Shop" }, { "value": "Harrasment By Inlaws", "label": "Harrasment By Inlaws" }, { "value": "Grp-Animal Accident By Train", "label": "Grp-Animal Accident By Train" }, { "value": "Selling Goods Over Rate", "label": "Selling Goods Over Rate" }, { "value": "Website Hacking", "label": "Website Hacking" }, { "value": "From Any Device", "label": "From Any Device" }, { "value": "Green Tree Chopping Incident", "label": "Green Tree Chopping Incident" }, { "value": "Expelling Kids From Home", "label": "Expelling Kids From Home" }, { "value": "Information About Suspicious Person In The Vehicle", "label": "Information About Suspicious Person In The Vehicle" }, { "value": "Gathering Gambling Playing Cards", "label": "Gathering Gambling Playing Cards" }, { "value": "Child Marriage", "label": "Child Marriage" }, { "value": "Identity Card", "label": "Identity Card" }, { "value": "Unclaimed Child", "label": "Unclaimed Child" }, { "value": "Cycle", "label": "Cycle" }, { "value": "Iilegal Supply", "label": "Iilegal Supply" }, { "value": "Driving License", "label": "Driving License" }, { "value": "Beating/Harassing/Torturing For Dowry", "label": "Beating/Harassing/Torturing For Dowry" }, { "value": "Illegal Supply", "label": "Illegal Supply" }, { "value": "Tablet/Pc/Laptop", "label": "Tablet/Pc/Laptop" }, { "value": "Harrassment Of Wife By Family Members", "label": "Harrassment Of Wife By Family Members" }, { "value": "Notification Of Police Inaction", "label": "Notification Of Police Inaction" }, { "value": "Making Or Selling Fake Artwork", "label": "Making Or Selling Fake Artwork" }, { "value": "Three Wheeler Vehicle", "label": "Three Wheeler Vehicle" }, { "value": "Due To Strike", "label": "Due To Strike" }, { "value": "Inter Religion Marriage", "label": "Inter Religion Marriage" }, { "value": "Chain Snatching", "label": "Chain Snatching" }, { "value": "Illegal Mining River", "label": "Illegal Mining River" }, { "value": "Threatening", "label": "Threatening" }, { "value": "Notice Of Negligence In Investigation", "label": "Notice Of Negligence In Investigation" }, { "value": "Academic Certificates/Marsheet", "label": "Academic Certificates/Marsheet" }, { "value": "Conducting Election Meeting/Rally Without Permission", "label": "Conducting Election Meeting/Rally Without Permission" }, { "value": "Fake Registry", "label": "Fake Registry" }, { "value": "Money Distribution", "label": "Money Distribution" }, { "value": "Notice Of Delay In Work", "label": "Notice Of Delay In Work" }, { "value": "House Garbage Dump Huts Slum", "label": "House Garbage Dump Huts Slum" }, { "value": "Throttling", "label": "Throttling" }, { "value": "Small Medium Large Industry", "label": "Small Medium Large Industry" }, { "value": "Cow Smuggling", "label": "Cow Smuggling" }, { "value": "Crash Between Heavy Vehicles", "label": "Crash Between Heavy Vehicles" }, { "value": "Toxic Gas Leakage", "label": "Toxic Gas Leakage" }, { "value": "Gathering Construction Place", "label": "Gathering Construction Place" }, { "value": "Jumping Into Water (River, Canal,Lake,Swimming Pool, Pond Etc.)", "label": "Jumping Into Water (River, Canal,Lake,Swimming Pool, Pond Etc.)" }, { "value": "Between Neighbors", "label": "Between Neighbors" }, { "value": "Obscene Message / Picture Post Of Men", "label": "Obscene Message / Picture Post Of Men" }, { "value": "Iilegal Possession Of Narcotics", "label": "Iilegal Possession Of Narcotics" }, { "value": "Inter Caste Marriage", "label": "Inter Caste Marriage" }, { "value": "Other Vehicle", "label": "Other Vehicle" }, { "value": "Senior Citizen Abuse", "label": "Senior Citizen Abuse" }, { "value": "Prv Not Reached", "label": "Prv Not Reached" }, { "value": "In Public Vehicle", "label": "In Public Vehicle" }, { "value": "Illegally Sending Abroad For Job", "label": "Illegally Sending Abroad For Job" }, { "value": "Between Workers And Laborers", "label": "Between Workers And Laborers" }, { "value": "Police Help Required By 1090", "label": "Police Help Required By 1090" }, { "value": "Buggery With A Child", "label": "Buggery With A Child" }, { "value": "Injury Due To Electical Current", "label": "Injury Due To Electical Current" }, { "value": "Notice Of Work To Abolish", "label": "Notice Of Work To Abolish" }, { "value": "Trafficking", "label": "Trafficking" }, { "value": "Violation Of The Instructions Of The Election Commission", "label": "Violation Of The Instructions Of The Election Commission" }, { "value": "Encroachment On Road", "label": "Encroachment On Road" }, { "value": "Familymembers Harrassment Children", "label": "Familymembers Harrassment Children" }, { "value": "Money", "label": "Money" }, { "value": "Iilegal Possession", "label": "Iilegal Possession" }, { "value": "Forced To Marry", "label": "Forced To Marry" }]

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

    const handleChangeEventType = ({ value, label }) => {
        setEventType(value)
        setEventTypeLabel(label)
    }

    const handleChangeEventSubType = ({ value, label }) => {
        setSubEventType(value)
        setSubEventTypeLabel(label)
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
            eventSubType: subEventType,
            eventType: eventType,
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
                    {/* <div onClick={
                        () => Onperform()
                    }>
                        Funtion
                    </div> */}
                    <TextFieldData label={"Circle"} value={circle} setValue={setCrime} />
                    <TextFieldData label={"District"} value={district} setValue={setDistrict} multiline={false} />
                    {/* <TextFieldData label={"Event Type"} value={eventType} setValue={setEventType} multiline={false} /> */}
                    {/* <TextFieldData label={"Event Sub Type"} value={subEventType} setValue={setSubEventType} multiline={false} /> */}
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
                                {"Event Type"}
                            </div>
                            <Select
                                options={eventTypeOptions}
                                value={{ value: eventType, label: eventTypeLabel }}
                                onChange={(value) => handleChangeEventType(value)}
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
                                {"Sub Event Type"}
                            </div>
                            <Select
                                options={subTypeOptions}
                                value={{ value: subEventType, label: subEventTypeLabel }}
                                onChange={(value) => handleChangeEventSubType(value)}
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