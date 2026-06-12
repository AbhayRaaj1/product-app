import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmer
    extends StatelessWidget {

  const ProductShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ListView.builder(

      itemCount: 10,

      itemBuilder: (_, index) {

        return Shimmer.fromColors(

          baseColor:
          Colors.grey.shade300,

          highlightColor:
          Colors.grey.shade100,

          child: ListTile(

            leading: Container(
              width: 60,
              height: 60,
              color: Colors.white,
            ),

            title: Container(
              height: 15,
              color: Colors.white,
            ),

            subtitle: Container(
              height: 10,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}