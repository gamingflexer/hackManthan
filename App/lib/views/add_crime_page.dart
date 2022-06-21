import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackmanthan_app/bloc/map_bloc/map_bloc.dart';
import 'package:hackmanthan_app/models/crime.dart';
import 'package:hackmanthan_app/repositories/location_repository.dart';
import 'package:hackmanthan_app/shared/error_screen.dart';
import 'package:hackmanthan_app/shared/loading.dart';
import 'package:hackmanthan_app/shared/shared_widgets.dart';
import 'package:hackmanthan_app/theme/theme.dart';
import 'package:latlong2/latlong.dart';

class AddCrimePage extends StatefulWidget {
  final double currentLat;
  final double currentLong;

  const AddCrimePage(
      {Key? key, required this.currentLat, required this.currentLong})
      : super(key: key);

  @override
  State<AddCrimePage> createState() => _AddCrimePageState();
}

class _AddCrimePageState extends State<AddCrimePage> {
  String eventType = '';
  String eventSubType = 'Attack';
  String circle = '';
  bool isLive = true;
  String isLiveStr = 'Live Crime';
  String district = '';
  String policeStation = '';
  double lat = 0;
  double long = 0;
  bool isViolent = true;
  String isViolentStr = 'Violent';
  String source = '';
  DateTime time = DateTime.now();

