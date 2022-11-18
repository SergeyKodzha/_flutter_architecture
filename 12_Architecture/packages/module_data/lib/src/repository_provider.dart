import 'package:get_it/get_it.dart';
import 'package:module_data/module_data.dart';
import 'package:module_data/src/repository_impl.dart';

class RepositoryProvider{
  static final _getIt=GetIt.I;
  T get<T extends Repository>() => _getIt.get<T>();
  static final instance=RepositoryProvider();
  void init(){
    _getIt.registerLazySingleton<Repository>(() => ReposiroryImpl());
  }
}