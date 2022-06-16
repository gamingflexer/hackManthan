import Head from 'next/head';
import { Box, Container, Typography } from '@mui/material';
import { CustomerListResults } from '../components/customer/customer-list-results';
import { CustomerListToolbar } from '../components/customer/customer-list-toolbar';
import { DashboardLayout } from '../components/dashboard-layout';
import { customers } from '../__mocks__/customers';
import DataForm from 'src/components/dataForm';
import AlertForm from '../components/alertsForm'

const Alerts = () => {
    return <>
        <Head>
            <title>
                Send Alert
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
                        Send Alerts
                    </Typography>
                    <AlertForm />
                </Box>
            </Container>
        </Box>
    </>
}

Alerts.getLayout = (page) => (
    <DashboardLayout>
        {page}
    </DashboardLayout>
);

export default Alerts