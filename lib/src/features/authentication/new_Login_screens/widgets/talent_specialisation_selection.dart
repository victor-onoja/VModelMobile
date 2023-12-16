import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../../../vmodel.dart';
import 'user_onboarding_card.dart';

class TalentSpecialisationSelection extends ConsumerStatefulWidget {
  const TalentSpecialisationSelection({
    super.key,
    required this.isPrimaryScroll,
    required this.isPet,
    required this.onBackTap,
    required this.onItemTap,
    required this.talentSpecialisations,
  });
  final bool isPrimaryScroll;
  final bool isPet;
  final List<String> talentSpecialisations;
  final VoidCallback onBackTap;
  final ValueChanged<int> onItemTap;

  @override
  ConsumerState<TalentSpecialisationSelection> createState() =>
      _TalentSpecialisationSelectionState();
}

class _TalentSpecialisationSelectionState
    extends ConsumerState<TalentSpecialisationSelection> {
  final _selectedIndex = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    // final selectedSpecialisation = ref.watch(selectedAccountLabelProvider);
    return Container(
      height: 35.h,
      width: 91.w,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VmodelColors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   isShowSubTalent = false;
                    // });
                    widget.onBackTap();
                  },
                  child: const RenderSvg(
                    svgPath: VIcons.arrowLeft,
                    color: VmodelColors.primaryColor,
                  ),
                ),
                addHorizontalSpacing(90),
                Text(
                  "Select Category",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: VmodelColors.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            addVerticalSpacing(12),
            //! Restructure the category list logic

            Expanded(
              child: RawScrollbar(
                mainAxisMargin: 9,
                thumbVisibility: true,
                thumbColor: VmodelColors.primaryColor,
                radius: const Radius.circular(10),
                child: SingleChildScrollView(
                  // primary: isShowSubTalent && !isShowPetBreed,
                  primary: widget.isPrimaryScroll,
                  child: Column(
                    // children: List.generate(subTalentList.length, (index) {
                    children: List.generate(widget.talentSpecialisations.length,
                        (index) {
                      return ValueListenableBuilder(
                          valueListenable: _selectedIndex,
                          builder: (context, value, _) {
                            return VWidgetsOnboardingCard(
                                // title: subTalentList[index].capitalizeFirst,
                                title: widget.talentSpecialisations[index]
                                    .capitalizeFirst,
                                isSelected: value ==
                                    widget.talentSpecialisations[index],
                                // isSelected:
                                //     selectedSpecialisation.toLowerCase() ==
                                //         widget.talentSpecialisations[index]
                                //             .toLowerCase(),
                                onTap: () {
                                  _selectedIndex.value =
                                      widget.talentSpecialisations[index];
                                  widget.onItemTap(index);
                                  // if (isPet) {
                                  //   isShowPetBreed = true;
                                  //   // subTalentList.clear();
                                  //   petBreedList = allUserTypes
                                  //       .getPetBreed(subTalentList[index]);
                                  //   setState(() {});
                                  // } else {
                                  //   ref
                                  //       .read(selectedAccountLabelProvider.notifier)
                                  //       .state = subTalentList[index];
                                  //   navigateToRoute(context, const SignUpPage());
                                  // }
                                });
                          });
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
