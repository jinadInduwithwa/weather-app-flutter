import 'package:demo/constant.dart';
import 'package:flutter/material.dart';
import 'package:demo/weather/openweather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final openweatherAPI = const OpenweatherAPI(OPEN_WEATHER_API_KEY);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: openweatherAPI.getWeatherDetails(
            lat: 33.7749,
            lon: -122.4194,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            } else {
              var data = snapshot.data;
              if (data == null) {
                return Text("No data found");
              }
              return Column(
                children: [
                  Image.network(
                    openweatherAPI.getWeatherIcon(data!['weather'][0]['icon']),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["main"]["temp"].toString(),
                        style: const TextStyle(
                          fontSize: 46,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text("`C"),
                    ],
                  ),
                  Text(data["name"]),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
