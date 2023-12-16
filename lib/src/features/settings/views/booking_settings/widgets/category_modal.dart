import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/costants.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/vmodel.dart';

class CategoryModal extends ConsumerStatefulWidget {
  const CategoryModal({
    Key? key,
    required this.categoryList,
    required this.selectedCategoryList,
    required this.onTap,
  }) : super(key: key);
  final List<Map> categoryList;
  final List selectedCategoryList;
  final void Function() onTap;

  @override
  ConsumerState<CategoryModal> createState() => _SendWidgetState();
}

class _SendWidgetState extends ConsumerState<CategoryModal> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> mockData = [];
  bool loaded = false;
  List selectedList = [];
  int shimmerLength = 15;

  late final Debounce _debounce;

  @override
  initState() {
    super.initState();
    _debounce = Debounce(delay: Duration(milliseconds: 300));
  }

  @override
  dispose() {
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.categoryList.length);
    // if (!loaded) {
    //   connections.when(
    //       data: (Either<CustomException, List<dynamic>> data) {
    //         return data.fold((p0) => const SizedBox.shrink(), (p0) {
    //           mockData =
    //               List.generate(p0.length, (index) => {"selected": false});
    //           loaded = true;
    //         });
    //       },
    //       error: (Object error, StackTrace stackTrace) {},
    //       loading: () {});
    // }
    // // }
    return SafeArea(
      child: Container(
        // height: 600,
        constraints: const BoxConstraints(
          minHeight: 200,
        ),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: VConstants.bottomPaddingForBottomSheets,
        ),
        decoration: BoxDecoration(
            // color: Colors.white,
            // color: Theme.of(context).colorScheme.surface,
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8), topLeft: Radius.circular(8))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: VmodelColors.primaryColor.withOpacity(0.15),
                ),
              ),
            ),
            addVerticalSpacing(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select categories",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      // color: VmodelColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Select up to 3 categories",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            addVerticalSpacing(10),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.categoryList.length,
                itemBuilder: (context, index) {
                  var category = widget.categoryList[index];
                  return GestureDetector(
                    onTap: () {
                      if (widget.selectedCategoryList.length < 3) {
                        category["selected"] = !category["selected"];
                        widget.onTap();
                        setState(() {});
                      } else {
                        category["selected"] = false;
                        widget.onTap();
                        setState(() {});
                      }
                    },
                    child: SendOption(
                      title: '${category['item']}',
                      selected: category["selected"],
                      onTap: () {
                        if (widget.selectedCategoryList.length < 3) {
                          category["selected"] = !category["selected"];
                          widget.onTap();
                          setState(() {});
                        } else {
                          category["selected"] = false;
                          widget.onTap();
                          setState(() {});
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            addVerticalSpacing(15),
            VWidgetsPrimaryButton(
              buttonTitle: "Done",
              enableButton:
                  widget.categoryList.any((element) => element['selected']),
              onPressed: () => Navigator.pop(context),
            ),
            addVerticalSpacing(20)
          ],
        ),
      ),
    );
  }
}

class SendOption extends StatelessWidget {
  const SendOption({
    Key? key,
    required this.title,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final String title;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  // color: VmodelColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        addVerticalSpacing(4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onTap,
              icon: selected
                  ? const Icon(
                      Icons.radio_button_checked_rounded,
                      // color: VmodelColors.primaryColor,
                    )
                  : Icon(
                      Icons.radio_button_off_rounded,
                      // color: VmodelColors.primaryColor.withOpacity(0.5),
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
            ),
          ],
        ));
  }
}
