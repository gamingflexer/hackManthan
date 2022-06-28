import Head from 'next/head';
import { Box, Container, Typography } from '@mui/material';
import { CustomerListResults } from '../components/customer/customer-list-results';
import { CustomerListToolbar } from '../components/customer/customer-list-toolbar';
import { DashboardLayout } from '../components/dashboard-layout';
import { customers } from '../__mocks__/customers';
import DataForm from 'src/components/dataForm';
import { useState } from 'react';

const EnterData = () => {


  // const [selectedFile, setSelectedFile] = useState();
  // const [isFilePicked, setIsFilePicked] = useState(false)

  // const changeHandler = (event) => {
  //   setSelectedFile(event.target.files[0]);
  //   console.log(event.target.files[0])
  //   setIsFilePicked(true);
  // };

  // const onImportClick = async () => {
  //   const formData = new FormData();
  //   console.log(selectedFile)
  //   formData.append('file', selectedFile);
  //   // const params = {
  //   //   file: formData
  //   // }
  //   console.log(formData)
  //   // console.log(JSON.stringify(params))
  //   fetch(
  //     'http://20.204.104.233:8888/file-upload',
  //     {
  //       method: 'POST',
  //       body: formData,
  //     }
  //   )
  //     .then((response) => response.json())
  //     .then((result) => {
  //       console.log('Success:', result);
  //     })
  //     .catch((error) => {
  //       console.error('Error:', error);
  //     });
  // };



  return <div>
    <Head>
      <title>
        Enter Data
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
            width: '80%',
            m: -1
          }}
        >
          <div style={{
            display: 'flex',
            flexDirection: 'row',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <Typography
              sx={{ m: 1 }}
              variant="h4"
            >
              Enter Data
            </Typography>
            {/* <div style={{
              cursor: "pointer"
            }} >
              <Typography
                sx={{ m: 1 }}
                variant="h5"
                onClick={() => onImportClick()}
              >
                Import
              </Typography>
              <input type="file" name="file" onChange={changeHandler} />
            </div> */}
          </div>

          <DataForm />
        </Box>
      </Container>
    </Box>
  </div>

}
EnterData.getLayout = (page) => (
  <DashboardLayout>
    {page}
  </DashboardLayout>
);

export default EnterData;
