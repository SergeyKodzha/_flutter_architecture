abstract class ListEvent {
  const ListEvent();
}
class GetItemsEvent implements ListEvent{
  final int page;
  const GetItemsEvent(this.page):super();
}

class RemoveItemEvent implements ListEvent{
  final int id;
  const RemoveItemEvent(this.id):super();
}
//
abstract class TemperatureEvent {
  const TemperatureEvent();
}

class GetTemperatureEvent implements TemperatureEvent {}