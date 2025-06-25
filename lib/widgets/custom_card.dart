import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AirInfoCard extends StatelessWidget {
  final String humidity;
  final String pressure;
  final String feelsLike;
  final String precipitation;
  final String wind;
  final String visibility;

  const AirInfoCard({
    super.key,
    required this.humidity,
    required this.pressure,
    required this.feelsLike,
    required this.precipitation,
    required this.wind,
    required this.visibility,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff282828).withValues(alpha: 0.2),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20)
        ),
        height: 300,
        width: double.infinity,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          children: [
            Column(
              children: [
                Icon(Icons.energy_savings_leaf),
                Text(humidity),
                Text('humidity'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.circle_outlined),
                Text(pressure),
                Text('pressure'),
              ],
            ),
            Column(children: [Icon(Icons.sunny), Text(feelsLike), Text('feels like')]),
            Column(
              children: [
                Icon(Icons.water_drop_outlined),
                Text(precipitation),
                Text('precipitation'),
              ],
            ),
            Column(
              children: [Icon(CupertinoIcons.wind), Text(wind), Text('wind')],
            ),
            Column(
              children: [
                Icon(Icons.visibility_outlined),
                Text(visibility),
                Text('visibility'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
