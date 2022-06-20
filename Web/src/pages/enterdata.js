import Head from 'next/head';
import { Box, Container, Typography } from '@mui/material';
import { CustomerListResults } from '../components/customer/customer-list-results';
import { CustomerListToolbar } from '../components/customer/customer-list-toolbar';
import { DashboardLayout } from '../components/dashboard-layout';
import { customers } from '../__mocks__/customers';
import DataForm from 'src/components/dataForm';

const EnterData = () => (
  <>
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
            m: -1
          }}
        >
          <Typography
            sx={{ m: 1 }}
            variant="h4"
          >
            Enter Data
          </Typography>
          <DataForm />
        </Box>
      </Container>
    </Box>
  </>
);
EnterData.getLayout = (page) => (
  <DashboardLayout>
    {page}
  </DashboardLayout>
);

export default EnterData;
