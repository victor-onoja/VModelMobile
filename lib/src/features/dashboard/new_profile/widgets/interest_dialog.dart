import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../../../../res/res.dart';
import '../../../../vmodel.dart';

class InterestSelectionDialog extends ConsumerStatefulWidget {
  const InterestSelectionDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectInterestState();
}

class _SelectInterestState extends ConsumerState<InterestSelectionDialog> {
  final interests = [
    "Art",
    "Coupons",
    "Photography",
    "Music",
    "Fashion",
    "Makeup",
    "Modeling",
    "Dance",
    "Acting",
    "Videography",
    "Graphic Design",
    "Illustration",
    "Writing",
    "Fitness",
    "Yoga",
    "Cooking",
    "Travel",
    "Crafts",
    "Beauty & Wellness",
    "Sports",
    "Health",
    "Education",
    "DIY",
    "Fashion Design",
    "Fashion",
    "Nutrition",
    "Health Coaching",
    "Social Media Marketing"
  ];

  List<int> selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: '',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select your interests",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    addVerticalSpacing(12),
                    Text(
                      "${VMString.bullet} What will you use VModel for?",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontSize: 12.sp,
                              ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    addVerticalSpacing(8),
                    Text(
                      "${VMString.bullet} Select up to 20 interests",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontSize: 12.sp,
                              ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    addVerticalSpacing(32),
                    Wrap(
                      children: List.generate(interests.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 0),
                          child: VWidgetsInterestsButton(
                              enableButton: selectedInterests.contains(index),
                              buttonTitle: interests[index],
                              onPressed: () {
                                onItemTap(index);
                              }),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            addVerticalSpacing(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: VWidgetsPrimaryButton(
                  buttonTitle:
                      'Save and continue (${selectedInterests.length} / 20)',
                  onPressed: () {
                    goBack(context);
                  }),
            ),
            addVerticalSpacing(16),
          ],
        ),
      ),
    );
  }

  void onItemTap(int interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      if (selectedInterests.length >= 20) {
        VWidgetShowResponse.showToast(ResponseEnum.warning,
            message: "Maximum of 20 intrests can be selected");
        return;
      }
      selectedInterests.add(interest);
    }
    setState(() {});
  }
}

class VWidgetsInterestsButton extends StatelessWidget {
  final String? buttonTitle;
  final VoidCallback? onPressed;
  final bool enableButton;
  final bool showLoadingIndicator;
  final double? butttonWidth;
  final double? buttonHeight;
  final TextStyle? buttonTitleTextStyle;
  final Color? buttonColor;
  final Color? splashColor;
  final double? borderRadius;
  const VWidgetsInterestsButton({
    super.key,
    required this.onPressed,
    this.buttonTitle,
    this.enableButton = true,
    this.buttonHeight,
    this.buttonTitleTextStyle,
    this.splashColor,
    this.buttonColor,
    this.butttonWidth,
    this.borderRadius,
    this.showLoadingIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _buttonPressedState,
      disabledColor: VmodelColors.greyColor.withOpacity(0.2),
      disabledTextColor: Theme.of(context).primaryColor.withOpacity(0.2),
      elevation: 0,
      minWidth: butttonWidth,
      height: buttonHeight ?? 40,
      textColor: enableButton == true
          ? Theme.of(context).buttonTheme.colorScheme!.onPrimary
          : Theme.of(context).primaryColor.withOpacity(0.2),
      color: enableButton == true
          ? buttonColor ?? Theme.of(context).buttonTheme.colorScheme?.background
          : Theme.of(context).buttonTheme.colorScheme?.secondary,
      // VmodelColors.jobDetailGrey.withOpacity(.5),

      // Theme.of(context)
      //     .buttonTheme
      //     .colorScheme
      //     ?.background
      //     .withOpacity(.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 8),
        ),
      ),
      splashColor: splashColor,
      child: showLoadingIndicator
          ? const Center(
              child: CupertinoActivityIndicator(
              color: Colors.white,
            ))
          : Text(
              buttonTitle ?? "",
              style: enableButton
                  ? buttonTitleTextStyle ??
                      Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: enableButton
                                ? Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .onPrimary
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                            fontWeight: FontWeight.w600,
                            // fontSize: 12.sp,
                          )
                  : Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w600,
                        // fontSize: 12.sp,
                      ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
    );
  }

  VoidCallback? get _buttonPressedState {
    // if (enableButton && !showLoadingIndicator) {
    return onPressed;
    // } else if (enableButton && showLoadingIndicator) {
    //   return () {};
    // }
    // return null;
  }
}
