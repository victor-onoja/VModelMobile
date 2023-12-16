import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../res/res.dart';
import '../../../../vmodel.dart';
import '../../register/provider/user_types_controller.dart';
import 'user_onboarding_card.dart';

class QuestionSelection extends ConsumerStatefulWidget {
  const QuestionSelection({
    super.key,
    required this.onEnterpriseSelect,
    required this.onTalentSelect,
  });
  final VoidCallback onEnterpriseSelect;
  final VoidCallback onTalentSelect;

  @override
  ConsumerState<QuestionSelection> createState() => _QuestionSelectionState();
}

class _QuestionSelectionState extends ConsumerState<QuestionSelection> {
  int _selectedIndex = -1; //-1 means none selected;
  @override
  Widget build(BuildContext context) {
    final userTypes = ref.watch(accountTypesProvider);
    final allUserTypes = userTypes.valueOrNull;

    return Container(
      margin: const EdgeInsets.all(16),
      width: 91.w,
      decoration: BoxDecoration(
        color: VmodelColors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 700),
          firstCurve: Curves.easeInOut,
          secondCurve: Curves.easeInOut,
          crossFadeState: allUserTypes == null
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: const Center(child: CircularProgressIndicator.adaptive()),
          secondChild: Column(
            children: [
              VWidgetsOnboardingCard(
                  // title: 'to book Talent or Creators',
                  title: 'To Book Talent or Creators',
                  isSelected: _selectedIndex == 0,
                  onTap: () {
                    setState(() {
                      // isSelectedBusiness = true;
                      // isSelectedTalent = false;
                      //   accountType = AccountTypes.enterprise;
                      _selectedIndex = 0;
                    });
                    widget.onEnterpriseSelect();
                  }),
              VWidgetsOnboardingCard(
                  // title: 'to gain access to jobs',
                  title: 'To Gain Access To Jobs',
                  isSelected: _selectedIndex == 1,
                  onTap: () {
                    setState(() {
                      // isSelectedBusiness = false;
                      // isSelectedTalent = true;
                      //   accountType = AccountTypes.talent;
                      _selectedIndex = 1;
                    });

                    widget.onTalentSelect();
                  }),
              VWidgetsOnboardingCard(
                  // title: 'to book and get booked',
                  title: 'To Book And Get Booked',
                  isSelected: _selectedIndex == 2,
                  onTap: () {
                    setState(() {
                      // isSelectedBusiness = false;
                      // isSelectedTalent = true;
                      //   accountType = AccountTypes.talent;
                      _selectedIndex = 2;
                    });
                    widget.onTalentSelect();
                  }),
              VWidgetsOnboardingCard(
                  // title: 'to network with other creators',
                  title: 'To Network With Other Creators',
                  isSelected: _selectedIndex == 3,
                  onTap: () {
                    setState(() {
                      // isSelectedBusiness = false;
                      // isSelectedTalent = true;
                      //   accountType = AccountTypes.talent;
                      _selectedIndex = 3;
                    });
                    widget.onTalentSelect();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
