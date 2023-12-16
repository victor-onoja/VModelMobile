import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../res/res.dart';
import '../controller/business_edit_extras_controller.dart';
import '../models/business_open_times_info.dart';
import 'add_business_tags_bottomsheet.dart';
import 'bussiness_tag_widget.dart';

class BusinessOtherInfoSection extends ConsumerStatefulWidget {
  const BusinessOtherInfoSection({
    super.key,
    required this.sectionTitle,
    required this.icon,
    required this.data,
    required this.onAddTag,
    required this.onRemoveTag,
    // required this.predefinedTags,

    this.isSafety = false,
  });
  //temporary
  final bool isSafety;
  final String sectionTitle;
  final Widget icon;
  final ValueChanged<List<String>> onAddTag;
  final ValueChanged<String> onRemoveTag;
  // final List<String> predefinedTags;

  final List<BusinessWorkingInfoTag> data;

  @override
  ConsumerState<BusinessOtherInfoSection> createState() =>
      _BusinessOtherInfoSectionState();
}

class _BusinessOtherInfoSectionState
    extends ConsumerState<BusinessOtherInfoSection> {
  // final List<BusinessWorkingInfoTag> preDefinedExtras = [
  //   BusinessWorkingInfoTag(title: 'Live Band'),
  //   BusinessWorkingInfoTag(title: "Children's Playground"),
  // ];

  // final List<BusinessWorkingInfoTag> preDefinedSafetyRules = [
  //   BusinessWorkingInfoTag(title: 'Employees wear masks'),
  //   BusinessWorkingInfoTag(title: "Appointment only, no walk-ins"),
  //   BusinessWorkingInfoTag(title: "Disinfected surfaces and venue"),
  // ];
  // final Set<String> safety = {
  //   'Employees wear masks',
  //   "Appointment only, no walk-ins",
  //   "Disinfected surfaces and venue",
  // };

  List<BusinessWorkingInfoTag> availableTags = [];
  List<BusinessWorkingInfoTag> selectedTags = [];

  @override
  void initState() {
    super.initState();
    // availableTags = widget.isSafety ? preDefinedSafetyRules : preDefinedExtras;

    print('[uushs] ${widget.data}');
  }

  @override
  Widget build(BuildContext context) {
    print('[uushs1] ${widget.data}');
    if (widget.data.isNotEmpty) {
      availableTags = widget.data;
      // availableTags.addAll(widget.data);
    }

    // final initialExtras = ref.watch(initailExtrasProvider);
    // final initialSafetyRules = ref.watch(initailSafetyRulesProvider);

    // final initialExtras = ref.watch(businessInfoTag('extras'));
    // final initialSafetyRules = ref.watch(businessInfoTag('safety'));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(widget.sectionTitle,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                addHorizontalSpacing(6),
                widget.icon,
              ],
            ),
            Row(
              children: [
                IconButton(
                    splashRadius: 20,
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          useSafeArea: true,
                          // constraints: BoxConstraints(
                          //   maxHeight: 400,
                          // ),
                          builder: (context) {
                            return AddBusinessInfoTagsBottomSheet(
                              title: widget.sectionTitle,
                              isSafety: widget.isSafety,
                              hasData: widget.data.isNotEmpty,
                            );
                          });
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
          ],
        ),
        Wrap(
          children: List.generate(getAvailableTags.length, (index) {
            final item = getAvailableTags[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              child: BusinessInfoTagWidget(
                  // enableButton: false,
                  // buttonTitle: extras[index],
                  // isSelected: selectedTags.contains(safety.elementAt(index)),
                  isSelected: getAvailableTags[index].markAsSelected,
                  text: getAvailableTags.elementAt(index).title,
                  onPressed: () {
                    addOrRemoveSelectedTag(item);
                  }),
            );
          }),
        ),
      ],
    );
  }

  List<BusinessWorkingInfoTag> get getAvailableTags {
    return widget.isSafety
        ? ref.watch(businessInfoTag(VMString.businessSafetyRulesKey))
        : ref.watch(businessInfoTag(VMString.businessExtraKey));
  }

  bool hasItem(String arg, BusinessWorkingInfoTag value) {
    return ref.read(businessInfoTag(arg).notifier).existsAlready(value);
  }

  void addOrRemoveSelectedTag(BusinessWorkingInfoTag tag) {
    // if (availableTags.contains(index)) {
    //   availableTags.remove(index);
    // } else {
    //   availableTags.add(index);
    // }
    // availableTags.sort();

    // if (widget.data.isEmpty && widget.isSafety) {
    if (widget.isSafety) {
      // selectedTags.add(tag);
      // ref.read(initailSafetyRulesProvider.notifier).state = tag;
      // setState(() {});

      ref
          .read(businessInfoTag(VMString.businessSafetyRulesKey).notifier)
          .onTapped(tag);
      return;
      // } else if (widget.data.isEmpty && !widget.isSafety) {
    } else if (!widget.isSafety) {
      // selectedTags.add(tag);
      // ref.read(initailExtrasProvider.notifier).state = tag;
      // setState(() {});
      ref
          .read(businessInfoTag(VMString.businessExtraKey).notifier)
          .onTapped(tag);
      return;
    }

    if (tag.id != null) {
      // widget.onRemoveTag(tag.id!);
    } else {
      // widget.onAddTag([tag.title]);
      // widget.onAddTag(selectedTags.map((e) => e.title).toList());
    }
    setState(() {});
  }

  // List<BusinessWorkingInfoTag> filterPredefined() {
  //   final BusinessWorkingInfoTag unselectedPredefined = [];
  //   for(int i=0; i<availableTags)
  // }
}
