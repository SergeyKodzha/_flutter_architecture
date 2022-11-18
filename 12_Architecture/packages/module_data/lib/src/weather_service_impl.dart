import 'dart:math';

import 'package:module_data/src/weather_service.dart';

class WeatherServiceImpl implements WeatherService{
  @override
  Future<double> getTemperature() async {
    await Future.delayed(const Duration(seconds: 2));
    return (Random().nextDouble()*30-15).toInt().toDouble();
  }

}