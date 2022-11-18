import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';

@freezed
class ItemModel with _$ItemModel {
  //final int id;
  //final String image;
  //final String text;
  const factory ItemModel(int id,String text,String image,bool isDeleting)=_ItemModel;
  static ItemModel fromJson(Map<String,dynamic> json){
    return ItemModel(json['id'], json['text'],json['image'], false);
  }
}
