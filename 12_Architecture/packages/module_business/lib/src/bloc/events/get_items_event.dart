import 'list_event.dart';

class GetItemsEvent implements ListEvent{
  final int page;
  const GetItemsEvent(this.page):super();
}