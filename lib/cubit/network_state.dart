part of 'network_cubit.dart';

@immutable
sealed class NetworkState {}

sealed class NetworkActionState extends NetworkState {}

final class NetworkInitialState extends NetworkState {}

final class NetworkLoadingState extends NetworkState {}

final class NetworkErrorState extends NetworkState {
  final String error;

  NetworkErrorState(this.error);
}

final class NetworkSuccessState extends NetworkState {
  final WeatherModel data;

  NetworkSuccessState(this.data);
}

final class LocationPermissionDenied extends NetworkActionState {}

final class LocationPermissionGranted extends NetworkActionState {}
