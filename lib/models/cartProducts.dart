import 'package:json_annotation/json_annotation.dart';

part 'cartProducts.g.dart';

@JsonSerializable()
class CartProducts {
  int? id;
  String? title;
  double? price;
  int? quantity;
  double? total;
  double? discountPercentage;
  double? discountedTotal;
  String? thumbnail;

  CartProducts(
      {this.id,
      this.title,
      this.price,
      this.quantity,
      this.total,
      this.discountPercentage,
      this.discountedTotal,
      this.thumbnail});

  factory CartProducts.fromJson(Map<String, dynamic> json) =>
      _$CartProductsFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductsToJson(this);
}
