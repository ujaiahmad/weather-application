import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_application/currentWeatherDetails.dart';
import 'package:weather_application/customBottomBar.dart';
import 'package:weather_application/fetchLocation.dart';
import 'package:weather_application/weatherModel.dart';
import 'package:intl/intl.dart';
import 'dailyWeatherTemp.dart';
import 'fetchWeather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'SF Compact'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Weather> futureWeather;
  late Future<Position> futurePosition;
  late GeoData data;
  late bool isLoad;
  late Color backgroundColor;

  @override
  void initState() {
    // TODO: implement initState
    isLoad = true;
    futurePosition = determinePosition();
    futurePosition.then((value) {
      futureWeather = fetchWeather(value.latitude, value.longitude);
      print('this is a futureweahter : $futureWeather');
      futureWeather.then(
        (value1) {
          getColor(value1.weatherMain, value.latitude, value.longitude);
        },
      );
      // getAddress(value.latitude, value.longitude);
      print('Future weather has been fetched');
    });
    // print(DateFormat.yMd().format(DateTime.now()));
    // print(DateFormat.EEEE().format(DateTime.now()));
    // print(DateFormat('EEEE, dd MMMM yyyy')
    //     .format(DateTime.now())); //output Saturday, 10 February
    super.initState();
  }

  void getColor(String weather, double lat, double long) {
    if (weather == 'Clouds') {
      backgroundColor = Colors.grey.shade100;
      getAddress(lat, long);
    } else if (weather == 'Clear') {
      backgroundColor = Colors.blue.shade300;
      getAddress(lat, long);
    } else if (weather == 'Snow') {
      backgroundColor = Colors.white;
      getAddress(lat, long);
    } else if (weather == 'Drizzle') {
      backgroundColor == Colors.blue.shade500;
      getAddress(lat, long);
    } else if (weather == 'Thunderstorm') {
      backgroundColor == Colors.blue.shade900;
      getAddress(lat, long);
    } else if (weather == 'Rain') {
      backgroundColor == Colors.blue.shade700;
      getAddress(lat, long);
    } else {
      backgroundColor = Color(0xFFC2B280);
      getAddress(lat, long);
    }
  }

  void getAddress(lat, long) async {
    print('Print data is being called...');
    data = await Geocoder2.getDataFromCoordinates(
        latitude: lat,
        longitude: long,
        googleMapApiKey: "AIzaSyBEWJ1EqamogCl5-oXx3qdYyzYzAd2MPNE");
    // print(data.country);
    if (data.country.isNotEmpty) {
      setState(() {
        isLoad = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLoad ? Colors.white : backgroundColor,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title:
      //       // isLoad
      //       //     ? Text(
      //       //         'Loading Location...',
      //       //         style: TextStyle(color: Colors.black),
      //       //       )
      //       //     :
      //       Text(
      //     "data.country",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: isLoad
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<Weather>(
              future: futureWeather,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          data.state,
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                DateFormat('EEEE, dd MMMM yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(color: backgroundColor)),
                          ),
                        ),
                        Text(
                          snapshot.data!.weatherMain,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        // Text(snapshot.data!.description),
                        Text('${snapshot.data!.temp.toString()}\u00B0',
                            style: TextStyle(
                                fontSize: 105, fontWeight: FontWeight.bold)),
                        Text(
                          'Daily Summary',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(snapshot.data!.summary),
                        // 3 summary
                        Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CurrentWeatherDetails(
                                  dailyDetails:
                                      '${snapshot.data!.windSpeed.toString()} m/s',
                                  descDetail: 'Wind',
                                  icon: FontAwesomeIcons.wind,
                                  color: backgroundColor),
                              CurrentWeatherDetails(
                                  dailyDetails:
                                      '${snapshot.data!.humidity.toString()}%',
                                  descDetail: 'Humidity',
                                  icon: FontAwesomeIcons.droplet,
                                  color: backgroundColor),
                              CurrentWeatherDetails(
                                  dailyDetails:
                                      '${snapshot.data!.visibility.toString()} m',
                                  descDetail: 'Visibility',
                                  icon: FontAwesomeIcons.eye,
                                  color: backgroundColor),
                            ],
                          ),
                        ),
                        Text(
                          'Daily Forecast',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: DailyTemp(
                                    temp: snapshot.data!.morningTemp,
                                    timeOfDay: 'Morning'),
                              ),
                              Expanded(
                                child: DailyTemp(
                                    temp: snapshot.data!.dayTemp,
                                    timeOfDay: 'Day'),
                              ),
                              Expanded(
                                child: DailyTemp(
                                    temp: snapshot.data!.eveTemp,
                                    timeOfDay: 'Evening'),
                              ),
                              Expanded(
                                child: DailyTemp(
                                    temp: snapshot.data!.nightTemp,
                                    timeOfDay: 'Night'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 13)
                        //  Text(futureWeather.whenComplete(() => null))
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
      bottomNavigationBar:
          CustomBottomBar(color: isLoad ? Colors.white : backgroundColor),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.search,
            size: 30,
          ),
          onPressed: () {
            // double bmi = 0;
            // setState(() {
            //   // double getHeight = calculateBMI.displayHeight();
            //   // print(getHeight);
            //   // double getWeight = calculateBMI.displayWeight();
            //   // print(getWeight);
            //   bmi = calculateBMI.getBMI();
            //   // double fromCalculateClass = calculateBMI.displayHeight();
            //   // print('Height from main is $fromCalculateClass');
            //   print('bmi is $bmi');
            // });
            // showModalBottomSheet(
            //     context: context,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.vertical(
            //         top: Radius.circular(20),
            //       ),
            //     ),
            //     clipBehavior: Clip.antiAliasWithSaveLayer,
            //     builder: (context) => BottomPopUp());
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
