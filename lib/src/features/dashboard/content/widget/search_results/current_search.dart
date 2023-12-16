import 'package:flutter/material.dart';
import 'package:vmodel/src/features/dashboard/content/widget/search_results/search_result_item.dart';


class CurrentSearch extends StatelessWidget {
  const CurrentSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchResultItem(text: "Content1"),
        SearchResultItem(text: "Content2"),
        SearchResultItem(text: "Content3"),

      ],
    );
  }
}
