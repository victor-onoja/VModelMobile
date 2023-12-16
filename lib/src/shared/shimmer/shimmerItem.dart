import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerItem({
  bool useGrid = false,
  int numOfItem = 5,
  required  BuildContext context,
}) {
  return useGrid
      ? SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int x = 0; x < numOfItem; ++x) ...[
                Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.surfaceVariant,
              highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  child: Container(
                    color: Colors.white,
                    height: 150,
                    width: 150,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ],
          ),
        )
      : SingleChildScrollView(
          child: Column(
            children: [
              for (int x = 0; x < numOfItem; ++x) ...[
                Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.surfaceVariant,
              highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  child: ListTile(
                    title: Container(
                      width: double.infinity,
                      height: 20,
                      color: Colors.white,
                    ),
                    subtitle: Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: 40,
                      height: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ]
            ],
          ),
        );
}
