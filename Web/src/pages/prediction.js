import { DashboardLayout } from '../components/dashboard-layout';
import Head from 'next/head';
import { Box, Container, Typography } from '@mui/material';
import PredictForm from 'src/components/predictForm';


const Prediction = () => {
    return <>
        <Head>
            <title>
                Predict
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
                        Prediction
                    </Typography>
                    <PredictForm />
                </Box>
            </Container>
        </Box>
    </>
}

Prediction.getLayout = (page) => (
    <DashboardLayout>
        {page}
    </DashboardLayout>
);

export default Prediction