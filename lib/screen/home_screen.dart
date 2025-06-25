import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathernow/cubit/network_cubit.dart';
import 'package:weathernow/model/weather_model.dart';
import 'package:weathernow/widgets/custom_card.dart';
import 'package:weathernow/widgets/glassmorphism.dart';
import 'package:weathernow/widgets/sunset_sunrise_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NetworkCubit, NetworkState>(
        builder: (context, state) {
          if (state is NetworkLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is NetworkErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is NetworkSuccessState) {
            WeatherModel data = state.data;
            int? sunsetTimestamp = data.sys!.sunset;
            int? sunriseTimestamp = data.sys!.sunrise;

            DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
              sunsetTimestamp! * 1000,
            );
            DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
              sunriseTimestamp! * 1000,
            );

            String formatSunset =
                "${sunset.hour.toString().padLeft(2, '0')}:${sunset.minute.toString().padLeft(2, '0')}";
            String formatSunrise =
                "${sunrise.hour.toString().padLeft(2, '0')}:${sunrise.minute.toString().padLeft(2, '0')}";

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GlassBox(
                      height: 200,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(CupertinoIcons.cloud_sun, size: 150),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${data.weather[0].description}'),
                              Text(
                                '${data.main!.temp}°',
                                style: TextStyle(fontSize: 50),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  AirInfoCard(
                    humidity: data.main!.humidity.toString(),
                    pressure: '${data.main!.pressure}',
                    feelsLike: '${data.main!.feelsLike}',
                    precipitation: '${data.clouds!.all}',
                    visibility: '${data.wind!.deg}',
                    wind: '${data.wind!.speed}',
                  ),
                  SunsetSunriseCard(
                    sunset: formatSunset,
                    sunrise: formatSunrise,
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
