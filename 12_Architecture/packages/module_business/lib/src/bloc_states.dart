import 'package:module_business/src/item_model.dart';

class ListState{
  final int currentPage;
  final List<ItemModel> _data;
  List<ItemModel> get data => List.unmodifiable(_data);
  const ListState(this.currentPage,this._data);
}

class ListInitState extends ListState{
  ListInitState():super(0,[]);
}

class LoadingState extends ListState{
  const LoadingState(super.currentPage,super._data);
}

class GotDataState extends ListState{
  const GotDataState(super.currentPage,super._data);
}

class ItemRemovingState extends ListState{
  final int id;
  const ItemRemovingState(this.id,super.currentPage, super._data);
}

class ItemRemovedState extends ListState{
  const ItemRemovedState(super.currentPage,super._data);
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