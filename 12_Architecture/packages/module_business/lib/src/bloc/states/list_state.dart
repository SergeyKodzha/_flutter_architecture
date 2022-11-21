import 'package:module_business/src/model/item_model.dart';

class ListState{
  final int currentPage;
  final List<ItemModel> _data;
  List<ItemModel> get data => List.unmodifiable(_data);
  const ListState(this.currentPage,this._data);
}
