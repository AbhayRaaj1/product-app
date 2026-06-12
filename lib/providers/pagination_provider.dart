import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/product_model.dart';
import 'repository_provider.dart';

class ProductNotifier
    extends StateNotifier<List<ProductModel>> {

  ProductNotifier(this.ref)
      : super([]);

  final Ref ref;

  int skip = 0;
  bool loading = false;

  Future<void> loadMore() async {

    if (loading) return;

    loading = true;

    final data =
    await ref
        .read(
      productRepositoryProvider,
    )
        .getProducts(
      skip: skip,
    );

    state = [...state, ...data];

    skip += 20;

    loading = false;
  }
}

final paginationProvider =
StateNotifierProvider<
    ProductNotifier,
    List<ProductModel>>((ref) {

  return ProductNotifier(ref);
});