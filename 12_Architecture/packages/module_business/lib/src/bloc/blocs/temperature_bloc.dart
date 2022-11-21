import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/src/bloc/events/get_temperature_event.dart';
import 'package:module_business/src/bloc/states/temperature_init_state.dart';

import 'package:module_data/module_data.dart';


import '../events/temperature_event.dart';
import '../states/got_temperature_state.dart';
import '../states/requesting_temperature_state.dart';
import '../states/temperature_state.dart';



class TemperatureBloc extends Bloc<TemperatureEvent,TemperatureState> {
  final WeatherService weatherService;
  TemperatureBloc(this.weatherService):super(TemperatureInitState()){
    on<GetTemperatureEvent>(_onGetTemperature);
  }
  void _onGetTemperature(TemperatureEvent event,Emitter<TemperatureState> emitter) async{
    emitter.call(const RequestingTemperatureState());
    final t=await weatherService.getTemperature();
    emitter.call(GotTemperatureState(t));
  }
}