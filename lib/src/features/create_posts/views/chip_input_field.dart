import 'package:cached_network_image/cached_network_image.dart';
import 'package:choose_input_chips/choose_input_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/models/app_user.dart';

import '../../../res/ui_constants.dart';

class VWidgetChipsField extends ConsumerStatefulWidget {
  const VWidgetChipsField({
    Key? key,
    required this.onChanged,
    required this.suggestions,
    this.maxNumberOfChips,
    this.initialValue = const [],
  }) : super(key: key);
  final int? maxNumberOfChips;
  final ValueChanged onChanged;
  final List<VAppUser> initialValue;
  final Future<List<VAppUser>> Function(String) suggestions;

  @override
  ConsumerState<VWidgetChipsField> createState() => _VWidgetChipsFieldState();
}

class _VWidgetChipsFieldState extends ConsumerState<VWidgetChipsField> {
  // final List<SearchUserModel> featured = [];
  final featured = [];

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return ChipsInput<VAppUser>(
      // key: _chipKey,

      autofocus: false,
      maxChips: widget.maxNumberOfChips,
      initialValue: widget.initialValue,

      // const [
      //   // AppProfile('John', 'john@flutter.io', 'man-3.png')
      // ],
      // focusNode: _focusNode,
      showKeyboard: false,
      allowChipEditing: true,
      suggestionsBoxDecoration: BoxDecoration(
        // borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
        borderRadius: BorderRadius.circular(8),
        // color: Colors.red.shade300,
      ),
      suggestionsBoxMaxHeight: 200,
      suggestionsBoxElevation: 5,

      // elevationBorderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      // elevationBorderRadius: BorderRadius.circular(8),
      textStyle: const TextStyle(
        // height: 1,
        fontSize: 16,
      ),
      decoration: UIConstants.instance.inputDecoration(
        context,
        prefixIcon: null,
        suffixIcon: null,
        hintText: '@',
        helperText: widget.maxNumberOfChips == null
            ? null
            : 'Maximum of ${widget.maxNumberOfChips} mentions',
        hintStyle: null,
        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 40),
      ),
      // decoration: InputDecoration(
      //   helperText: widget.maxNumberOfChips == null
      //       ? null
      //       : 'Maximum of ${widget.maxNumberOfChips} mentions',
      //   labelText: '@',
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(8),
      //   ),
      //   contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      // ),
      findSuggestions: (String query) async {
        final temp = await widget.suggestions(query);
        return temp;
      },
      onChanged: (data) {
        // this is a good place to update application state
        widget.onChanged(data);
      },
      chipBuilder: (context, state, VAppUser profile) {
        return InputChip(
          key: ObjectKey(profile.username),
          // label: Text(profile.fullName),
          label: Text(profile.username),
          avatar: CircleAvatar(
            // backgroundImage: Image.network('${profile.pictureUrl}').image,
            backgroundImage:
                CachedNetworkImageProvider('${profile.profilePictureUrl}'),
          ),
          onDeleted: () => state.deleteChip(profile),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      },
      suggestionBuilder: (context, state, VAppUser profile) {
        return ListTile(
          // contentPadding: EdgeInsets.symmetric(vertical: ),
          key: ObjectKey(profile),
          leading: CircleAvatar(
            backgroundImage:
                CachedNetworkImageProvider('${profile.profilePictureUrl}'),
          ),
          title: Text(profile.displayName),
          subtitle: Text('@${profile.username}'),
          onTap: () {
            state.selectSuggestion(profile);
          },
        );
      },
    );
  }
}
