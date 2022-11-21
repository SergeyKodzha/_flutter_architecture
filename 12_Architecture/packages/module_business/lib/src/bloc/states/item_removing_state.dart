import 'list_state.dart';

class ItemRemovingState extends ListState{
  final int id;
  const ItemRemovingState(this.id,super.currentPage, super._data);
}