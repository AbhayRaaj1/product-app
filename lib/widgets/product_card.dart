import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  final String title;
  final String image;
  final double price;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(

        onTap: onTap,

        leading: Image.network(image),

        title: Text(title),

        subtitle: Text(
          "₹$price",
        ),
      ),
    );
  }
}