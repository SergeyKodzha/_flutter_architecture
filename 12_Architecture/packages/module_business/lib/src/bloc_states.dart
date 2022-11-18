import 'package:module_business/src/item_model.dart';

class ListState{
  final int currentPage;
  const ListState(this.currentPage);
}

class ListInitState extends ListState{
  ListInitState():super(0);
}

class LoadingState extends ListState{
  final List<ItemModel> _data;

  const LoadingState(this._data,super.currentPage);
  List<ItemModel> get data => List.unmodifiable(_data);
}

class GotDataState extends ListState{
  final List<ItemModel> _data;
  const GotDataState(this._data, super.currentPage);
  List<ItemModel> get data => List.unmodifiable(_data);
}

class ItemRemovingState extends ListState{
  final int id;
  final List<ItemModel> _data;
  const ItemRemovingState(this.id,super.currentPage, this._data);
  List<ItemModel> get data => List.unmodifiable(_data);
}

class ItemRemovedState extends ListState{
  final List<ItemModel> _data;
  const ItemRemovedState(this._data, super.currentPage);
  List<ItemModel> get data => List.unmodifiable(_data);
}

//temperature states
abstract class TemperatureState{
  const TemperatureState();
}
class TemperatureInitState implements TemperatureState{
}

class RequestingTemperatureState implements TemperatureState{
  const RequestingTemperatureState():super();
}

class GotTemperatureState implements TemperatureState{
  final double temperature;
  const GotTemperatureState(this.temperature):super();
}