import 'package:flutter/material.dart'; //for required annotation
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable{
  HomeState([List props = const []]) : super(props);
}

class HomeStateLoading extends HomeState{

}

class HomeStatePermissionDenied extends HomeState{

}

class HomeStateLoadUserLocation extends HomeState{
  LatLng latLng;

  HomeStateLoadUserLocation({
    @required this.latLng,
  }) : super([latLng]);

}