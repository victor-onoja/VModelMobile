import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_parsed_text_field/flutter_parsed_text_field.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:vmodel/src/core/models/app_user.dart';

import '../../../core/utils/debounce.dart';
import '../../../res/ui_constants.dart';
import '../../dashboard/discover/controllers/discover_controller.dart';

import 'package:sizer/sizer.dart';

// class Avenger {
//   final String userId;
//   final String displayName;

//   Avenger({
//     required this.userId,
//     required this.displayName,
//   });
// }

class VMentionableDescriptionField extends riverpod.ConsumerStatefulWidget {
  const VMentionableDescriptionField({
    super.key,
    this.minLines,
    this.maxLines,
    this.onChanged,
    this.onTap,
    this.initialValue,
    this.keyboardType,
    this.onSaved,
    this.obscureText = false,
    this.hintText,
    this.hintStyle,
    this.maxLength,
    this.controller,
    this.validator,
    this.shouldReadOnly = false,
    this.minWidth,
    this.helperText,
    this.textCapitalization = TextCapitalization.sentences,
    this.showCounter = false,
    this.inputFormatters,
    this.label,
    this.labelStyle,
    this.scrollController,
  });

  final String? label;
  final int? minLines;
  final String? initialValue;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final int? maxLength;
  final TextEditingController? controller;
  final dynamic validator;
  final bool shouldReadOnly;
  final double? minWidth;
  final String? helperText;
  final ScrollController? scrollController;
  final TextCapitalization textCapitalization;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final bool showCounter;
  final List<TextInputFormatter>? inputFormatters;

  @override
  riverpod.ConsumerState<VMentionableDescriptionField> createState() =>
      _VMentionableFieldState();
}

