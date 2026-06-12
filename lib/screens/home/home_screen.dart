import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/category_provider.dart';
import '../../providers/price_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/search_provider.dart';
import '../details/product_detail_screen.dart';
import '../wishlist/wishlist_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const WishlistScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search Products...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
                onChanged: (value) {
                  ref
                      .read(
                    searchQueryProvider
                        .notifier,
                  )
                      .state = value;
                },
              ),
            ),
          ),

          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 10),
                _categoryChip(ref, "beauty"),
                _categoryChip(ref, "fragrances"),
                _categoryChip(ref, "furniture"),
                _categoryChip(ref, "groceries"),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${ref.watch(priceRangeProvider).start.toInt()}",
                    ),
                    Text(
                      "₹${ref.watch(priceRangeProvider).end.toInt()}",
                    ),
                  ],
                ),
                RangeSlider(
                  values: ref.watch(priceRangeProvider),
                  min: 0,
                  max: 5000,
                  divisions: 100,
                  onChanged: (value) {
                    ref
                        .read(priceRangeProvider.notifier)
                        .state = value;
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: products.when(
              data: (items) {

                final query =
                ref.watch(
                  searchQueryProvider,
                );

                final selectedCategory =
                ref.watch(selectedCategoryProvider);

                final range =
                ref.watch(priceRangeProvider);

                final filteredProducts =
                items.where((product) {

                  final matchesSearch =
                  product.title
                      .toLowerCase()
                      .contains(
                    query.toLowerCase(),
                  );

                  final matchesCategory =
                      selectedCategory == null ||
                          product.category ==
                              selectedCategory;

                  final matchesPrice =
                      product.price >= range.start &&
                          product.price <= range.end;

                  return matchesSearch &&
                      matchesCategory &&
                      matchesPrice;

                }).toList();

                if (filteredProducts.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "No Product Found",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding:
                  const EdgeInsets.all(12),

                  itemCount:
                  filteredProducts.length,

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),

                  itemBuilder: (_, index) {

                    final product =
                    filteredProducts[index];

                    return InkWell(
                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),

                      onTap: () {

                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(
                                  product: product,
                                ),
                          ),
                        );
                      },

                      child: Card(
                        elevation: 4,

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                          children: [

                            Expanded(
                              flex: 5,
                              child: Stack(
                                children: [

                                  Hero(
                                    tag: "product_${product.id}",
                                    child:
                                    ClipRRect(
                                      borderRadius:
                                      const BorderRadius.vertical(
                                        top:
                                        Radius.circular(
                                          20,
                                        ),
                                      ),
                                      child:
                                      CachedNetworkImage(
                                        imageUrl:
                                        product
                                            .thumbnail,

                                        width:
                                        double.infinity,

                                        fit: BoxFit
                                            .cover,

                                        placeholder:
                                            (
                                            _,
                                            __,
                                            ) =>
                                        const Center(
                                          child:
                                          CircularProgressIndicator(),
                                        ),

                                        errorWidget:
                                            (
                                            _,
                                            __,
                                            ___,
                                            ) =>
                                        const Icon(
                                          Icons
                                              .image_not_supported,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child:
                                    Container(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        horizontal:
                                        8,
                                        vertical:
                                        4,
                                      ),
                                      decoration:
                                      BoxDecoration(
                                        color: Colors
                                            .amber,
                                        borderRadius:
                                        BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons
                                                .star,
                                            size:
                                            14,
                                          ),
                                          Text(
                                            product
                                                .rating
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(
                                  10,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                                  children: [

                                    Text(
                                      product
                                          .title,

                                      maxLines: 2,

                                      overflow:
                                      TextOverflow
                                          .ellipsis,

                                      style:
                                      const TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        fontSize:
                                        15,
                                      ),
                                    ),

                                    const Spacer(),

                                    Text(
                                      "₹${product.price}",

                                      style:
                                      const TextStyle(
                                        color:
                                        Colors.green,
                                        fontSize:
                                        18,
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },

              loading: () =>
              const Center(
                child:
                CircularProgressIndicator(),
              ),

              error: (e, _) =>
                  Center(
                    child: Text(
                      e.toString(),
                    ),
                  ),
            ),
          ),

        ],

      ),
    );
  }
  Widget _categoryChip(
      WidgetRef ref,
      String category,
      ) {
    final selected =
    ref.watch(selectedCategoryProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: ChoiceChip(
        label: Text(category),

        selected: selected == category,

        onSelected: (_) {
          ref
              .read(
            selectedCategoryProvider.notifier,
          )
              .state = selected == category
              ? null
              : category;
        },
      ),
    );
  }
}