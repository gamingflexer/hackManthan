import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackmanthan_app/bloc/map_bloc/map_bloc_files.dart';
import 'package:hackmanthan_app/models/crime.dart';
import 'package:hackmanthan_app/models/helper_models.dart';
import 'package:hackmanthan_app/repositories/location_repository.dart';
import 'package:hackmanthan_app/shared/error_screen.dart';
import 'package:hackmanthan_app/shared/loading.dart';
import 'package:hackmanthan_app/shared/shared_widgets.dart';
import 'package:hackmanthan_app/theme/theme.dart';
import 'package:hackmanthan_app/views/add_crime_page.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapController mapController = MapController();
  late DraggableScrollableController scrollController;
  late ScrollController innerScrollController;

  Crime? crime;

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(GetHomeContents());
    // mapController = MapController();
    scrollController = DraggableScrollableController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state.pageState == PageState.loading) {
          return const LoadingPage();
        }
        if (state.pageState == PageState.error) {
          return const SomethingWentWrong();
        }
        if (state.pageState == PageState.success) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: LatLng(state.currentLat, state.currentLong),
                  zoom: 13.0,
                  onMapCreated: (c) {
                    mapController = c;
                  },
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7 + 45.w,
                    child: Column(
                      children: [
                        SizedBox(height: 77.w),
                        buildDirectionButton(state),
                      ],
                    ),
                  ),
                  DraggableScrollableSheet(
                    controller: scrollController,
                    minChildSize: 0.2,
                    initialChildSize: 0.4,
                    builder: (context, controller) {
                      innerScrollController = controller;
                      return SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 84.w),
                                const Spacer(),
                                buildGoToKolkataButton(),
                                const Spacer(),
                                buildCurrentButton(state),
                              ],
                            ),
                            crime != null
                                ? buildCurrentCrimeCard()
                                : const SizedBox.shrink(),
                            buildBottomSheet(context, state),
                          ],
                        ),
                      );
                    },
                  ),
                  buildAppBar(),
                ],
              ),
            ),
          );
        }
        return const LoadingPage();
      },
    );
  }

  Stack buildCurrentCrimeCard() {
    return Stack(
      children: [
        Container(
          width: 366.w,
          decoration: BoxDecoration(
            color: CustomTheme.card,
            borderRadius: BorderRadius.circular(15.w),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
              )
            ],
          ),
          // margin: EdgeInsets.only(bottom: 12.w),
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: buildCrimeCard(crime!),
        ),
        Container(
          width: 366.w,
          alignment: Alignment.topRight,
          padding: EdgeInsets.all(10.w),
          child: InkWell(
            onTap: () {
              setState(() {
                crime = null;
              });
            },
            child: Icon(
              Icons.close_rounded,
              size: 26.w,
            ),
          ),
        )
      ],
    );
  }

  Widget buildCurrentButton(MapState state) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(right: 24.w, bottom: 12.w),
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
            child: Card(
              margin: EdgeInsets.zero,
              color: CustomTheme.card,
              shape: const CircleBorder(),
              elevation: 6,
              child: InkWell(
                borderRadius: BorderRadius.circular(25.w),
                onTap: () {
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
                child: Icon(
                  locationIcon,
                  size: 28.w,
                  color: locationIcon == Icons.my_location_rounded
                      ? Colors.blueAccent
                      : CustomTheme.t1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildGoToKolkataButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        shadowColor: CustomTheme.cardShadow,
        primary: CustomTheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
      ),
      onPressed: () {
        mapController.moveAndRotate(
          LatLng(LocationRepository.kolkataLat, LocationRepository.kolkataLong),
          12,
          0,
        );
      },
      child: Container(
        height: 45.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
        child: Text(
          'Go to Kolkata',
          style: TextStyle(
            color: CustomTheme.t1,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildDirectionButton(MapState state) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(right: 24.w, top: 24.w),
      child: StreamBuilder<MapEvent>(
        stream: mapController.mapEventStream,
        builder: (context, snapshot) {
          return SizedBox(
            height: 45.w,
            width: 45.w,
            child: Card(
              margin: EdgeInsets.zero,
              color: CustomTheme.card,
              shape: const CircleBorder(),
              elevation: 6,
              child: InkWell(
                borderRadius: BorderRadius.circular(25.w),
                onTap: () {
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
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildAppBar() {
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
      margin: EdgeInsets.only(top: 12.w),
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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddCrimePage(
                  currentLat: state.currentLat,
                  currentLong: state.currentLong,
                );
              }));
            },
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
            Row(
              children: [
                buildCrimeCard(state.crimes[i]),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    await scrollDrawerToTop();
                    setState(() {
                      crime = state.crimes[i];
                    });
                    mapController.moveAndRotate(
                      LatLng(state.crimes[i].lat, state.crimes[i].long),
                      14,
                      0,
                    );
                  },
                  icon: Icon(
                    Icons.travel_explore_rounded,
                    color: CustomTheme.accent,
                    size: 34.w,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> scrollDrawerToTop() async {
    scrollController.animateTo(
      0.4,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    innerScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Widget buildCrimeCard(Crime crime) {
    return SizedBox(
      // height: 126.w,
      width: 310.w,
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  'Station: ${crime.policeStation}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: CustomTheme.t1,
                  ),
                ),
              ),
              // SizedBox(width: 30.w),
              Expanded(
                child: Text(
                  'Circle: ${crime.circle}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: CustomTheme.t1,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.w),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  'Source: ${crime.source}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: CustomTheme.t1,
                  ),
                ),
              ),
              // SizedBox(width: 30.w),
              Expanded(
                child: Text(
                  'District: ${crime.district}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: CustomTheme.t1,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.w),
          Text(
            '${DateFormat.jm().format(crime.time.toDate())} ${DateFormat.yMMMMd().format(crime.time.toDate())}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: CustomTheme.t1,
            ),
          ),
          SizedBox(height: 6.w),
          crime.isLive || crime.isViolent
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Tags',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: CustomTheme.t1,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    crime.isViolent
                        ? Container(
                            margin: EdgeInsets.only(right: 5.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 9.w, vertical: 3.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                            child: const Text(
                              'Violent',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    crime.isLive
                        ? Container(
                            margin: EdgeInsets.only(right: 5.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 9.w, vertical: 3.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.greenAccent[700]!,
                              ),
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                            child: Text(
                              'Live',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.greenAccent[700]!,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                )
              : const SizedBox.shrink(),
          SizedBox(height: 16.w),
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
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
              )
            ],
          ),
          alignment: Alignment.center,
        );
      },
    ));
    for (var crime in state.crimes) {
      markers.add(Marker(
        point: LatLng(crime.lat, crime.long),
        builder: (context) {
          return InkWell(
            onTap: () async {
              await scrollDrawerToTop();
              setState(() {
                this.crime = crime;
              });
              mapController.moveAndRotate(
                LatLng(crime.lat, crime.long),
                14,
                0,
              );
            },
            child: Container(
              height: crime.isLive ? 30.w : 10.w,
              width: crime.isLive ? 30.w : 10.w,
              decoration: BoxDecoration(
                color: crime.isLive ? Colors.redAccent[700] : Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.w,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                  )
                ],
              ),
              alignment: Alignment.center,
            ),
          );
        },
      ));
    }

    return markers;
  }
}
