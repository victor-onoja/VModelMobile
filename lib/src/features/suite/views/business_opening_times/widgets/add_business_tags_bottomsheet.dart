import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../../../../../res/res.dart';
import '../../../../../shared/modal_pill_widget.dart';
import '../../../../../vmodel.dart';
import '../../../../settings/views/verification/views/blue-tick/widgets/text_field.dart';
import '../controller/business_edit_extras_controller.dart';
import '../controller/business_open_times_controller.dart';
import '../models/business_open_times_info.dart';
import 'bussiness_tag_widget.dart';

class AddBusinessInfoTagsBottomSheet extends ConsumerStatefulWidget {
  AddBusinessInfoTagsBottomSheet({
    super.key,
    required this.title,
    required this.isSafety,
    required this.hasData,
    // required this.username,
  });

  final String title;
  final bool isSafety;
  final bool hasData;

  @override
  ConsumerState<AddBusinessInfoTagsBottomSheet> createState() =>
      _AddBusinessInfoTagsBottomSheetState();
}

class _AddBusinessInfoTagsBottomSheetState
    extends ConsumerState<AddBusinessInfoTagsBottomSheet> {
  // final List<String> extras = [
  //   'Live Band',
  //   'Live Band 2',
  //   "Children's Playground",
  // ];

  // final List<String> safety = [
  //   'Employees wear masks',
  //   "Appointment only, no walk-ins",
  //   "Disinfected surfaces and venue",
  // ];

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final openTimes = ref.watch(businessOpenTimesProvider(null));
    final initialExtras = ref.watch(businessInfoTag(VMString.businessExtraKey));
    final initialSafetyRules =
        ref.watch(businessInfoTag(VMString.businessSafetyRulesKey));

    // final fadedTextColor =
    //     Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5);

    // final appUser = ref.watch(appUserProvider).valueOrNull;

    return Container(
      constraints: BoxConstraints(
        maxHeight: SizerUtil.height * 0.8,
        minHeight: SizerUtil.height * 0.2,
        minWidth: SizerUtil.width,
      ),
      // margin: EdgeInsets.only(bottom: ),
      margin: EdgeInsets.only(
        // top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        // color: VmodelColors.white,
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addVerticalSpacing(15),
          const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
          addVerticalSpacing(8),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // addVerticalSpacing(15),
                  // const Align(
                  //     alignment: Alignment.center, child: VWidgetsModalPill()),
                  addVerticalSpacing(16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                  addVerticalSpacing(16),
                  Wrap(
                    children: List.generate(
                      widget.isSafety
                          ? initialSafetyRules.length
                          : initialExtras.length,
                      (index) {
                        final item = widget.isSafety
                            ? initialSafetyRules[index]
                            : initialExtras[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: BusinessInfoTagWidget(
                              // enableButton: false,
                              // buttonTitle: extras[index],
                              isSelected: item.isSelected,
                              text: item.title,
                              onPressed: () {
                                // onItemTap(index);
                              }),
                        );
                      },
                    ),
                  ),

                  // ...List.generate(
                  //   extras.length,
                  //   (index) {
                  //     return BusinessInfoTagWidget(
                  //         // enableButton: false,
                  //         // buttonTitle: extras[index],
                  //         text: extras[index],
                  //         onPressed: () {
                  //           // onItemTap(index);
                  //         });
                  //   },
                  // ).toList(),
                  addVerticalSpacing(16),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 24),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         "Extras",
                  //         overflow: TextOverflow.ellipsis,
                  //         maxLines: 1,
                  //         style:
                  //             Theme.of(context).textTheme.bodyMedium!.copyWith(
                  //                   fontWeight: FontWeight.w600,
                  //                   // color: VmodelColors.primaryColor,
                  //                 ),
                  //       ),
                  //       addVerticalSpacing(4),
                  //     ],
                  //   ),
                  // ),
                  // VWidgetsTextButton(
                  //   text: 'Close',
                  //   onPressed: () => goBack(context),
                  // ),
                  addVerticalSpacing(24),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: VWidgetsTextFieldNormal(
              // label: "",
              hintText: "Ex. Amusement park",
              controller: textController,
              textCapitalization: TextCapitalization.words,
              suffixWidget: InkWell(
                  onTap: () async {
                    final text = textController.text.trim();
                    if (text.isEmptyOrNull) {
                      return;
                    }
                    // if (widget.hasData) {
                    //   await ref
                    //       .read(businessOpenTimesProvider(null).notifier)
                    //       .addBusinessExtras([text]);
                    // }

                    if (widget.isSafety) {
                      ref
                          .read(businessInfoTag(VMString.businessSafetyRulesKey)
                              .notifier)
                          .add(BusinessWorkingInfoTag(
                              title: text, isSelected: true));
                    } else {
                      ref
                          .read(businessInfoTag(VMString.businessExtraKey)
                              .notifier)
                          .add(BusinessWorkingInfoTag(
                              title: text, isSelected: true));
                    }
                    textController.clear();
                  },
                  child: Text('Save')),
              // onChanged: (value) {},
            ),
          ),
          // VWidgetsTextButton(
          //   text: 'Close',
          //   onPressed: () => goBack(context),
          // ),
          // addVerticalSpacing(24),
        ],
      ),
    );
  }
}
