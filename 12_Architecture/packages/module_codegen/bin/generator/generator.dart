import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';

import 'model.dart';

class Generator{
  static const String _Url='https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301';
  final String _kOutput='hotels.generated.dart';
  void generate() async{
    final resp= await _fetchHotels();
    final hotels = List<HotelModel>.from(
        resp.data.map((item) => HotelModel.fromJson(item)));
    //print(hotels);

    final output=StringBuffer();
    output.writeln('class Hotels {\n\tstatic const List<Map<String,dynamic>> list = [');
    for (var hotel in hotels) {
      _writeHotel(hotel, output,'\t\t');
    }
      output.writeln('\t];\n}');
    final formatted=DartFormatter().format(output.toString());
    final file=File(path.join(Directory.current.path,'bin/generator/$_kOutput'));
    file.writeAsStringSync(formatted);
    //print(output);
  }

  void _writeHotel(HotelModel hotel,StringBuffer buffer,String prefix){
    //hotel.
    buffer.writeln('$prefix{');
    buffer.writeln('$prefix\t\'uuid\':\'${hotel.uuid}\',');
    buffer.writeln('$prefix\t\'name\':\'${hotel.name}\',');
    buffer.writeln('$prefix\t\'poster\':\'${hotel.poster}\',');
    buffer.writeln('$prefix},');
  }
  Future<Response> _fetchHotels() {
    final resp = Dio()
        .get("https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301");
    return resp;
  }
}