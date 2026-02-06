import 'package:carryup/models/cartProducts.dart';
import 'package:json_annotation/json_annotation.dart';

part 'carts.g.dart';

@JsonSerializable()
class Carts {
  int? id;
  List<CartProducts>? products;
  double? total;
  double? discountedTotal;
  int? userId;
  int? totalProducts;
  int? totalQuantity;

  Carts(
      {this.id,
      this.products,
      this.total,
      this.discountedTotal,
      this.userId,
      this.totalProducts,
      this.totalQuantity});

      factory Carts.fromJson(Map<String, dynamic> json) =>
      _$CartsFromJson(json);

  Map<String, dynamic> toJson() => _$CartsToJson(this);
}
