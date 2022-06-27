import { Bar } from 'react-chartjs-2';
import { Box, Button, Card, CardContent, CardHeader, Divider, useTheme } from '@mui/material';
import ArrowDropDownIcon from '@mui/icons-material/ArrowDropDown';
import ArrowRightIcon from '@mui/icons-material/ArrowRight';
import { Line, Pie } from 'react-chartjs-2';
import { useState, useEffect } from 'react';
import { getDate } from 'date-fns';


export const Sales = (props) => {
  const theme = useTheme();

  const [data, setdata] = useState([])
  const [labels, setLabels] = useState([])

  useEffect(() => {

    getData()

  }, [])

  const getData = async () => {
    fetch(
      "http://20.204.104.233:8888/002", {
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
      })

  }


  return (
    <Card {...props}>

      <CardHeader title="No. of Cases per Dates" />
      <Divider />
      <CardContent>
        <div style={{
          // height: 1000
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
        </div></CardContent>
    </Card>
  );
};
