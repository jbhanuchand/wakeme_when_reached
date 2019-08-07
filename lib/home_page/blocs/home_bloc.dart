import 'package:bloc/bloc.dart';
import 'package:wakeme_when_reached/home_page/blocs/home_event.dart';
import 'package:wakeme_when_reached/home_page/blocs/home_state.dart';

export 'package:wakeme_when_reached/home_page/blocs/home_event.dart';
export 'package:wakeme_when_reached/home_page/blocs/home_state.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wakeme_when_reached/home_page/home_page.dart';

import 'package:google_maps_webservice/places.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final String myGoogleApiKey = "AIzaSyDaB5_UiY3hCs9aJjcT9pYon8MqIJSKx2Q";

  @override
  HomeState get initialState {
    return HomeStateLoading();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadHomePageEvent) {
      try {
        //     LocationData currentLocation = await Location().getLocation();
        yield HomeStateLoadUserLocation(
//          latLng: LatLng(currentLocation.latitude, currentLocation.longitude),
          latLng: LatLng(37.4219983, -122.084),
        );
      } catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          yield HomeStatePermissionDenied();
        }
      }
    } else if (event is LoadLocationSelectedEvent) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: myGoogleApiKey);
      PlacesDetailsResponse place =
          await _places.getDetailsByPlaceId(event.placeId);
      yield HomeStateLoadUserLocation(
        latLng: LatLng(place.result.geometry.location.lat,
            place.result.geometry.location.lng),
      );
    }
  }
}

//PlacesDetailsResponse place =
//        await _places.getDetailsByPlaceId(widget.placeId);
