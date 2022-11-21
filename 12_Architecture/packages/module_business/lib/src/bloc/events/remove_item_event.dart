import 'package:module_business/src/bloc/events/list_event.dart';

class RemoveItemEvent implements ListEvent{
  final int id;
  const RemoveItemEvent(this.id):super();
}