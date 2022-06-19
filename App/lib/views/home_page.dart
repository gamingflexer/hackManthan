import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackmanthan_app/bloc/map_bloc/map_bloc_files.dart';
import 'package:hackmanthan_app/models/crime.dart';
import 'package:hackmanthan_app/models/helper_models.dart';
import 'package:hackmanthan_app/shared/loading.dart';
import 'package:hackmanthan_app/shared/shared_widgets.dart';
import 'package:hackmanthan_app/theme/theme.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(GetHomeContents());
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        print(state.currentLat);
        if (state.pageState == PageState.loading) {
          return const LoadingPage();
        }
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(state.currentLat, state.currentLong),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  tileProvider: const NonCachingNetworkTileProvider(),
                ),
                MarkerLayerOptions(markers: markersFromState(state)),
              ],
              nonRotatedChildren: [
                DraggableScrollableSheet(
                  minChildSize: 0.2,
                  initialChildSize: 0.4,
                  builder: (context, controller) {
                    return SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildCurrentButton(state),
                          buildBottomSheet(context, state),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7 + 45.w,
                  child: Column(
                    children: [
                      buildAppBar(),
                      buildDirectionButton(state),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container buildCurrentButton(MapState state) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(right: 24.w, bottom: 24.w),
      child: StreamBuilder<MapEvent>(
        stream: mapController.mapEventStream,
        builder: (context, snapshot) {
          IconData locationIcon = Icons.my_location_rounded;
          if (snapshot.data != null) {
            if (snapshot.data!.center.latitude != state.currentLat ||
                snapshot.data!.center.longitude != state.currentLong) {
              locationIcon = Icons.location_searching_rounded;
            }
          }
          return SizedBox(
            height: 60.w,
            width: 60.w,
            child: FloatingActionButton(
              backgroundColor: CustomTheme.card,
              child: Icon(
                locationIcon,
                size: 28.w,
                color: locationIcon == Icons.my_location_rounded
                    ? Colors.blueAccent
                    : CustomTheme.t1,
              ),
              onPressed: () {
                mapController.moveAndRotate(
                  LatLng(state.currentLat, state.currentLong),
                  mapController.zoom,
                  0,
                );
                mapController.mapEventSink.add(MapEventMoveEnd(
                  source: MapEventSource.custom,
                  center: LatLng(state.currentLat, state.currentLong),
                  zoom: mapController.zoom,
                ));
              },
            ),
          );
        },
      ),
    );
  }

  Container buildDirectionButton(MapState state) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(right: 24.w, top: 24.w),
      child: StreamBuilder<MapEvent>(
        stream: mapController.mapEventStream,
        builder: (context, snapshot) {
          return SizedBox(
            height: 45.w,
            width: 45.w,
            child: FloatingActionButton(
              backgroundColor: CustomTheme.card,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(mapController.rotation / 360),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(-0.5.w, 2.w),
                      child: Icon(
                        Icons.navigation_rounded,
                        size: 21.w,
                        color: Colors.red,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.5.w, -2.w),
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.navigation_rounded,
                          size: 21.w,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                mapController.rotate(0);
                mapController.mapEventSink.add(MapEventRotateEnd(
                  source: MapEventSource.custom,
                  center: LatLng(
                    mapController.center.latitude,
                    mapController.center.longitude,
                  ),
                  zoom: mapController.zoom,
                ));
              },
            ),
          );
        },
      ),
    );
  }

  Container buildAppBar() {
    return Container(
      height: 77.w,
      color: CustomTheme.card,
      child: Row(
        children: [
          SizedBox(width: 62.w),
          const Spacer(),
          SizedBox(
            height: 53.w,
            child: Image.asset('assets/police_logo.png'),
          ),
          SizedBox(width: 11.w),
          Text(
            'Chhattisgarh\nPolice',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: CustomTheme.t1,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings_rounded,
              size: 30.w,
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context, MapState state) {
    return Container(
      decoration: BoxDecoration(
        color: CustomTheme.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(27.w)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32.w,
            alignment: Alignment.center,
            child: Container(
              height: 6.w,
              width: 65.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE7E7E7),
                borderRadius: BorderRadius.circular(10.w),
              ),
            ),
          ),
          CustomElevatedButton(
            text: 'Start Location Sharing',
            onPressed: () {},
          ),
          SizedBox(height: 12.w),
          CustomElevatedButton(
            text: 'Add Crime',
            onPressed: () {},
          ),
          SizedBox(height: 35.w),
          Text(
            'Recent Crimes',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: CustomTheme.t1,
            ),
          ),
          SizedBox(height: 17.w),
          for (int i = 0; i < state.crimes.length; i++)
            buildCrimeCard(state.crimes[i]),
        ],
      ),
    );
  }

  SizedBox buildCrimeCard(Crime crime) {
    return SizedBox(
      height: 126.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.w),
          Text(
            crime.eventType,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: CustomTheme.t1,
            ),
          ),
          SizedBox(height: 6.w),
          Text(
            crime.eventSubType,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: CustomTheme.t2,
            ),
          ),
          SizedBox(height: 6.w),
          Row(
            children: [
              Text(
                'Station: ${crime.policeStation}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: CustomTheme.t1,
                ),
              ),
              SizedBox(width: 30.w),
              Text(
                'Circle: ${crime.circle}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: CustomTheme.t1,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.w),
          Text(
            crime.time.toDate().toIso8601String(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: CustomTheme.t1,
            ),
          ),
          SizedBox(height: 12.w),
        ],
      ),
    );
  }

  List<Marker> markersFromState(MapState state) {
    List<Marker> markers = [];
    markers.add(Marker(
      point: LatLng(state.currentLat, state.currentLong),
      builder: (context) {
        return Container(
          height: 32.w,
          width: 32.w,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 4.w,
            ),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
          ),
          alignment: Alignment.center,
        );
      },
    ));
    for (var crime in state.crimes) {
      markers.add(Marker(
        point: LatLng(crime.lat, crime.long),
        builder: (context) {
          return Card(
            margin: EdgeInsets.zero,
            child: Container(
              height: 25.w,
              width: 25.w,
              decoration: BoxDecoration(
                  color: Colors.redAccent[700],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.w,
                  )),
              alignment: Alignment.center,
            ),
          );
        },
      ));
    }

    return markers;
  }
}
