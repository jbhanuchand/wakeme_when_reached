import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:wakeme_when_reached/home_page/blocs/home_bloc.dart';
import 'package:wakeme_when_reached/constants.dart';

class LocationRadius extends StatefulWidget {

  final HomeBloc homeBloc;
  GoogleMapController mapController;
  LocationRadius({@required this.homeBloc,this.mapController});

  @override
  _LocationRadiusState createState() => _LocationRadiusState(mapController:mapController);
}

class _LocationRadiusState extends State<LocationRadius> {

  final GoogleMapController mapController;

  _LocationRadiusState({this.mapController});

  @override
  Widget build(BuildContext context) {
    return setLocationAndRadius();
  }

  Widget setLocationAndRadius() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30, top: 28),
            child: Text(
              "Hey,",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, top: 3),
            child: Text(
              "Tell us where would you like to be reminded",
              style: TextStyle(
                fontSize: 13,
                color: Color(0XFF505c7e),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 31),
            decoration: new BoxDecoration(
              color: Color(0XFFf0f2f7),
              borderRadius: new BorderRadius.all(
                Radius.circular(34),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: OutlineButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(34.0),
                    ),
                    borderSide: BorderSide(color: Color(0XFFf0f2f7)),
                    highlightedBorderColor: Color(0XFFf0f2f7),
                    onPressed: () {
                      _handlePressButton();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      child: Text(
                        "Choose location",
                        style: const TextStyle(
                            color: const Color(0xff505c7e),
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  height: 30,
                  color: Color(0X33aab7d7),
                ),
                Expanded(
                  child: OutlineButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(34.0),
                    ),
                    borderSide: BorderSide(color: Color(0XFFf0f2f7)),
                    highlightedBorderColor: Color(0XFFf0f2f7),
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      child: Text(
                        "Set radius",
                        style: const TextStyle(
                            color: const Color(0xff505c7e),
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePressButton() async {
    try {
      Prediction p = await PlacesAutocomplete.show(
        context: context,
        //         strictbounds: center == null ? false : true,
        apiKey: myGoogleApiKey,
        mode: Mode.fullscreen,
        logo: Container(),
        language: "en",
      );


/*      GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: myGoogleApiKey);
      PlacesDetailsResponse place = await _places.getDetailsByPlaceId(p.placeId);


      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(place.result.geometry.location.lat, place.result.geometry.location.lng), zoom: 20.0),
        ),
      );*/


      widget.homeBloc.dispatch(LoadLocationSelectedEvent(placeId: p.placeId));

//      showDetailPlace(p.placeId);
    } catch (e) {
      int x = 55;
      return;
    }
  }

}
