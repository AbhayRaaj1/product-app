import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../data/repositories/product_repository.dart';

final dioProvider =
Provider<Dio>((ref) {

  return Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com",
    ),
  );
});

final productRepositoryProvider =
Provider<ProductRepository>((ref) {

  return ProductRepository(
    ref.watch(dioProvider),
  );
});