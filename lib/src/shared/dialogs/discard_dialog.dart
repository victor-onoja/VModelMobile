import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/color_slider/vm_color_slider.dart';

import '../../core/controller/discard_editing_controller.dart';
import '../../vmodel.dart';

class DiscardDialog extends ConsumerStatefulWidget {
  const DiscardDialog({super.key, this.onDiscard});
  final VoidCallback? onDiscard;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnalyticsColorDailogState();
}

class _AnalyticsColorDailogState extends ConsumerState<DiscardDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final analyticsPageColors = ref.watch(qrPageColorsProvider);
    // Color myColorTop = Color(0xFFDC3535);
    return StatefulBuilder(builder: (context, stflState) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: SizerUtil.height * 0.25,
            width: SizerUtil.width * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                addVerticalSpacing(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "You have unsaved changes. Do you want to continue editing or discard changes?",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 10.sp),
                        ),
                      ),
                      // CupertinoSwitch(value: value, onChanged: onChanged)
                    ],
                  ),
                ),
                addVerticalSpacing(20),
                // VWidgetsPrimaryButton(
                //   butttonWidth: MediaQuery.of(context).size.width / 1.8,
                //   onPressed: () {
                //     goBack(context);
                //     goBack(context);
                //   },
                //   enableButton: true,
                //   buttonTitle: "Save Draft",
                // ),
                // addVerticalSpacing(10),
                VWidgetsPrimaryButton(
                  butttonWidth: MediaQuery.of(context).size.width / 1.8,
                  onPressed: () {
                    goBack(context);
                  },
                  enableButton: true,
                  buttonTitle: "Continue",
                ),
                addVerticalSpacing(10),
                VWidgetsPrimaryButton(
                  buttonColor: Colors.red,
                  butttonWidth: MediaQuery.of(context).size.width / 1.8,
                  onPressed: () {
                    ref.invalidate(discardProvider);
                    if (widget.onDiscard == null) {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                      return;
                    }
                    widget.onDiscard?.call();
                  },
                  enableButton: true,
                  buttonTitle: "Discard",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
