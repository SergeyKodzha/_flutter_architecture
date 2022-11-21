import 'package:module_business/src/bloc/states/temperature_state.dart';

class GotTemperatureState implements TemperatureState{
  final double temperature;
  const GotTemperatureState(this.temperature):super();
}