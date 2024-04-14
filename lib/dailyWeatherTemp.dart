import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';

class DailyTemp extends StatefulWidget {
  final double temp;
  final String timeOfDay;
  const DailyTemp({
    super.key,
    required this.temp,
    required this.timeOfDay,
  });

  @override
  State<DailyTemp> createState() => _DailyTempState();
}

class _DailyTempState extends State<DailyTemp> {
  late IconData iconData;
  late bool isload;

  @override
  void initState() {
    isload = true;
    // TODO: implement initState
    setIcon();
    super.initState();
  }

  void setIcon() {
    // print(widget.temp);
    if (widget.temp < 0) {
      setState(() {
        iconData = FontAwesomeIcons.snowflake;
        isload = false;
      });
    } else if (widget.temp >= 0 && widget.temp < 15) {
      setState(() {
        iconData = FontAwesomeIcons.temperatureArrowDown;
        isload = false;
      });
    } else if (widget.temp >= 15 && widget.temp <= 25) {
      setState(() {
        iconData = FontAwesomeIcons.temperatureQuarter;
        isload = false;
      });
    } else if (widget.temp > 25 && widget.temp < 40) {
      setState(() {
        iconData = FontAwesomeIcons.sun;
        isload = false;
      });
    } else {
      iconData = FontAwesomeIcons.temperatureArrowUp;
      isload = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // double tempData = double.parse(temp);
    return Container(
      margin: EdgeInsets.all(5),
      // width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${widget.temp.toString()}\u00B0'),
          ),
          isload ? const CircularProgressIndicator() : FaIcon(iconData),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.timeOfDay,
              style: TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
