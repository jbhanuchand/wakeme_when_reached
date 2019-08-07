import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]): super(props);
}

class LoadHomePageEvent extends HomeEvent{

}

class LoadLocationSelectedEvent extends HomeEvent{
  String placeId;
  LoadLocationSelectedEvent({this.placeId});
}