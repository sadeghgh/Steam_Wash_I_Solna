import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:steam_wash_i_solna/functions.dart';
import 'package:steam_wash_i_solna/lastPage.dart';

import 'drawer.dart';

class MapPage extends StatefulWidget {
  var name, desc, prices, dataAndTime;
  MapPage(this.name, this.desc, this.prices, this.dataAndTime);

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
  String? cod, phone;
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
        backgroundColor: Colors.blueGrey[300],
        shadowColor: Colors.grey,
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
                        initialCameraPosition: CameraPosition(
                          target: _userLocation ??
                              LatLng(59.330678551220515, 18.071957153518493),
                          zoom: 15.0,
                        ),
                        myLocationEnabled: true,
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
                          _markerLocation != null
                              ? goToLastPage(_markerLocation!.latitude,
                                  _markerLocation!.longitude, cod)
                              : goToLastPage(_userLocation!.latitude,
                                  _userLocation!.longitude, cod);
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

  goToLastPage(var lat, var lng, var code) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LastPage(widget.name, widget.desc, widget.prices,
            lat, lng, widget.dataAndTime, code, phone)));
  }

  Future comparisonCode() async {
    currentUserUid = _auth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(currentUserUid)
        .get()
        .then((value) {
      cod = value['code'];
      phone = value['phone'];
    });
  }
}
