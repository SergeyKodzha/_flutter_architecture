class HotelModel {
  final String uuid;
  final String name;
  final String poster;

  HotelModel(this.uuid, this.name, this.poster);

  factory HotelModel.fromJson(Map<String, dynamic> json){
    return HotelModel(
      json['uuid'] as String,
      json['name'] as String,
      json['poster'] as String,
    );
  }
}
