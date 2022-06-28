import Map from "mapmyindia-react";
import { DashboardLayout } from '../components/dashboard-layout';
import { useState, useEffect } from "react";
import { render } from "nprogress";
import Head from 'next/head';


const MapPolice = () => {
    const [latlng, setLatLong] = useState({ lat: "18.5314", lng: "73.845" });
    const [address, setAddress] = useState("");
    const [first, setFirst] = useState(null);

    // const Map = ReactMapboxGl({
    //     accessToken:
    //         'pk.eyJ1IjoiZmFicmljOCIsImEiOiJjaWc5aTV1ZzUwMDJwdzJrb2w0dXRmc2d0In0.p6GGlfyV-WksaDV_KdN27A'
    // });

    useEffect(() => {
        setFirst(1)
    }, [])

    useEffect(() => {
        console.log(first)
    }, [first])


    return (
        <>
            <Head>
                <title>Login</title>
                <script src="https://apis.mapmyindia.com/advancedmaps/v1/507b8b23f483e615c13f648d32d8d17c/map_load?v=1.3"></script>
            </Head>
            <div style={{
                width: 800,
                height: 800
            }}>
                <Map
                />
            </div>
        </>

    );
}

// MapPolice.getLayout = (page) => (
//     <DashboardLayout>
//         {page}
//     </DashboardLayout>
// );

export default MapPolice