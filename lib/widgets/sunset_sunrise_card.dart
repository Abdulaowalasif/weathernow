import 'package:flutter/cupertino.dart';

class SunsetSunriseCard extends StatelessWidget {
  final String sunset;
  final String sunrise;

  const SunsetSunriseCard({
    super.key,
    required this.sunset,
    required this.sunrise,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff282828).withValues(alpha: 0.2),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sunrise,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('Sunrise'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sunset,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('Sunset'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
