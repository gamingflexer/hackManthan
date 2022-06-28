import Map from "mapmyindia-react";
import { DashboardLayout } from '../components/dashboard-layout';
import { useState, useEffect } from "react";
import { render } from "nprogress";
import Head from 'next/head';
import db from "src/firebase";
import { collection, query, where, getDocs } from "firebase/firestore";



const MapPolice = () => {
    const [latlng, setLatLong] = useState({ lat: "18.5314", lng: "73.845" });
    const [markers, setMarkers] = useState([]);
    const [first, setFirst] = useState(null);
    const [locations, setLocations] = useState([])

    // const Map = ReactMapboxGl({
    //     accessToken:
    //         'pk.eyJ1IjoiZmFicmljOCIsImEiOiJjaWc5aTV1ZzUwMDJwdzJrb2w0dXRmc2d0In0.p6GGlfyV-WksaDV_KdN27A'
    // });
    try {

        useEffect(() => {
            if (first) {
                setFirst(false)
                getData()
            }
        }, [first])

        useEffect(() => {
            setFirst(true)
        }, [])

        useEffect(() => {
            getMarkers()
        }, [locations])



        const getData = async () => {
            const querySnapshot = await getDocs(collection(db, "crimes"));
            let temp = []
            querySnapshot.forEach((doc) => {
                // doc.data() is never undefined for query doc snapshots
                // console.log(doc.id, " => ", doc.data());
                temp.push({
                    position: [doc.data().lat, doc.data().long],
                    title: doc.data().eventType
                })
            });
            console.log(JSON.stringify(temp))
            setLocations(temp)
        }

        const getMarkers = () => {
            let markers = []
            locations.forEach((location) => {
                if (location && location.lat !== null && location.long !== null)
                    markers.push({
                        position: [location.lat, location.long],
                        title: location.eventType,
                        onClick: e => {
                            console.log("clicked ");
                        },
                        // onDragend: e => {
                        //     console.log("dragged");
                        // }
                    })
            })
            setMarkers(markers)
            return markers
        }

        // useEffect(() => {
        //     console.log(first)
        // }, [first])



        return (
            <>
                <Head>
                    <title>Map</title>
                    <script src="https://apis.mapmyindia.com/advancedmaps/v1/507b8b23f483e615c13f648d32d8d17c/map_load?v=1.3"></script>
                </Head>
                <div style={{
                    // width: 800,
                    // height: "100vh"
                }}>
                    <Map
                        markers={

                            [{ "position": [26.833, 81.026], "title": "Domestic Violence" }, { "position": [26.84847687411346, 80.93933371255994], "title": "Threat in Person" }, { "position": [26.891, 81.058], "title": "Suspicious Object Information" }, { "position": [26.846, 81.061], "title": "Threat In Person" }, { "position": [26.874, 81.026], "title": "Suspicious Object Information" }, { "position": [26.86, 80.997], "title": "Attempted Murder" }, { "position": [26.835, 81.04], "title": "Suspicious Object Information" }, { "position": [26.839, 81.026], "title": "Domestic Violence" }, { "position": [26.849, 80.993], "title": "Attempted Murder" }, { "position": [26.861, 81.04], "title": "Suspicious Object Information" }, { "position": [26.851, 81.004], "title": "Suspicious Object Information" }, { "position": [26.838, 81.009], "title": "Threat In Person" }, { "position": [26.838, 81.038], "title": "Threat In Person" }, { "position": [26.843, 81.025], "title": "Domestic Violence" }, { "position": [26.835, 81.014], "title": "Threat In Person" }, { "position": [26.833, 81.024], "title": "Attempted Murder" }, { "position": [26.832, 80.999], "title": "Threat In Person" }, { "position": [26.828, 81.014], "title": "Threat In Person" }, { "position": [26.834, 81.033], "title": "Threat In Person" }, { "position": [26.861, 81.04], "title": "Suspicious Object Information" }, { "position": [26.825, 81.044], "title": "Attempted Murder" }, { "position": [26.83729398791936, 80.9996094519405], "title": "Attack by Knife" }, { "position": [26.831, 81.052], "title": "Threat In Person" }, { "position": [26.835, 81.04], "title": "Suspicious Object Information" }, { "position": [26.835, 81.04], "title": "Suspicious Object Information" }, { "position": [26.891, 81.058], "title": "Suspicious Object Information" }, { "position": [26.846, 81.004], "title": "Attempted Murder" }, { "position": [26.831, 81.008], "title": "Attempted Murder" }, { "position": [26.841, 81.01], "title": "Domestic Violence" }, { "position": [26.874, 81.026], "title": "Suspicious Object Information" }, { "position": [26.847, 81.06], "title": "Domestic Violence" }, { "position": [26.873, 81.023], "title": "Threat In Person" }, { "position": [26.841, 81.001], "title": "Domestic Violence" }]
                        }
                    /> : null

                </div>
                <div style={{
                    marginTop: 20,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center"
                }}>
                    <div style={{
                        padding: 20,
                        marginLeft: 30,
                        background: "green"
                    }}>

                    </div>
                    <div style={{
                        paddingLeft: 10
                    }}>
                        -- Crimes
                    </div>

                    <div style={{
                        padding: 20,
                        marginLeft: 30,
                        background: "red"
                    }}>

                    </div>
                    <div style={{
                        paddingLeft: 10
                    }}>
                        -- Active Crimes
                    </div>

                    <div style={{
                        padding: 20,
                        marginLeft: 30,
                        background: "orange",
                        borderRadius: 20
                    }}>

                    </div>
                    <div style={{
                        paddingLeft: 10
                    }}>
                        -- Police
                    </div>
                </div>
            </>

        );
    } catch (error) {
        console.log(error)
    }
}

MapPolice.getLayout = (page) => (
    <DashboardLayout>
        {page}
    </DashboardLayout>
);

export default MapPolice