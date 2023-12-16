import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchShimmerPage extends StatelessWidget {
  const SearchShimmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceVariant,
      highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width,
                            // padding: EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF303030),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(
                                children: [Container()],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          )),
    ));
  }
}
