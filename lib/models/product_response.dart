import 'package:carryup/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class Productresponse {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  Productresponse({this.products, this.total, this.skip, this.limit});

  factory Productresponse.fromJson(Map<String, dynamic> json) =>
      _$ProductresponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductresponseToJson(this);
}
