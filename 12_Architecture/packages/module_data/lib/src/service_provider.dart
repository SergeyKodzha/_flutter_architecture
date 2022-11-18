import 'package:get_it/get_it.dart';
import 'package:module_data/src/weather_service.dart';
import 'package:module_data/src/weather_service_impl.dart';

class ServiceProvider{
  static final _getIt=GetIt.I;
  T get<T extends WeatherService>() => _getIt.get<T>();
  static final instance=ServiceProvider();
  void init(){
    _getIt.registerLazySingleton<WeatherService>(() => WeatherServiceImpl());
  }
}