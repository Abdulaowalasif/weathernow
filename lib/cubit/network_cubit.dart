import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weathernow/model/weather_model.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  double _latitude = 0.0;
  double _longitude = 0.0;
  NetworkCubit() : super(NetworkInitialState());

  Future<void> getPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationPermissionDenied());
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      emit(LocationPermissionDenied());
    } else {
      emit(LocationPermissionGranted());
      await getPosition();
    }
  }

  Future<void> getPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    _latitude = position.latitude;
    _longitude = position.longitude;
  }

  Future<void> fetchData() async {
    emit(NetworkLoadingState());
    try {
      final baseUrl = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$_latitude&lon=$_longitude&appid=f00601fed8f2d0c647e0d8bd66e7a0fb&units=metric",
      );

      final response = await http.get(baseUrl);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final weather = WeatherModel.fromJson(jsonData); // Use your model
        emit(NetworkSuccessState(weather));
      } else {
        emit(NetworkErrorState("Error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(NetworkErrorState("Exception: $e"));
    }
  }
}
