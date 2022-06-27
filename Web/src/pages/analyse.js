import { DashboardLayout } from '../components/dashboard-layout';
import Head from 'next/head';
import { Box, Container, Typography } from '@mui/material';
import Select from 'react-select'
import { useState, useEffect } from 'react';
import axios from 'axios';
import { setDate } from 'date-fns';
import {
    ArgumentAxis,
    ValueAxis,
    Chart,
    LineSeries,

} from '@devexpress/dx-react-chart-material-ui';
import { Bar, Line, Pie } from 'react-chartjs-2';
import ChartDataLabels from 'chartjs-plugin-datalabels';

const Analyse = () => {

    const options = [
        { value: 'event_by_date', label: 'Crimes Per Date' },
        { value: 'event_by_day', label: 'Crimes Per Day' },
        { value: 'event_by_hour', label: 'Crimes Per Hour' },
        { value: 'type_of_crime_by_day', label: 'Type of Crime Per Day' },
        { value: 'type_of_crime_by_hour', label: 'Type of Crime Per Hour' },
        { value: 'peak_crime_time', label: 'Peak Time For Crimes' },
        { value: 'cases_by_type_of_crime', label: 'No Of Cases Per Type of Crime' }
    ]

    const api = new Map([
        ["event_by_date", "http://20.204.104.233:8888/002"],
        ["event_by_day", "http://20.204.104.233:8888/003"],
        ["event_by_hour", "http://20.204.104.233:8888/004"],
        ["type_of_crime_by_day", "http://20.204.104.233:8888/005"],
        ["type_of_crime_by_hour", "http://20.204.104.233:8888/006"],
        ["cases_by_type_of_crime", "http://20.204.104.233:8888/008"],
        ["peak_crime_time", "http://20.204.104.233:8888/007"],
    ])

    // const api = new Map([
    //     ["event_by_date", "data1.json"],
    //     ["event_by_day", "data2.json"],
    //     ["event_by_hour", "data3.json"],
    //     ["type_of_crime_by_day", "data4.json"],
    //     ["type_of_crime_by_hour", "data5.json"],
    //     ["peak_crime_time", "data6.json"],
    //     ["case_by_type_of_crime", "data7.json"],
    // ])

    const [graphSelected, setGraphSelected] = useState("event_by_date")
    const [graphSelectedLabel, setGraphSelectedLabel] = useState("Crimes Per Date")

    const handleChange = ({ value, label }) => {
        setGraphSelected(value)
        setGraphSelectedLabel(label)
    }

    return <div>
        <Head>
            <title>
                Analyse
            </title>
        </Head>
        <Box
            component="main"
            sx={{
                flexGrow: 1,
                py: 1
            }}
        >
            <Container maxWidth={false}>
                <Box
                    sx={{
                        display: 'flex',
                        flexWrap: 'wrap',
                        flexDirection: 'column',
                        m: -1
                    }}
                >
                    <Typography
                        sx={{ m: 1 }}
                        variant="h4"
                    >
                        Analyse
                    </Typography>
                    <div style={{
                        marginTop: 10,
                        marginBottom: 10,
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "center"
                    }}>
                        <div style={{
                            width: "50%",
                        }}>
                            <Select
                                options={options}
                                value={{ value: graphSelected, label: graphSelectedLabel }}
                                onChange={(value) => handleChange(value)}
                            />
                        </div>
                    </div>
                    <GraphSel value={graphSelected} api={api} />
                </Box>
            </Container>
        </Box>
    </div>
}

