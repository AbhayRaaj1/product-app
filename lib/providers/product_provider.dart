import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/product_model.dart';
import 'repository_provider.dart';

final productProvider =
FutureProvider<List<ProductModel>>(
        (ref) async {

      return ref
          .watch(productRepositoryProvider)
          .getProducts();
    });