class _VMentionableFieldState
    extends riverpod.ConsumerState<VMentionableDescriptionField> {
  final flutterParsedTextFieldController = FlutterParsedTextFieldController();

  /// this is what sends the selected suggestion down to FlutterParsedTextField
  final suggestionApplier = SuggestionApplier();

  Matcher? matcher;
  List? matchedSuggestions;
  int matchedStart = 0;
  int matchedEnd = 0;
  late final Debounce _debounce;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _debounce = Debounce(delay: Duration(milliseconds: 300));
    _scrollController = widget.scrollController ?? ScrollController();
    if (widget.controller?.text != null) {
      flutterParsedTextFieldController.text = widget.controller!.text;
    }

    flutterParsedTextFieldController.addListener(customListen);
  }

  void customListen() {
    // if (flutterParsedTextFieldController.matchers.isEmpty) return;
    // final start = flutterParsedTextFieldController.matchers.first.indexOfMatch;
    // final end = flutterParsedTextFieldController.matchers.first.lengthOfMatch;
    // log('Matched string is ${flutterParsedTextFieldController.matchers.first.asString}, $end)}');
    // log('Matched string is $matchedStart,$matchedEnd');
    // log('Matched string is ${flutterParsedTextFieldController.text.substring(matchedStart, matchedStart + matchedEnd)}');
    widget.controller?.text = flutterParsedTextFieldController.text;
  }

  @override
  void dispose() {
    super.dispose();
    flutterParsedTextFieldController.removeListener(customListen);
  }

  @override
  Widget build(BuildContext context) {
    // flutterParsedTextFieldController.
    final suggestedUsers = ref.watch(searchUsersProvider);

    return PortalTarget(
        visible: suggestedUsers.hasValue,
        anchor: Aligned(
          // follower: Alignment.center,
          // target: Alignment(0, -4.2),
          follower:
              // widget.isFollowerTop ? Alignment.bottomLeft : Alignment.topLeft,
              Alignment.bottomLeft,
          target:
              // widget.isFollowerTop ? Alignment.topLeft : Alignment.bottomLeft,
              Alignment.topLeft,
          widthFactor: 1,
        ),
        portalFollower: suggestedUsers.maybeWhen(
          data: (items) {
            if (items.isEmpty) return SizedBox.shrink();
            return Card(
                color: Theme.of(context).cardColor,
                // color: Colors.amber,
                elevation: 5,
                child: ConstrainedBox(
                  // height: ,
                  constraints: BoxConstraints(maxHeight: 250),
                  child: ListView.builder(
                    itemCount: items?.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    itemBuilder: (BuildContext context, int index) {
                      final suggestion = items![index] as VAppUser;

                      return ListTile(
                        leading: CircleAvatar(
                          // backgroundImage: Image.network('${profile.pictureUrl}').image,
                          backgroundImage: CachedNetworkImageProvider(
                              '${suggestion.profilePictureUrl}'),
                        ),
                        title: Text('@${suggestion.username}'),
                        subtitle: Text(
                          suggestion.displayName,
                          // th
                        ),
                        onTap: () {
                          /// send the tapped suggestion down to FlutterParsedTextField for processing
                          suggestionApplier.updateSuggestion(
                            matcher: matcher!,
                            suggestionToApply: suggestion,
                          );
                        },
                      );
                    },
                  ),
                ));
            // return (matchedSuggestions == null || matchedSuggestions?.length == 0)
            //     ? SizedBox.shrink()
            //     : Card(
            //         color: Theme.of(context).cardColor,
            //         // color: Colors.amber,
            //         elevation: 5,
            //         child: ListView.builder(
            //           itemCount: matchedSuggestions?.length,
            //           shrinkWrap: true,
            //           itemBuilder: (BuildContext context, int index) {
            //             final suggestion = matchedSuggestions![index] as VAppUser;

            //             return ListTile(
            //               title: Text('@${suggestion.displayName}'),
            //               subtitle: Text(suggestion.username),
            //               onTap: () {
            //                 /// send the tapped suggestion down to FlutterParsedTextField for processing
            //                 suggestionApplier.updateSuggestion(
            //                   matcher: matcher!,
            //                   suggestionToApply: suggestion,
            //                 );
            //               },
            //             );
            //           },
            //         ));
          },
          orElse: () {
            return SizedBox.shrink();
          },
        ),
        child: SizedBox(
          width: widget.minWidth ?? 100.0.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label ?? "",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: 1.0.h),
              SizedBox(
                // height: maxLength != null ? 9.h : 7.h,
                width: widget.minWidth ?? 100.0.w,
                child: Scrollbar(
                  controller: _scrollController,
                  // thumbVisibility: true,
                  radius: const Radius.circular(10),
                  child: ChangeNotifierProvider<SuggestionApplier>.value(
                    value: suggestionApplier,
                    builder: (_, __) => FlutterParsedTextField(
                      controller: flutterParsedTextFieldController,
                      inputFormatters: widget.inputFormatters,
                      decoration: UIConstants.instance.inputDecoration(
                        context,
                        prefixIcon: null,
                        suffixIcon: null,
                        hintText: widget.hintText,
                        helperText: widget.helperText,
                        hintStyle: widget.hintStyle,
                        showCounter: widget.showCounter,
                      ),
                      autocorrect: false,
                      enableSuggestions: false,
                      textCapitalization: widget.textCapitalization,
                      minLines: widget.minLines ?? 6,
                      maxLines: widget.maxLines ?? 30,
                      textInputAction: TextInputAction
                          .newline, // Sets the "Enter" key behavior
                      // keyboardType: TextInputType.multiline,
                      maxLength: widget.maxLength,
                      onTap: widget.onTap,
                      onChanged: (text) {
                        widget.onChanged?.call(text);
                      },
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType:
                          widget.keyboardType ?? TextInputType.multiline,
                      obscureText: widget.obscureText,
                      // style: Theme.of(context).textTheme.displayMedium,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryColor,
                              ),
                      readOnly: widget.shouldReadOnly,
                      disableSuggestionOverlay: true,
                      suggestionLimit: 5,
                      // onChanged: (val) {
                      //   ref.read(discoverProvider.notifier).searchUsers(val.trim());
                      // },

                      suggestionMatches: (matcher, suggestions) async {
                        log('matcher: ${matcher?.asString}'); //, sugg: $suggestions');
                        if (matcher != null && matcher.trigger == '@') {
                          matchedStart = matcher?.indexOfMatch ?? 0;
                          matchedEnd =
                              matchedStart + (matcher.lengthOfMatch ?? 0);
                          log('Len: ${flutterParsedTextFieldController.text}, endis: $matchedEnd'); //, sugg: $suggestions');
                          String query = flutterParsedTextFieldController.text
                              .substring(matchedStart, matchedEnd);
                          query = query.replaceAll('@', '')..trim();
                          log('Len: ${flutterParsedTextFieldController.text},\n query: $query'); //, sugg: $suggestions');
                          _debounce(
                            () async {
                              await ref
                                  .read(discoverProvider.notifier)
                                  .searchUsers(query);
                              setState(() {
                                this.matcher = matcher;
                                matchedSuggestions = suggestions;
                              });
                            },
                          );
                        }
                        ref.invalidate(searchUsersProvider);

                        /// returns the matcher and suggestions based on your input
                        setState(() {
                          this.matcher = matcher;
                          matchedSuggestions = suggestions;
                        });
                      },
                      matchers: [
                        Matcher<VAppUser>(
                          trigger: "@",
                          suggestions: suggestedUsers.valueOrNull ?? [],
                          //     [
                          //   VAppUser.fromMinimalMap({
                          //     'id': '38',
                          //     'username': 'chrome',
                          //     'displayName': 'Ironman',
                          //   }),
                          //   VAppUser.fromMinimalMap({
                          //     'id': '180',
                          //     'username': 'green',
                          //     'displayName': 'Hulk',
                          //   }),
                          //   VAppUser.fromMinimalMap({
                          //     'id': '880',
                          //     'username': 'black',
                          //     'displayName': 'Black Widow',
                          //   }),
                          // ],
                          idProp: (avenger) => avenger.username,
                          displayProp: (avenger) => avenger.username,
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                          stringify: (trigger, avenger) {
                            return '[$trigger${avenger.username}]';
                          },
                          // parseRegExp: RegExp(r"\[(@([^\]]+)):([^\]]+)\]"),
                          parseRegExp: RegExp(r"@(\w+)"),
                          parse: (regex, avengerString) {
                            log('>>>>> $avengerString');
                            final avenger = regex.firstMatch(avengerString);

                            if (avenger != null) {
                              return VAppUser.fromMinimalMap(
                                  {"username": avenger.group(3)!});
                              // return Avenger(
                              //   userId: avenger.group(3)!,
                              //   displayName: avenger.group(2)!,
                              // );
                            }

                            throw 'Avenger not found';
                          },
                          onSuggestionAdded: ((trigger, suggestion) {
                            log('added $suggestion');

                            ref.invalidate(searchUsersProvider);
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )

        // Text('Hello'),
        );
  }
}

extension MapMatcher on Matcher? {
  get asString {
    // suggestions: ${this?.suggestions},
    // idProp: ${this?.idProp},
    // displayProp: ${this?.displayProp},
    // searchStyle: ${this?.searchStyle},
    // resultSort: ${this?.resultSort},
    // finalResultSort: ${this?.finalResultSort},
    // stringify: ${this?.stringify},
    // parseRegExp: ${this?.parseRegExp},
    // parse: ${this?.parse},
    // onSuggestionAdded: ${this?.onSuggestionAdded},
    // style: ${this?.style},
    // suggestionBuilder: ${this?.suggestionBuilder},
    // alwaysHighlight: ${this?.alwaysHighlight},
    return '''Matcher(trigger: ${this?.trigger},
                indexOfMatch: ${this?.indexOfMatch},
                lengthOfMatch: ${this?.lengthOfMatch},
                )''';
  }
}
