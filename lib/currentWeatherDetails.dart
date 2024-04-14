import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentWeatherDetails extends StatelessWidget {
  final dailyDetails;
  final descDetail;
  final icon;
  final Color color;
  const CurrentWeatherDetails(
      {Key? key,
      this.dailyDetails,
      this.descDetail,
      this.icon,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // Icon(icon, color: Colors.white),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FaIcon(icon, color: color),
          ),
          Text(dailyDetails, style: TextStyle(color: color)),
          Text(descDetail, style: TextStyle(color: color))
        ],
      ),
    );
  }
}
