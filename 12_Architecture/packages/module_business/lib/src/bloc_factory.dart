import 'package:get_it/get_it.dart';
import 'package:module_data/module_data.dart';
import 'blocs.dart';

class BlocFactory{
  static final _getIt=GetIt.I;
   T get<T extends Object>() => _getIt.get<T>();
   static final instance=BlocFactory();

   void init(){
     RepositoryProvider.instance.init();
     final repository=RepositoryProvider.instance.get<Repository>();
     _getIt.registerFactory<ListBloc>(() => ListBloc(repository));
     //
     ServiceProvider.instance.init();
     final weatherService=ServiceProvider.instance.get<WeatherService>();
     _getIt.registerFactory<TemperatureBloc>(() =>TemperatureBloc(weatherService));
   }
}