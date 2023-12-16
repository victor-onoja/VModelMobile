import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../../../vmodel.dart';
import '../../register/provider/user_types_controller.dart';
import 'user_onboarding_card.dart';

class MainTalentSelection extends ConsumerStatefulWidget {
  const MainTalentSelection({
    super.key,
    required this.isPrimaryScroll,
    required this.onBackTap,
    required this.onItemTap,
  });
  final bool isPrimaryScroll;
  final VoidCallback onBackTap;
  final ValueChanged<int> onItemTap;

  @override
  ConsumerState<MainTalentSelection> createState() =>
      _MainTalentSelectionState();
}

class _MainTalentSelectionState extends ConsumerState<MainTalentSelection> {
  final _selectedIndex = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    final userTypes = ref.watch(accountTypesProvider);
    final allUserTypes = userTypes.valueOrNull;

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
                    //   accountType = AccountTypes.none;
                    //   // isSelectedBusiness = false;
                    //   // isSelectedTalent = false;
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
                  // primary: !isShowSubTalent,
                  primary: widget.isPrimaryScroll,
                  child: Column(
                    children: List.generate(allUserTypes?.talents.length ?? 0,
                        (index) {
                      return ValueListenableBuilder(
                          valueListenable: _selectedIndex,
                          builder: (context, value, _) {
                            return VWidgetsOnboardingCard(
                                title: allUserTypes?.talents[index],
                                isSelected: value == index,
                                onTap: () {
                                  // navigateToRoute(
                                  //     context,
                                  //     const SignUpPage(
                                  //         isBusinessAccount: true));
                                  _selectedIndex.value = index;
                                  widget.onItemTap(index);
                                  // isPet = allUserTypes.talents[index]
                                  //     .toLowerCase()
                                  //     .contains('pet');
                                  // subTalentList.clear();
                                  // isShowSubTalent = true;
                                  // setState(() {});
                                  // allUserTypes
                                  //     .getSubTalents(allUserTypes.talents[index])
                                  //     .then((value) {
                                  //   subTalentList = value;
                                  //   setState(() {});
                                  // });
                                  // WidgetsBinding.instance
                                  //     .addPostFrameCallback((duration) {
                                  //   ref
                                  //       .read(selectedAccountTypeProvider.notifier)
                                  //       .state = allUserTypes.talents[index];
                                  // });
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
