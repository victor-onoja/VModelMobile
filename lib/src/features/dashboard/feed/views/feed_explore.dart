import 'package:flutter/material.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/dashboard/feed/data/field_mock_data.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';

class FeedExplore extends StatefulWidget {
  final bool issearching;


   const FeedExplore({Key? key,required this.issearching}) : super(key: key);

  @override
  State<FeedExplore> createState() => _FeedExploreState();
}

class _FeedExploreState extends State<FeedExplore> {
  String selectedChip = "Model";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        //   child: VWidgetsPrimaryTextFieldWithTitle(
        //     label: "",
        //     hintText: "Vicki",
        //     suffixIcon: const Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: RenderSvgWithoutColor(
        //         svgPath: VIcons.searchNormal,
        //         svgHeight: 10,
        //         svgWidth: 22,
        //       ),
        //     ),
        //     onTap: () {
        //       navigateToRoute(context, const FeedExploreSearchView());
        //     },
        //   ),
        // ),
        // SizedBox(
        //   height: 56,
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     padding: const EdgeInsets.symmetric(horizontal: 14),
        //     scrollDirection: Axis.horizontal,
        //     itemCount: categories.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return CategoryButton(
        //         isSelected: selectedChip == categories[index],
        //         text: categories[index],
        //         onPressed: () =>
        //             setState(() => selectedChip = categories[index]),
        //       );
        //     },
        //   ),
        // ),
        widget.issearching != false
            ? Column(
              children:[ Padding(
          padding: const VWidgetsPagePadding
                .horizontalSymmetric(18),
          child: VWidgetsPrimaryTextFieldWithTitle(
              hintText: "search ",
              onChanged: (val) {},
              //!Switching photo functionality with map search till photo search is ready
          ),
        ),
                addVerticalSpacing(5)
            ])
            : Container(),
        addVerticalSpacing(1),

        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.4,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                crossAxisCount: 2),
            // itemCount: imagesListTwo.length,
            itemBuilder: (BuildContext ctx, index) {
              return Image.asset(
                index < imagesList.length ? imagesList[index] : imagesList[0],
                width: 80.0,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ],
    );
  }
}
