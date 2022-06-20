import { useEffect } from 'react';
import NextLink from 'next/link';
import { useRouter } from 'next/router';
import PropTypes from 'prop-types';
import { Box, Button, Divider, Drawer, Typography, useMediaQuery } from '@mui/material';
import { ChartBar as ChartBarIcon } from '../icons/chart-bar';
import { Selector as SelectorIcon } from '../icons/selector';
import { Logo } from './logo';
import { NavItem } from './nav-item';
import BorderColorIcon from '@mui/icons-material/BorderColor';
import BatchPredictionIcon from '@mui/icons-material/BatchPrediction';
import ShowChartIcon from '@mui/icons-material/ShowChart';
import MyLocationIcon from '@mui/icons-material/MyLocation';
import AddAlertIcon from '@mui/icons-material/AddAlert';
import SettingsIcon from '@mui/icons-material/Settings';
import { fontSize } from '@mui/system';

const items = [
  {
    href: '/',
    icon: (<ChartBarIcon />),
    title: 'Dashboard'
  },
  {
    href: '/enterdata',
    icon: (<BorderColorIcon />),
    title: 'Enter Data'
  },
  {
    href: '/analyse',
    icon: (<ShowChartIcon />),
    title: 'Analysis'
  },
  {
    href: '/prediction',
    icon: (<BatchPredictionIcon />),
    title: 'Predictions'
  },
  // {
  //   href: '/mapPolice',
  //   icon: (<MyLocationIcon />),
  //   title: 'Map'
  // },
  {
    href: '/alerts',
    icon: (<AddAlertIcon />),
    title: 'Alerts Sender'
  },
  {
    href: '/settings',
    icon: (<SettingsIcon />),
    title: 'Settings'
  }
];

export const DashboardSidebar = (props) => {
  const { open, onClose } = props;
  const router = useRouter();
  const lgUp = useMediaQuery((theme) => theme.breakpoints.up('lg'), {
    defaultMatches: true,
    noSsr: false
  });

  useEffect(
    () => {
      if (!router.isReady) {
        return;
      }

      if (open) {
        onClose?.();
      }
    },
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [router.asPath]
  );

  const content = (
    <>
      <Box
        sx={{
          display: 'flex',
          flexDirection: 'column',
          height: '100%'
        }}
      >
        <div style={{
          display: "flex",
          flexDirection: "row",
          alignItems: "center",
        }}>
          <Box sx={{ p: 3 }}>
            <NextLink
              href="/"
              passHref
            >
              <a>
                <Logo
                  sx={{
                    height: 42,
                    width: 42
                  }}
                />
              </a>
            </NextLink>
          </Box>
          <div style={{
            fontWeight: "bold",
            fontSize: "18px"
          }}>
            Police
          </div>
        </div>
        <Divider
          sx={{
            borderColor: '#2D3748',
            marginBottom: 3
          }}
        />
        <Box sx={{ flexGrow: 1 }}>
          {items.map((item) => (
            <NavItem
              key={item.title}
              icon={item.icon}
              href={item.href}
              title={item.title}
            />
          ))}
        </Box>
        <Divider sx={{ borderColor: '#2D3748' }} />
      </Box>
    </>
  );

  if (lgUp) {
    return (
      <Drawer
        anchor="left"
        open
        PaperProps={{
          sx: {
            backgroundColor: 'neutral.900',
            color: '#FFFFFF',
            width: 280
          }
        }}
        variant="permanent"
      >
        {content}
      </Drawer>
    );
  }

  return (
    <Drawer
      anchor="left"
      onClose={onClose}
      open={open}
      PaperProps={{
        sx: {
          backgroundColor: 'neutral.900',
          color: '#FFFFFF',
          width: 280
        }
      }}
      sx={{ zIndex: (theme) => theme.zIndex.appBar + 100 }}
      variant="temporary"
    >
      {content}
    </Drawer>
  );
};

DashboardSidebar.propTypes = {
  onClose: PropTypes.func,
  open: PropTypes.bool
};
