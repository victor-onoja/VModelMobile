import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../../../vmodel.dart';
import 'user_onboarding_card.dart';

class PetBreedSelection extends StatefulWidget {
  const PetBreedSelection({
    super.key,
    required this.isPrimaryScroll,
    required this.petBreedList,
    required this.onBackTap,
    required this.onItemTap,
  });
  final bool isPrimaryScroll;
  final List<String> petBreedList;
  final VoidCallback onBackTap;
  final ValueChanged<int> onItemTap;

  @override
  State<PetBreedSelection> createState() => _PetBreedSelectionState();
}

class _PetBreedSelectionState extends State<PetBreedSelection> {
  final _selectedIndex = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
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
                    //   isShowPetBreed = false;
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
                  // primary: isShowPetBreed,
                  primary: widget.isPrimaryScroll,
                  child: Column(
                    // children: List.generate(petBreedList.length, (index) {
                    children:
                        List.generate(widget.petBreedList.length, (index) {
                      return ValueListenableBuilder(
                          valueListenable: _selectedIndex,
                          builder: (context, value, _) {
                            return VWidgetsOnboardingCard(
                                title:
                                    widget.petBreedList[index].capitalizeFirst,
                                isSelected: value == index,
                                onTap: () {
                                  _selectedIndex.value = index;
                                  // ref
                                  //     .read(selectedAccountLabelProvider.notifier)
                                  //     .state = petBreedList[index];
                                  // navigateToRoute(context, const SignUpPage());
                                  widget.onItemTap(index);
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