  late MapController mapController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.bg,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomBackButton(),
                  SizedBox(height: 30.w),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      'Add Crime',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: CustomTheme.t1,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.w),
                  buildTitle('Event Type'),
                  buildEventType(),
                  SizedBox(height: 20.w),
                  buildTitle('Event Subtype'),
                  buildEventSubType(),
                  SizedBox(height: 20.w),
                  buildTitle('Circle'),
                  buildCircle(),
                  SizedBox(height: 20.w),
                  buildTitle('Police Station'),
                  buildPoliceStation(),
                  SizedBox(height: 20.w),
                  buildTitle('Location'),
                  buildLocationPicker(context),
                  SizedBox(height: 20.w),
                  buildTitle('District'),
                  buildDistrict(),
                  SizedBox(height: 20.w),
                  buildTitle('Crime Status'),
                  buildIsLive(),
                  SizedBox(height: 20.w),
                  buildTitle('Crime Violence Status'),
                  buildIsViolent(),
                  SizedBox(height: 20.w),
                  buildTitle('Source'),
                  buildSource(),
                  SizedBox(height: 20.w),
                  CustomElevatedButton(
                    text: 'Add Crime',
                    onPressed: () async {
                      if (lat == 0 || long == 0) {
                        showErrorSnackBar(context, 'Please select a location!');
                      }
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      _formKey.currentState?.save();
                      Crime crime = Crime(
                        source: source,
                        eventType: eventType,
                        eventSubType: eventSubType,
                        circle: circle,
                        isLive: isLive,
                        district: district,
                        policeStation: policeStation,
                        lat: lat,
                        long: long,
                        isViolent: isViolent,
                        time: Timestamp.now(),
                      );
                      showLoadingSnackBar(context);
                      print(crime);
                      var res = await context
                          .read<MapBloc>()
                          .databaseRepository
                          .addCrime(crime);

                      if (!mounted) return;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 100.w),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomShadow buildEventType() {
    return CustomShadow(
      child: TextFormField(
        decoration: customInputDecoration(labelText: 'Eg. Threat in Person'),
        style: formTextStyle(),
        onSaved: (value) {
          eventType = value ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Event Type';
          }
          return null;
        },
      ),
    );
  }

  CustomShadow buildEventSubType() {
    return CustomShadow(
      child: DropdownSearch<String>(
        items: subTypeList,
        popupProps: PopupProps.dialog(
          dialogProps: DialogProps(
            insetPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
            contentPadding: EdgeInsets.all(5.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.w),
            ),
          ),
          searchFieldProps: TextFieldProps(
            style: formTextStyle(),
            decoration: customInputDecoration(
              labelText: 'SubType',
              isSearch: true,
            ),
          ),
          showSearchBox: true,
          showSelectedItems: true,
        ),
        onSaved: (value) {
          eventSubType = value ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Event Type';
          }
          return null;
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration:
                customInputDecoration(labelText: 'SubType'),
            baseStyle: formTextStyle()),
        onChanged: (value) {
          eventSubType = value ?? eventSubType;
        },
      ),
    );
  }

  CustomShadow buildCircle() {
    return CustomShadow(
      child: TextFormField(
        decoration: customInputDecoration(labelText: 'Eg. C1'),
        style: formTextStyle(),
        onSaved: (value) {
          circle = value ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Circle';
          }
          return null;
        },
      ),
    );
  }

  CustomShadow buildPoliceStation() {
    return CustomShadow(
      child: TextFormField(
        decoration: customInputDecoration(labelText: 'Eg. PS1'),
        style: formTextStyle(),
        onSaved: (value) {
          policeStation = value ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Police Station';
          }
          return null;
        },
      ),
    );
  }

  CustomShadow buildDistrict() {
    return CustomShadow(
      child: TextFormField(
        decoration: customInputDecoration(labelText: 'Eg. Lucknow'),
        style: formTextStyle(),
        onSaved: (value) {
          district = value ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter District';
          }
          return null;
        },
      ),
    );
  }

  CustomShadow buildIsLive() {
    return CustomShadow(
      child: DropdownButtonFormField<String>(
        value: isLiveStr,
        decoration: customInputDecoration(labelText: 'Crime Status'),
        items: <DropdownMenuItem<String>>[
          DropdownMenuItem(
            value: 'Live Crime',
            child: SizedBox(
              width: 295.w,
              child: Text(
                'Live Crime',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CustomTheme.t1,
                ),
              ),
            ),
          ),
          DropdownMenuItem<String>(
            value: 'Old Crime',
            child: SizedBox(
              width: 295.w,
              child: Text(
                'Old Crime',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CustomTheme.t1,
                ),
              ),
            ),
          ),
        ],
        onChanged: (value) {
          isLiveStr = value as String;
          isLive = value == 'Live Crime';
        },
      ),
    );
  }

  CustomShadow buildIsViolent() {
    return CustomShadow(
      child: DropdownButtonFormField<String>(
        value: isViolentStr,
        decoration: customInputDecoration(labelText: 'Crime Status'),
        items: <DropdownMenuItem<String>>[
          DropdownMenuItem(
            value: 'Violent',
            child: SizedBox(
              width: 295.w,
              child: Text(
                'Violent',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CustomTheme.t1,
                ),
              ),
            ),
          ),
          DropdownMenuItem<String>(
            value: 'Not Violent',
            child: SizedBox(
              width: 295.w,
              child: Text(
                'Not Violent',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CustomTheme.t1,
                ),
              ),
            ),
          ),
        ],
        onChanged: (value) {
          isViolentStr = value as String;
          isViolent = value == 'Violent';
        },
      ),
    );
  }

  Widget buildLive() {
    return SwitchListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 0),
      activeColor: CustomTheme.accent,
      title: Text(
        'Crime Status',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w300,
          color: CustomTheme.t1,
        ),
      ),
      value: isLive,
      onChanged: (bool newValue) {
        setState(() {
          isLive = newValue;
        });
      },
    );
  }

  CustomShadow buildSource() {
    return CustomShadow(
      child: TextFormField(
        decoration: customInputDecoration(labelText: 'Eg. Phone'),
        style: formTextStyle(),
        onSaved: (value) {
          source = value ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter source';
          }
          return null;
        },
      ),
    );
  }

  Padding buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 14.w, bottom: 6.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: CustomTheme.t2,
        ),
      ),
    );
  }

  Widget buildLocationPicker(BuildContext context) {
    return SizedBox(
      height: 160.w,
      child: Card(
        margin: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 3,
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(lat == 0 ? LocationRepository.lucknowLat : lat,
                    long == 0 ? LocationRepository.lucknowLong : long),
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
                MarkerLayerOptions(markers: []),
              ],
            ),
            Container(
              color: lat == 0 && long == 0
                  ? Colors.black.withOpacity(0.15)
                  : Colors.transparent,
              alignment: Alignment.center,
              child: lat == 0 && long == 0
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        shadowColor: CustomTheme.cardShadow,
                        primary: CustomTheme.accent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                      ),
                      onPressed: () async {
                        var res = await showDialog(
                          context: context,
                          builder: (context) {
                            return buildDialog();
                          },
                        );
                        if (res != null) {
                          if (res is LatLng) {
                            setState(() {
                              lat = res.latitude;
                              long = res.longitude;
                            });
                            mapController.move(res, 14.0);
                          }
                        }
                      },
                      child: Container(
                        height: 45.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 35.w, vertical: 12.w),
                        child: Text(
                          'Select Location',
                          style: TextStyle(
                            color: CustomTheme.onAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.w),
                            child: Icon(
                              Icons.location_on_sharp,
                              color: Colors.red,
                              size: 50.w,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.all(10.w),
                          child: SizedBox(
                            height: 40.w,
                            width: 40.w,
                            child: Card(
                              margin: EdgeInsets.zero,
                              color: CustomTheme.card,
                              shape: const CircleBorder(),
                              elevation: 6,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(25.w),
                                onTap: () async {
                                  var res = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return buildDialog();
                                    },
                                  );
                                  if (res != null) {
                                    if (res is LatLng) {
                                      setState(() {
                                        print('hi');
                                        lat = res.latitude;
                                        long = res.longitude;
                                      });
                                      mapController.move(res, 14.0);
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: 24.w,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDialog() {
    return StatefulBuilder(builder: (context, setState) {
      MapController mapPickerController = MapController();
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          decoration: BoxDecoration(
            color: CustomTheme.card,
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 62.w,
                padding: EdgeInsets.only(left: 19.w),
                alignment: Alignment.centerLeft,
                child: Material(
                  child: Text(
                    'Pick Location',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: CustomTheme.t1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 400.w,
                child: FlutterMap(
                  mapController: mapPickerController,
                  options: MapOptions(
                    center: LatLng(widget.currentLat, widget.currentLong),
                    zoom: 13.0,
                    onMapCreated: (c) {
                      mapPickerController = c;
                    },
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                      tileProvider: const NonCachingNetworkTileProvider(),
                    ),
                    MarkerLayerOptions(markers: [
                      Marker(
                        point: LatLng(widget.currentLat, widget.currentLong),
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
                                BoxShadow(color: Colors.grey, blurRadius: 10.0)
                              ],
                            ),
                            alignment: Alignment.center,
                          );
                        },
                      )
                    ]),
                  ],
                  nonRotatedChildren: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.w),
                        child: Icon(
                          Icons.location_on_sharp,
                          color: Colors.red,
                          size: 50.w,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(right: 20.w, bottom: 20.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(width: 80.w),
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              shadowColor: CustomTheme.cardShadow,
                              primary: CustomTheme.card,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.w),
                              ),
                            ),
                            onPressed: () {
                              mapPickerController.moveAndRotate(
                                LatLng(LocationRepository.lucknowLat,
                                    LocationRepository.lucknowLong),
                                mapPickerController.zoom,
                                0,
                              );
                            },
                            child: Container(
                              height: 45.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 12.w),
                              child: Text(
                                'Go to Lucknow',
                                style: TextStyle(
                                  color: CustomTheme.t1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          StreamBuilder<MapEvent>(
                            stream: mapPickerController.mapEventStream,
                            builder: (context, snapshot) {
                              IconData locationIcon = Icons.my_location_rounded;
                              if (snapshot.data != null) {
                                if (snapshot.data!.center.latitude !=
                                        widget.currentLat ||
                                    snapshot.data!.center.longitude !=
                                        widget.currentLong) {
                                  locationIcon =
                                      Icons.location_searching_rounded;
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
                                      mapPickerController.moveAndRotate(
                                        LatLng(widget.currentLat,
                                            widget.currentLong),
                                        mapPickerController.zoom,
                                        0,
                                      );
                                      mapPickerController.mapEventSink
                                          .add(MapEventMoveEnd(
                                        source: MapEventSource.custom,
                                        center: LatLng(widget.currentLat,
                                            widget.currentLong),
                                        zoom: mapPickerController.zoom,
                                      ));
                                    },
                                    child: Icon(
                                      locationIcon,
                                      size: 28.w,
                                      color: locationIcon ==
                                              Icons.my_location_rounded
                                          ? Colors.blueAccent
                                          : CustomTheme.t1,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 56.w,
                padding: EdgeInsets.only(right: 20.w),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            LatLng(mapPickerController.center.latitude,
                                mapPickerController.center.longitude));
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CustomTheme.accent,
                        ),
                      ),
                    ),
                    SizedBox(width: 9.w),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CustomTheme.t1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
