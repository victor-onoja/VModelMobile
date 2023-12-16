import 'package:flutter/material.dart';
import 'package:vmodel/src/features/dashboard/content/widget/search_results/search_result_item.dart';
import 'package:vmodel/src/res/colors.dart';


class PopularSearch extends StatelessWidget {
  const PopularSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular", style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 16, fontWeight: FontWeight.w600, color: VmodelColors.white),),

        Divider(color:  VmodelColors.white.withOpacity(0.15), height: 25,),

        const SearchResultItem(text: "Content"),
        const SearchResultItem(text: "Model"),
        const SearchResultItem(text: "Food"),

      ],
    );
  }
}
