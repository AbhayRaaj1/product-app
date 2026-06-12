import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../providers/wishlist_provider.dart';
import '../../data/models/product_model.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final wishlist = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wishlist"),
        centerTitle: true,
      ),

      body: wishlist.isEmpty
          ? const Center(
        child: Text(
          "No items in wishlist 💔",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: wishlist.length,
        itemBuilder: (context, index) {

          final ProductModel product = wishlist[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(

              leading: Hero(
                tag: "product_${product.id}",
                child: CachedNetworkImage(
                  imageUrl: product.thumbnail,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),

              title: Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              subtitle: Text(
                "₹${product.price}",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),

                onPressed: () {
                  ref
                      .read(wishlistProvider.notifier)
                      .toggleWishlist(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Removed from Wishlist"),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}