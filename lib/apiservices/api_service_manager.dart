import 'package:carryup/models/carts.dart';
import 'package:carryup/models/product_response.dart';
import 'package:dio/dio.dart';

ApiServiceManager apiServiceManager = ApiServiceManager();

class ApiServiceManager {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://dummyjson.com/products',
    connectTimeout: const Duration(seconds: 5000),
    receiveTimeout: const Duration(seconds: 5000),
  ));
  static final ApiServiceManager _apiServiceManager =
      ApiServiceManager._singleton();

  ApiServiceManager._singleton();

  factory ApiServiceManager() {
    return _apiServiceManager;
  }

  T? exceptionHandling<T>(
      Response? errorResponse, T Function(Map<String, dynamic>) fromJson) {
    T? response;
    try {
      return errorResponse != null ? fromJson(errorResponse.data) : response;
    } catch (e) {
      return response;
    }
  }

  Future<Productresponse?> getProducts() async {
    Productresponse? products;
    try {
      Response response = await dio.get('https://dummyjson.com/products');
      products = Productresponse.fromJson(response.data);
    } on DioException catch (e) {
      return exceptionHandling(
          e.response, (data) => Productresponse.fromJson(data));
    } catch (e) {
      return products;
    }
    return products;
  }

  Future<Productresponse?> getProductsbyCategory(String category) async {
    Productresponse? products;
    try {
      Response response = await dio
          .get('https://dummyjson.com/products/category/$category?limit=100');
      products = Productresponse.fromJson(response.data);
    } on DioException catch (e) {
      return exceptionHandling(
          e.response, (data) => Productresponse.fromJson(data));
    } catch (e) {
      return products;
    }
    return products;
  }

  Future<Carts?> getCarts() async {
    Carts? carts;
    try {
      Response response = await dio.get('https://dummyjson.com/carts/1');
      carts = Carts.fromJson(response.data);
    } on DioException catch (e) {
      return exceptionHandling(e.response, (data) => Carts.fromJson(data));
    } catch (e) {
      return carts;
    }
    return carts;
  }
}
