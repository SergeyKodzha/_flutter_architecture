abstract class Repository {
  Future<Map<String,dynamic>> getData(int page);
  Future<bool> deleteItem(int page);
}