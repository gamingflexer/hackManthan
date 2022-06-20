import { Avatar, Card, CardContent, Grid, Typography } from '@mui/material';
import AttachMoneyIcon from '@mui/icons-material/AttachMoney';
import Link from 'next/link'


export const TotalProfit = (props) => (
  <Card {...props}>
    <CardContent>
      {/* <Grid
        container
        spacing={3}
        sx={{ justifyContent: 'space-between' }}
      >
        <Grid item>
          <Typography
            color="textSecondary"
            gutterBottom
            variant="overline"
          >
            TOTAL PROFIT
          </Typography>
          <Typography
            color="textPrimary"
            variant="h4"
          >
            $23k
          </Typography>
        </Grid>
        <Grid item>
          <Avatar
            sx={{
              backgroundColor: 'primary.main',
              height: 56,
              width: 56
            }}
          >
            <AttachMoneyIcon />
          </Avatar>
        </Grid>
      </Grid> */}
      <div style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        cursor: "pointer"
      }}>
        <Link href="/analyse">
          {"Go To Analysis ->"}
        </Link>
      </div>
    </CardContent>
  </Card>
);
