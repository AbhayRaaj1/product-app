import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/models/product_model.dart';

final wishlistProvider =
StateNotifierProvider<WishlistNotifier, List<ProductModel>>(
      (ref) => WishlistNotifier(),
);

class WishlistNotifier extends StateNotifier<List<ProductModel>> {
  WishlistNotifier() : super([]) {
    loadWishlist();
  }

  final Box<ProductModel> box =
  Hive.box<ProductModel>('wishlistBox');

  void loadWishlist() {
    state = box.values.toList();
  }

  bool isFavorite(int productId) {
    return state.any(
          (item) => item.id == productId,
    );
  }

  void toggleWishlist(
      ProductModel product,
      ) {
    final exists = state.any(
          (item) => item.id == product.id,
    );

    if (exists) {
      final key = box.keys.firstWhere(
            (k) => box.get(k)?.id == product.id,
      );

      box.delete(key);
    } else {
      box.add(product);
    }

    loadWishlist();
  }
}