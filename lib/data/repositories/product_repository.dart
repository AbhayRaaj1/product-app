import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductRepository {

  final Dio dio;

  ProductRepository(this.dio);

  Future<List<ProductModel>> getProducts({
    int limit = 20,
    int skip = 0,
  }) async {

    final response = await dio.get(
      '/products',
      queryParameters: {
        'limit': limit,
        'skip': skip,
      },
    );

    final List data =
    response.data['products'];

    return data
        .map(
          (e) =>
          ProductModel.fromJson(e),
    )
        .toList();
  }
}