import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/models/product_model.dart';
import '../../providers/wishlist_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final wishlist = ref.watch(wishlistProvider);

    // ✅ FIX: object-based check (id nahi contains direct object)
    final isFavorite = wishlist.any(
          (item) => item.id == product.id,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            elevation: 0,

            actions: [

              IconButton(
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),

                onPressed: () {

                  ref
                      .read(wishlistProvider.notifier)
                      .toggleWishlist(product); // ✅ FIXED METHOD NAME

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? "Removed from Wishlist"
                            : "Added to Wishlist",
                      ),
                    ),
                  );
                },
              ),

              IconButton(
                icon: const Icon(Icons.share),

                onPressed: () {
                  SharePlus.instance.share(
                    ShareParams(
                      text: '''
${product.title}

Price: ₹${product.price}

${product.description}
''',
                    ),
                  );
                },
              ),
            ],

            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "product_${product.id}",

                child: CachedNetworkImage(
                  imageUrl: product.thumbnail,
                  fit: BoxFit.cover,

                  placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),

                  errorWidget: (_, __, ___) =>
                  const Icon(Icons.error, size: 50),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 18),
                            const SizedBox(width: 4),
                            Text(product.rating.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "₹${product.price}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product.description,
                    style: const TextStyle(
                      height: 1.7,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text("Buy Now"),

                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Buy Feature Coming Soon"),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}