const GraphSel = ({ value, api }) => {

    const [data, setdata] = useState([])
    const [labels, setLabels] = useState([])
    const [loading, setloading] = useState(false)
    const [casesDay, setcasesDay] = useState(null)
    const [casesType, setcasesType] = useState(null)
    const [casesHour, setcasesHour] = useState(null)
    const [scatterData, setScatterData] = useState(null)

    const optionsDay = [
        { value: 'Monday', label: 'Monday' },
        { value: 'Tuesday', label: 'Tuesday' },
        { value: 'Wednesday', label: 'Wdnesday' },
        { value: 'Thursday', label: 'Thursday' },
        { value: 'Friday', label: 'Friday' },
        { value: 'Saturday', label: 'Saturday' },
        { value: 'Sunday', label: 'Sunday' }
    ]

    const optionsHour = [
        { value: '0', label: '00:00 AM - 00:59 AM' },
        { value: '1', label: '01:00 AM - 01:59 AM' },
        { value: '2', label: '02:00 AM - 02:59 AM' },
        { value: '3', label: '03:00 AM - 03:59 AM' },
        { value: '4', label: '04:00 AM - 04:59 AM' },
        { value: '5', label: '05:00 AM - 05:59 AM' },
        { value: '6', label: '06:00 AM - 06:59 AM' },
        { value: '7', label: '07:00 AM - 07:59 AM' },
        { value: '8', label: '08:00 AM - 08:59 AM' },
        { value: '9', label: '09:00 AM - 09:59 AM' },
        { value: '10', label: '10:00 AM - 10:59 AM' },
        { value: '11', label: '11:00 AM - 11:59 AM' },
        { value: '12', label: '12:00 PM - 12:59 PM' },
        { value: '13', label: '01:00 PM - 01:59 PM' },
        { value: '14', label: '02:00 PM - 02:59 PM' },
        { value: '15', label: '03:00 PM - 03:59 PM' },
        { value: '16', label: '04:00 PM - 04:59 PM' },
        { value: '17', label: '05:00 PM - 05:59 PM' },
        { value: '18', label: '06:00 PM - 06:59 PM' },
        { value: '19', label: '07:00 PM - 07:59 PM' },
        { value: '20', label: '08:00 PM - 08:59 PM' },
        { value: '21', label: '09:00 PM - 09:59 PM' },
        { value: '22', label: '10:00 PM - 10:59 PM' },
        { value: '23', label: '11:00 PM - 11:59 PM' },
    ]

    const [daySelected, setDaySelected] = useState("Monday")
    const [daySelectedLabel, setDaySelectedLabel] = useState("Monday")

    const [hourSelected, setHourSelected] = useState("0")
    const [hourSelectedLabel, setHourSelectedLabel] = useState('00:00 AM - 00:59 AM')

    const handleChange = ({ value, label }) => {
        setDaySelected(value)
        setDaySelectedLabel(label)
    }

    const handleChangeHour = ({ value, label }) => {
        setHourSelected(value)
        setHourSelectedLabel(label)
    }

    useEffect(() => {

        getData()
        console.log(value)

    }, [value])

    const format = () => tick => tick;

    const getData = async () => {
        setloading(true)
        console.log(api.get(value))
        fetch(
            api.get(value), {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
            .then((res) => res.json())
            .then((json) => {
                console.log(json)
                let dataTemp = []
                let labelsTemp = []
                let labelValuePair = []
                if (json) {
                    for (var key in json) {
                        dataTemp.push(key)
                        labelsTemp.push(json[key])
                        labelValuePair.push({ "label": json[key], "value": key })
                    }
                }
                if (value === "event_by_date") {
                    labelValuePair.sort(function (a, b) {
                        return a.label.localeCompare(b.label)
                    })
                    let dateTemp = []
                    let casesTemp = []
                    labelValuePair.map((obj) => {
                        dateTemp.push(obj.label)
                        casesTemp.push(obj.value)
                    })
                    setdata(casesTemp)
                    setLabels(dateTemp)
                }
                if (value === "event_by_day") {
                    setdata(labelsTemp)
                    setLabels(dataTemp)
                }
                if (value === "event_by_hour") {
                    // labelValuePair.sort(function (a, b) {
                    //     return a.label < b.label
                    // })
                    // console.log(labelValuePair)
                    setdata(labelsTemp)
                    setLabels(dataTemp)
                }
                if (value === "cases_by_type_of_crime") {
                    console.log("Hi", dataTemp, labelsTemp)
                    setdata(labelsTemp)
                    setLabels(dataTemp)
                }
                if (value === "type_of_crime_by_hour") {
                    setdata(dataTemp)
                    setLabels(labelsTemp)
                    console.log(dataTemp, labelsTemp)
                    let tempTypes = []
                    console.log(dataTemp, labelsTemp)
                    for (var key in labelsTemp[0]) {
                        tempTypes.push(key)
                    }
                    setcasesType(tempTypes)
                    let casesPerHour = {
                        "0": [], "1": [], "2": [],
                        "3": [], "4": [], "5": [],
                        "6": [], "7": [], "8": [],
                        "9": [], "10": [], "11": [],
                        "12": [], "13": [], "14": [],
                        "15": [], "16": [], "17": [],
                        "18": [], "19": [], "20": [],
                        "21": [], "22": [], "23": [], "24": []
                    }
                    labelsTemp.map((labelObj, index) => {
                        let casesData = []
                        for (var key in labelObj) {
                            casesData.push(labelObj[key])
                        }
                        casesPerHour[dataTemp[index]] = casesData
                    })
                    setcasesHour(casesPerHour)
                }
                if (value === "type_of_crime_by_day") {
                    setdata(dataTemp)
                    setLabels(labelsTemp)
                    let tempTypes = []
                    console.log(dataTemp, labelsTemp)
                    for (var key in labelsTemp[0]) {
                        tempTypes.push(key)
                    }
                    setcasesType(tempTypes)
                    let casesPerDay = {
                        "Monday": [],
                        "Tuesday": [],
                        "Wednesday": [],
                        "Thursday": [],
                        "Friday": [],
                        "Saturday": [],
                        "Sunday": [],
                    }
                    labelsTemp.map((labelObj, index) => {
                        let casesData = []
                        for (var key in labelObj) {
                            casesData.push(labelObj[key])
                        }
                        casesPerDay[dataTemp[index]] = casesData
                    })
                    setcasesDay(casesPerDay)
                }
                if (value === "peak_crime_time") {
                    let dataPeakTime = []
                    let labelsPeakTime = []
                    for (var key in labelsTemp[0]) {
                        dataPeakTime.push(labelsTemp[0][key])
                        labelsPeakTime.push(labelsTemp[1][key])
                    }
                    setdata(labelsPeakTime)
                    setLabels(dataPeakTime)
                    console.log(dataPeakTime, labelsPeakTime)
                }
                setloading(false)
            })
    }

    return <div style={{
        display: "flex",
        justifyContent: "center"
    }}>
        {data && value === "event_by_date" && !loading ?
            <div style={{
                width: 1000
            }}>
                <Line
                    data={{
                        labels: labels,
                        datasets: [{
                            data: data,
                            label: "Cases",
                            // backgroundColor: [
                            //     'rgba(255, 99, 132, 0.2)',
                            //     'rgba(54, 162, 235, 0.2)',
                            //     'rgba(255, 206, 86, 0.2)',
                            //     'rgba(75, 192, 192, 0.2)',
                            //     'rgba(153, 102, 255, 0.2)',
                            //     'rgba(255, 159, 64, 0.2)',
                            // ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                // 'rgba(54, 162, 235, 1)',
                                // 'rgba(255, 206, 86, 1)',
                                // 'rgba(75, 192, 192, 1)',
                                // 'rgba(153, 102, 255, 1)',
                                // 'rgba(255, 159, 64, 1)',
                            ],
                            borderWidth: 1,
                        }]
                    }}
                />
            </div>
            : null}

        {data && (value === "event_by_day" || value === "event_by_hour") && !loading ?
            <div style={{
                width: 1000
            }}>
                <Bar
                    data={{
                        labels: labels,
                        datasets: [{
                            data: data,
                            label: "Cases",
                            // backgroundColor: [
                            //     'rgba(255, 99, 132, 0.2)',
                            //     'rgba(54, 162, 235, 0.2)',
                            //     'rgba(255, 206, 86, 0.2)',
                            //     'rgba(75, 192, 192, 0.2)',
                            //     'rgba(153, 102, 255, 0.2)',
                            //     'rgba(255, 159, 64, 0.2)',
                            // ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                // 'rgba(54, 162, 235, 1)',
                                // 'rgba(255, 206, 86, 1)',
                                // 'rgba(75, 192, 192, 1)',
                                // 'rgba(153, 102, 255, 1)',
                                // 'rgba(255, 159, 64, 1)',
                            ],
                            borderWidth: 1,
                        }]
                    }}
                />
            </div>
            : null}

        {value === "type_of_crime_by_day" ?
            <div>
                <div style={{
                    marginTop: 10,
                    marginBottom: 10,
                    width: "100%",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center"
                }}>
                    <div style={{
                        width: "40%",
                    }}>
                        <Select
                            options={optionsDay}
                            value={{ value: daySelected, label: daySelectedLabel }}
                            onChange={(value) => handleChange(value)}
                        />
                    </div>
                </div>
                {casesDay && data && casesType && daySelected && !loading ?
                    <div style={{
                        width: 800,
                        marginTop: 20,
                        marginBottom: 20
                    }}>
                        <Pie
                            data={{
                                labels: casesType,
                                datasets: [{
                                    data: casesDay[daySelected],
                                    label: "Cases",
                                    backgroundColor: [
                                        'rgb(255, 99, 132)',
                                        'rgb(54, 162, 235)',
                                        'rgb(255, 205, 86)',
                                        'rgb(220, 125, 20)',
                                        'rgb(120, 225, 20)',
                                        '#c158dc',
                                        '#be9c91',
                                        '#ef5350',
                                        '#1a237e',
                                        '#d50000'
                                    ],
                                    borderColor: [
                                        '#484848'
                                        // 'rgba(255, 99, 132, 1)',
                                        // 'rgba(54, 162, 235, 1)',
                                        // 'rgba(255, 206, 86, 1)',
                                        // 'rgba(75, 192, 192, 1)',
                                        // 'rgba(153, 102, 255, 1)',
                                        // 'rgba(255, 159, 64, 1)',
                                    ],
                                    borderWidth: 0.5,
                                }]
                            }}
                        />
                    </div>
                    : null}
            </div>
            : null}

        {value === "type_of_crime_by_hour" ?
            <div>
                <div style={{
                    marginTop: 10,
                    marginBottom: 10,
                    width: "100%",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center"
                }}>
                    <div style={{
                        width: "50%",
                    }}>
                        <Select
                            options={optionsHour}
                            value={{ value: hourSelected, label: hourSelectedLabel }}
                            onChange={(value) => handleChangeHour(value)}
                        />
                    </div>
                </div>
                {casesDay && data && casesHour && hourSelected && !loading ?
                    <div style={{
                        width: 800,
                        marginTop: 20,
                        marginBottom: 20
                    }}>
                        <Pie
                            data={{
                                labels: casesType,
                                datasets: [{
                                    data: casesHour[hourSelected],
                                    label: "Cases",
                                    backgroundColor: [
                                        'rgb(255, 99, 132)',
                                        'rgb(54, 162, 235)',
                                        'rgb(255, 205, 86)',
                                        'rgb(220, 125, 20)',
                                        'rgb(120, 225, 20)',
                                        '#c158dc',
                                        '#be9c91',
                                        '#ef5350',
                                        '#1a237e',
                                        '#d50000'
                                    ],
                                    borderColor: [
                                        '#484848'
                                        // 'rgba(255, 99, 132, 1)',
                                        // 'rgba(54, 162, 235, 1)',
                                        // 'rgba(255, 206, 86, 1)',
                                        // 'rgba(75, 192, 192, 1)',
                                        // 'rgba(153, 102, 255, 1)',
                                        // 'rgba(255, 159, 64, 1)',
                                    ],
                                    borderWidth: 0.5,
                                }]
                            }}
                        />
                    </div>
                    : null}
            </div>
            : null}

        {data && value === "peak_crime_time" && !loading ?
            <div style={{
                width: 1000
            }}>
                <Line
                    data={{
                        labels: labels,
                        datasets: [{
                            data: data,
                            label: "Peak Time",
                            backgroundColor: [
                                '#c158dc',
                                // '#be9c91',
                                // '#ef5350',
                                // '#1a237e',
                                // '#d50000'
                                // 'rgba(255, 99, 132, 0.2)',
                                // 'rgba(54, 162, 235, 0.2)',
                                // 'rgba(255, 206, 86, 0.2)',
                                // 'rgba(75, 192, 192, 0.2)',
                                // 'rgba(153, 102, 255, 0.2)',
                                // 'rgba(255, 159, 64, 0.2)',
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                // 'rgba(54, 162, 235, 1)',
                                // 'rgba(255, 206, 86, 1)',
                                // 'rgba(75, 192, 192, 1)',
                                // 'rgba(153, 102, 255, 1)',
                                // 'rgba(255, 159, 64, 1)',
                            ],
                            borderWidth: 0,
                        }]
                    }}
                    plugins={[ChartDataLabels]}
                    options={{
                        title: {
                            display: true
                        },
                        legend: {
                            display: true
                        },
                        plugins: {
                            datalabels: {
                                anchor: 'end',
                                align: 'top',
                                formatter: Math.round,
                                font: {
                                    // weight: 'bold',
                                    size: 16
                                }
                            }
                        }
                    }}
                />
            </div>
            : null}

        {data && value === "cases_by_type_of_crime" && !loading ?
            <div style={{
                width: 1000
            }}>
                <Bar
                    data={{
                        labels: labels,
                        datasets: [{
                            data: data,
                            label: "Cases",
                            // backgroundColor: [
                            //     'rgba(255, 99, 132, 0.2)',
                            //     'rgba(54, 162, 235, 0.2)',
                            //     'rgba(255, 206, 86, 0.2)',
                            //     'rgba(75, 192, 192, 0.2)',
                            //     'rgba(153, 102, 255, 0.2)',
                            //     'rgba(255, 159, 64, 0.2)',
                            // ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                // 'rgba(54, 162, 235, 1)',
                                // 'rgba(255, 206, 86, 1)',
                                // 'rgba(75, 192, 192, 1)',
                                // 'rgba(153, 102, 255, 1)',
                                // 'rgba(255, 159, 64, 1)',
                            ],
                            borderWidth: 1,
                        }]
                    }}
                />
            </div>
            : null}


    </div>
}

{/* <Chart
            data={data}
        >
            <ArgumentAxis tickFormat={format}  />
            <ValueAxis

            />

            <LineSeries valueField="cases" argumentField="date" />
        </Chart>  */}

Analyse.getLayout = (page) => (
    <DashboardLayout>
        {page}
    </DashboardLayout>
);

export default Analyse