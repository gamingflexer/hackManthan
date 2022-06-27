import Head from 'next/head';
import { Box, Container, Typography } from '@mui/material';
import { CustomerListResults } from '../components/customer/customer-list-results';
import { CustomerListToolbar } from '../components/customer/customer-list-toolbar';
import { DashboardLayout } from '../components/dashboard-layout';
import { customers } from '../__mocks__/customers';
import DataForm from 'src/components/dataForm';
import { useState } from 'react';
import Link from 'next/link';

const EnterData = () => {


    const [selectedFile, setSelectedFile] = useState();
    const [isFilePicked, setIsFilePicked] = useState(false)
    const [isSubmitting, setIsSubmitting] = useState(false)
    const [hasSubmitted, setHasSubmitted] = useState(false)
    const [link, setLink] = useState("")
    const [error, setError] = useState("")

    const changeHandler = (event) => {
        setSelectedFile(event.target.files[0]);
        console.log(event.target.files[0])
        setIsFilePicked(true);
    };

    const handleReset = () => {
        setSelectedFile(null)
        setIsFilePicked(false)
        setHasSubmitted(false)
        setIsSubmitting(false)
        setLink("")
        setError("")
    }

    const onImportClick = async () => {
        const formData = new FormData();
        console.log(selectedFile)
        formData.append('file', selectedFile);
        // const params = {
        //   file: formData
        // }
        console.log(formData)
        setIsSubmitting(true)
        if (hasSubmitted) {
            setHasSubmitted(false)
        }
        if (link) {
            setLink("")
        }
        if (error) {
            setError("")
        }
        // console.log(JSON.stringify(params))
        fetch(
            'http://20.204.104.233:8888/file-upload',
            {
                method: 'POST',
                body: formData,
            }
        )
            .then((response) => response.json())
            .then((result) => {
                console.log('Success:', result);
                if (result.message) {
                    setError(result.message)
                }
                setIsSubmitting(false)
                setLink(result.url)
                setHasSubmitted(true)
            })
            .catch((error) => {
                console.error('Error:', error);
                setIsSubmitting(false)
                setError(error.message)
            });
    };



    return <div>
        <Head>
            <title>
                Upload
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
                        flexDirection: 'column',
                        // justifyContent: 'space-between',
                        // alignItems: 'center'
                    }}>
                        <Typography
                            sx={{ m: 1 }}
                            variant="h4"
                        >
                            Import File For Analysis
                        </Typography>
                        <div style={{
                            display: "flex",
                            flexDirection: "column",
                            // alignItems: "center"
                        }}>
                            <Typography
                                sx={{ m: 1 }}
                                variant="h5"
                                onClick={() => onImportClick()}
                                style={{
                                    cursor: "pointer"
                                }}
                            >
                            </Typography>
                            <div style={{
                                display: "flex",
                                flexDirection: "row",
                                justifyContent: "center",
                                width: "80%",
                                marginTop: 40,
                                gap: 30
                            }}>
                                <label style={{
                                    fontSize: 20,
                                    marginLeft: 10,
                                    padding: "10px 20px",
                                    cursor: "pointer",
                                    border: "2px solid #3F51B5",
                                    borderRadius: 5,
                                }}>
                                    Upload
                                    <input type="file" name="file" onChange={changeHandler} style={{
                                        display: "none"
                                    }} />
                                </label>
                            </div>
                            {
                                isFilePicked ? <div style={{
                                    marginTop: 20,
                                    marginLeft: 10
                                }}>
                                    <div style={{
                                        display: "flex",
                                        flexDirection: "row",
                                        justifyContent: "center",
                                        width: "80%",
                                        fontSize: 20
                                    }}>
                                        FileName : {selectedFile.name}
                                    </div>
                                </div>
                                    : null
                            }
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
                                    onClick={onImportClick}
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
                            {
                                isSubmitting ? <div>Loading..</div> : null
                            }
                            {
                                link ?
                                    <div style={{
                                        marginTop: 20
                                    }}>
                                        Link:
                                        <div>
                                            <a href={link} target="_blank">
                                                {link}
                                            </a>
                                        </div>
                                    </div>
                                    : null

                            }
                            {
                                error ?
                                    <div>
                                        {error}
                                    </div>
                                    : null

                            }
                        </div>
                    </div>

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
