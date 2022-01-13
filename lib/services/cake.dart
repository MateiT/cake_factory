import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

enum Dimension{
  small, medium, large, weddingSized
}
enum Shape{
  round, rectangular
}

class Cake {

  int id;
  String name;
  String cream;
  String sponge;
  String topping;
  Dimension dimension;
  Shape shape;

  Cake({this.id = 0, this.name = '', this.cream = '', this.sponge = '', this.topping = '',
    this.dimension = Dimension.small, this.shape = Shape.round});

  Cake.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      name = res['name'].toString(),
      cream = res['cream'].toString(),
      sponge = res['sponge'].toString(),
      topping = res['topping'].toString(),
      dimension = Dimension.values.firstWhere((el) => el.toString() == res['dimension']),
      shape = Shape.values.firstWhere((el) => el.toString() == res['shape']);

  Map<String, Object?> toMap() {
    return {'id':id,'name': name, 'cream': cream, 'sponge': sponge, 'topping': topping, 'dimension': dimension.toString(), 'shape': shape.toString()};
  }
}