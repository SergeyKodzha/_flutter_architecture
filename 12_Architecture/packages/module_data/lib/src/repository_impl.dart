import 'package:module_data/src/repository.dart';

class ReposiroryImpl implements Repository{
  static const int itemsPerPage=20;
  @override
  Future<bool> deleteItem(int page) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<Map<String, List<Map<String,dynamic>>>> getData(int page) async {
    await Future.delayed(const Duration(seconds: 2));
    Map<String, List<Map<String,dynamic>>> res={};
    res['items']=[];
    for (int i=0;i<itemsPerPage;i++){
      final item={'id':(page*itemsPerPage)+i,'image':'assets/images/${i%5}.jpg','text':'item ${(page*itemsPerPage)+i}'};
      res['items']?.add(item);
    }
    return res;
  }
}