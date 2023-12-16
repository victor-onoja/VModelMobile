import 'package:flutter/material.dart';
import 'package:vmodel/src/res/colors.dart';


class NoSearchResultFound extends StatelessWidget {
  const NoSearchResultFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("No matches found", style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 16, fontWeight: FontWeight.w600, color: VmodelColors.white
          ),),
         Text("No matches found", style: Theme.of(context).textTheme.displayMedium?.copyWith(
             fontSize: 12, fontWeight: FontWeight.w500, color: VmodelColors.white
         ),)

        ],
      ),
    );
  }
}
