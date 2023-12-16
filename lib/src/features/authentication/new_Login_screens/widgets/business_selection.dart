import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../../../vmodel.dart';
import '../../register/provider/user_types_controller.dart';
import 'user_onboarding_card.dart';

class EnterpriseSelection extends ConsumerStatefulWidget {
  const EnterpriseSelection({
    super.key,
    // required this.isPrimaryScroll,
    required this.onBackTap,
    required this.onItemTap,
  });
  // final bool isPrimaryScroll;
  final VoidCallback onBackTap;
  final ValueChanged<int> onItemTap;

  @override
  ConsumerState<EnterpriseSelection> createState() =>
      _EnterpriseSelectionState();
}

class _EnterpriseSelectionState extends ConsumerState<EnterpriseSelection> {
  final _selectedIndex = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    final userTypes = ref.watch(accountTypesProvider);
    final allUserTypes = userTypes.valueOrNull;

    return Container(
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
                    //   // isSelectedBusiness = false;
                    //   accountType = AccountTypes.none;
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
            ...List.generate(allUserTypes?.enterprise.length ?? 0, (index) {
              return ValueListenableBuilder(
                  valueListenable: _selectedIndex,
                  builder: (context, value, _) {
                    return VWidgetsOnboardingCard(
                      title: allUserTypes?.enterprise[index],
                      isSelected: value == index,
                      onTap: () {
                        _selectedIndex.value = index;
                        //   ref.read(isAccountTypeBusinessProvider.notifier).state =
                        //       true;

                        //   ref.read(selectedAccountTypeProvider.notifier).state =
                        //       allUserTypes.enterprise[index];
                        //   navigateToRoute(context, const SignUpPage());
                        widget.onItemTap(index);
                      },
                    );
                  });
            }),
          ],
        ),
      ),
    );
  }
}
