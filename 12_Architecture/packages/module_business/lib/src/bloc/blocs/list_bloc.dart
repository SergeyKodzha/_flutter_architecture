import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/src/bloc/events/get_items_event.dart';
import 'package:module_business/src/bloc/events/remove_item_event.dart';
import 'package:module_business/src/model/item_model.dart';

import 'package:module_data/module_data.dart';


import '../events/list_event.dart';

import '../states/got_data_state.dart';

import '../states/item_removed_state.dart';
import '../states/item_removing_state.dart';
import '../states/list_init_state.dart';
import '../states/list_state.dart';

class ListBloc extends Bloc<ListEvent,ListState> {
  final Repository repository;
  ListBloc(this.repository):super(ListInitState()){
    on<GetItemsEvent>(_onGetItems);
    on<RemoveItemEvent>(_onRemoveItem);
  }
  Future<void> _onGetItems(GetItemsEvent event,Emitter<ListState> emitter) async {
    if (state is ListInitState){
      await repository.getData(0);
      emitter.call(const GotDataState(0,[]));
    } else {
      final resp=await repository.getData(event.page);
      final newItems=_parseItems(resp);
      final newList=state.data.toList()..addAll(newItems);
      emitter.call(GotDataState(event.page,newList));
    }
  }
  Future<void> _onRemoveItem(RemoveItemEvent event,Emitter<ListState> emitter) async {
    final items=state.data.toList();
    final item=items.firstWhere((item) => item.id==event.id);
    final index=items.indexOf(item);
    items.removeAt(index);
    final newItem=item.copyWith(isDeleting:true);
    items.insert(index, newItem);
    emitter.call(ItemRemovingState(event.id,state.currentPage,items));
    final resp=await repository.deleteItem(event.id);
    items.remove(newItem);
    final curPage=(state is GotDataState)? state.currentPage:0;
    emitter.call(ItemRemovedState(state.currentPage,items));
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