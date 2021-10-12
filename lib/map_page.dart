import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:steam_wash_i_solna/functions.dart';
import 'package:steam_wash_i_solna/lastPage.dart';

import 'drawer.dart';

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, required LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}

class MapPage extends StatefulWidget {
  var name, desc, prices;
  MapPage(this.name, this.desc, this.prices);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? currentUserUid;
  Future<LocationData>? _getUserLocation;
  List<ProductCode> _items = [];
  LatLng? _markerLocation;
  LatLng? _userLocation;
  String? _resultAddress;
  String? cod;
  var user;

  Future<LocationData?> getUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    final result = await location.getLocation();

    _userLocation = LatLng(result.latitude!, result.longitude!);
    return result;
  }

  getSetAddress(Coordinates coordinates) async {
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _resultAddress = addresses.first.addressLine;
    });
  }

  @override
  void initState() {
    super.initState();

    _getUserLocation = getUserLocation() as Future<LocationData>?;
    comparisonCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      drawer: SizedBox(
        child: Drawer(
          child: SafeArea(child: CustomDrawer()),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<LocationData?>(
                future: _getUserLocation,
                builder: (context, snapshot) {
                  switch (snapshot.hasData) {
                    case true:
                      return GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target:
                              LatLng(59.330678551220515, 18.071957153518493),
                          zoom: 10.0,
                        ),
                        onTap: (location) {
                          setState(() {
                            _markerLocation = location;
                          });
                        },
                        markers: (_markerLocation == null)
                            ? _markers
                            : {
                                Marker(
                                  markerId: MarkerId('m1'),
                                  flat: true,
                                  infoWindow:
                                      InfoWindow(title: "Tryck på Plats"),
                                  position: _markerLocation ??
                                      LatLng(59.330678551220515,
                                          18.071957153518493),
                                ),
                              },
                      );
                    default:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              ),
            ),
            SizedBox(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    TextButton(
                        onPressed: () async {
                          if (_markerLocation != null) {
                            getSetAddress(Coordinates(_markerLocation!.latitude,
                                _markerLocation!.longitude));
                            //  print(_markerLocation.latitude);
                            //   print(_markerLocation.longitude);
                          } else if (_userLocation != null) {
                            getSetAddress(Coordinates(_userLocation!.latitude,
                                _userLocation!.longitude));
                            //   print(_userLocation.latitude,);
                            //   print(_userLocation.longitude);
                          }
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true, onChanged: (date) {
                            //  print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            // print('confirm $date');
                            goToLastPage(_userLocation!.latitude,
                                _userLocation!.longitude, date, cod);
                          }, currentTime: DateTime.now());
                        },
                        child: Text(
                          'visa datumväljaren',
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  goToLastPage(var lat, var lng, var date, var code) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LastPage(
            widget.name, widget.desc, widget.prices, lat, lng, date, code)));
  }

  Future comparisonCode() async {
    currentUserUid = _auth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(currentUserUid)
        .get()
        .then((value) {
      cod = value['code'];
    });
  }
}
