import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/costants.dart';
import 'package:vmodel/src/features/print/views/print_homepage.dart';
import 'package:vmodel/src/features/refer_and_earn/views/onboarding.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

import '../../../shared/buttons/normal_back_button.dart';
import '../../suite/crop_tests/views/crop1.dart';
import '../../suite/views/splitter/view/image_grid_splitter.dart';

class CreationTools extends StatefulWidget {
  const CreationTools({super.key});
  static const routeName = 'creationTools';

  @override
  State<CreationTools> createState() => _CreationToolsState();
}

class _CreationToolsState extends State<CreationTools> {
  Widget _customMenuTile(
      BuildContext context, String icon, String title, Function() method) {
    return InkWell(
      onTap: method,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        // color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemList = [
      _customMenuTile(context, VIcons.menuPrint, 'Print...', () {
        navigateToRoute(context, const PrintHomepage());
      }),
      _customMenuTile(context, VIcons.menuPrint, 'Splitter', () {
        navigateToRoute(context, const ImageGridSplitterPage());
      }),
      _customMenuTile(context, VIcons.menuPrint, 'Crop Test', () {
        navigateToRoute(context, const CropTestPage());
      }),
    ];

    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Creation Tools",
      ),
      body: ListView.separated(
          padding: EdgeInsets.only(
            left: 18,
            right: 18,
            bottom: VConstants.bottomPaddingForBottomSheets,
          ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: itemList.length,
          itemBuilder: (context, index) => itemList[index]),
    );
  }
}
