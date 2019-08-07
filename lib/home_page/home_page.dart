import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:wakeme_when_reached/home_page/blocs/home_bloc.dart';
import 'package:wakeme_when_reached/home_page/location_radius.dart';
import 'package:wakeme_when_reached/constants.dart';


class HomePage extends StatefulWidget {

//  GoogleMapsPlaces gPlaces = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc;
  GoogleMapController controller; // = Completer();

  _HomePageState() {
    homeBloc = new HomeBloc();
    homeBloc.dispatch(LoadHomePageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageDecider(context),
    );
  }


  Widget pageDecider(BuildContext context) {
    return BlocBuilder(
      bloc: homeBloc,
      builder: (BuildContext context, HomeState state) {
        if (state is HomeStateLoading) {
          return centerLoading();
        } else if (state is HomeStatePermissionDenied) {
          return locationPermissionRequired();
        } else if (state is HomeStateLoadUserLocation) {
          return loadMaps(context, state.latLng);
        }
      },
    );
  }

  Widget loadMaps(BuildContext context, LatLng latlng) {
    try {

      _onWidgetDidBuild(() {

        try {
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(latlng.latitude, latlng.longitude),
                  zoom: 15.0),
            ),
          );


/*          controller.addMarker(
            MarkerOptions(
              position: LatLng(37.4219999, -122.0862462),
            ),
          );*/


        }catch(e){
          int my=5;
        }

      });

      return Stack(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              onCameraMoveStarted: (){
                int x=55;
              },
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: latlng,
                zoom: 16,
              ),
              onMapCreated: (GoogleMapController myController) {
                controller = myController;
                //controller.complete(myController);
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: LocationRadius(
                homeBloc: homeBloc, mapController: controller),
          ),
        ],
      );
    }catch(e){
      int my=10;
    }
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Widget centerLoading() {

    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        strokeWidth: 3.0,
      ),
    );
  }

  Widget locationPermissionRequired() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "This app requires location permission to work!",
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Color(0XFF505c7e),
        ),
      ),
    );
  }
}
