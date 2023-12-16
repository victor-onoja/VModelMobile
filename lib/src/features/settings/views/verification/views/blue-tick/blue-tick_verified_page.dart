import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

import '../../../../../../core/utils/shared.dart';
import '../../../../../../res/gap.dart';
import '../../../../../../shared/appbar/appbar.dart';

class BlueTickVerifiedPage extends StatelessWidget {
  const BlueTickVerifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(
            onTap: () {
              navigateAndRemoveUntilRoute(context, const DashBoardView());
            },
          ),
          appbarTitle: "",
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                addVerticalSpacing(MediaQuery.of(context).size.height * 0.15),
                Text('Cool Stuff!\nYou\nare\nnow\nVerified!!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        height: 1.8,
                        fontWeight: FontWeight.bold)),
                addVerticalSpacing(35),
                const RenderSvgWithoutColor(svgPath: VIcons.verifiedIcon),
                addVerticalSpacing(55),
                // SizedBox(
                //   width: 150,
                //   child: ReferAndEarnActionButton(
                //       onPressed: () {
                //         pageIndex.value = 1;
                //       },
                //       title: 'Continue'),
                // ),
              ],
            )),
          ),
        ));
  }
}
