import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

import '../buttons/normal_back_button.dart';

class CustomErrorDialogWithScaffold extends StatelessWidget {
  final Function() onTryAgain;
  final String title;
  final bool showAppbar;

  const CustomErrorDialogWithScaffold({
    super.key,
    required this.onTryAgain,
    required this.title,
    this.showAppbar = true,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
      appBar: showAppbar
          ? VWidgetsAppBar(
              appbarTitle: title,
              leadingIcon: const VWidgetsBackButton(),
            )
          : null,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: SizerUtil.height * 0.3,
          width: SizerUtil.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).scaffoldBackgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              addVerticalSpacing(15),
              RenderSvg(
                svgPath: VIcons.retry,
                svgHeight: 40,
                svgWidth: 40,
              ),
              addVerticalSpacing(15),
              Text(
                'An error occured',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              addVerticalSpacing(20),
              VWidgetsPrimaryButton(
                butttonWidth: MediaQuery.of(context).size.width / 1.8,
                onPressed: onTryAgain,
                enableButton: true,
                buttonTitle: "Try again",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialogWithoutScaffold extends StatelessWidget {
  final Function() onTryAgain;

  const CustomDialogWithoutScaffold({
    super.key,
    required this.onTryAgain,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: SizerUtil.height * 0.3,
        width: SizerUtil.width * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            addVerticalSpacing(15),
            RenderSvg(
              svgPath: VIcons.retry,
              svgHeight: 40,
              svgWidth: 40,
            ),
            addVerticalSpacing(15),
            Text(
              'An error occured',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            addVerticalSpacing(20),
            VWidgetsPrimaryButton(
              butttonWidth: MediaQuery.of(context).size.width / 1.8,
              onPressed: onTryAgain,
              enableButton: true,
              buttonTitle: "Try again",
            )
          ],
        ),
      ),
    );
  }
}
