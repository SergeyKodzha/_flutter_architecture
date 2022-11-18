import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/src/bloc_events.dart';
import 'package:module_business/src/bloc_states.dart';
import 'package:module_data/module_data.dart';

import 'item_model.dart';

class ListBloc extends Bloc<ListEvent,ListState> {
  final Repository repository;
  final List<ItemModel> _items=[];
  List<ItemModel> get __items =>List.unmodifiable(_items);
  ListBloc(this.repository):super(ListInitState()){
    on<GetItemsEvent>(_onGetItems);
    on<RemoveItemEvent>(_onRemoveItem);
  }
  Future<void> _onGetItems(GetItemsEvent event,Emitter<ListState> emitter) async {
    if (state is ListInitState){
      final resp=await repository.getData(0);
      final items=_parseItems(resp);
      _items.clear();
      _items.addAll(items);
      emitter.call(GotDataState(__items,0));
    } else {
      final resp=await repository.getData(event.page);
      final newItems=_parseItems(resp);
      _items.addAll(newItems);
      emitter.call(GotDataState(__items,event.page));
    }
  }
  Future<void> _onRemoveItem(RemoveItemEvent event,Emitter<ListState> emitter) async {
    final item=_items.firstWhere((item) => item.id==event.id);
    //item.isDeleting=true;
    final index=_items.indexOf(item);
    _items.removeAt(index);
    final newItem=item.copyWith(isDeleting:true);
    _items.insert(index, newItem);
    //_items.replaceRange(index, index,[item.copyWith(isDeleting:true)]);
    emitter.call(ItemRemovingState(event.id,state.currentPage,__items));
    final resp=await repository.deleteItem(event.id);
    _items.remove(newItem);
    final curPage=(state is GotDataState)? state.currentPage:0;
    emitter.call(ItemRemovedState(__items,state.currentPage));
  }

  List<ItemModel> _parseItems(Map<String,dynamic> data){
    final jsons=data['items'] as List<Map<String,dynamic>>;
    final List<ItemModel> items=[];
    for (Map<String,dynamic> json in jsons) {
      items.add(ItemModel.fromJson(json));
    }
    return items;
  }
}


class TemperatureBloc extends Bloc<TemperatureEvent,TemperatureState> {
  final WeatherService weatherService;
  TemperatureBloc(this.weatherService):super(TemperatureInitState()){
    on<GetTemperatureEvent>(_onGetTemperature);
  }
  void _onGetTemperature(TemperatureEvent event,Emitter<TemperatureState> emitter) async{
    print('get temperature');
    emitter.call(const RequestingTemperatureState());
    final t=await weatherService.getTemperature();
    emitter.call(GotTemperatureState(t));
    //emit(state)
    }
}