import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/res.dart';

class CaptionText extends StatefulWidget {
  const CaptionText(
      // this.text,
      {
    Key? key,
    this.trimLines = 3,
    required this.username,
    required this.onUsernameTap,
    required this.onMentionedUsernameTap,
    this.onHashTag,
    required this.text,
  }) : super(key: key);

  final String text;
  final String username;
  final int trimLines;
  final VoidCallback onUsernameTap;
  final ValueChanged<String> onMentionedUsernameTap;
  final ValueChanged<String>? onHashTag;

  @override
  State<CaptionText> createState() => _CaptionTextState();
}

class _CaptionTextState extends State<CaptionText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    // print(']]]?? ${widget.text}');

    final TextStyle baseStyle =
        Theme.of(context).textTheme.displaySmall!.copyWith(
              // color: VmodelColors.text,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            );
    // final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = VmodelColors.text;
    // final widgetColor = Colors.black;
    TextSpan link = TextSpan(
        text: _readMore ? "...more" : "...less",
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
              // color: colorClickableText,
            ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data

        final text = TextSpan(
          text: '${widget.username} ${widget.text}',
          style:
              baseStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 10.sp),
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              // .rtl, //better to pass this from master widget if ltr and rtl both supported
              .ltr,
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset - 8) ?? 0;
        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          final subStringTrunc = widget.text.substring(0, endIndex);

          textSpan = _readMore
              ? TextSpan(
                  // text: widget.text.substring(0, endIndex),
                  style: TextStyle(
                      // color: widgetColor,
                      // color: VmodelColors.text,
                      ),
                  children: <InlineSpan>[
                    ...parseString(baseStyle, subStringTrunc),
                    link
                  ],
                )
              : TextSpan(
                  style: TextStyle(
                      // color: widgetColor,
                      // color: VmodelColors.text,
                      ),
                  children: <InlineSpan>[
                    ...parseString(baseStyle, widget.text),
                    link
                  ],
                );
          // textSpan = TextSpan(
          //   text: _readMore
          //       ? widget.text.substring(0, endIndex)
          //       : widget.text,
          //   style: TextStyle(
          //     color: widgetColor,
          //   ),
          //   children: <TextSpan>[link],
          // );
        } else {
          textSpan = TextSpan(
            text: '', // widget.text,
            // style: TextStyle(
            //   color: Colors.amber,
            // ),
            style: baseStyle,
            children: <InlineSpan>[...parseString(baseStyle, widget.text)],
          );
          // textSpan = text;
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );

    return result;
  }

  List<InlineSpan> parseString(TextStyle baseStyle, String rawString) {
    final myChildren = <InlineSpan>[
      TextSpan(
        text: "${widget.username} ",
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            widget.onUsernameTap();
            // navigateToRoute(
            //     context, OtherUserProfile(username: mentionedUsername));
          },
        style: baseStyle.copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ];
    final spaceOrNewlines = RegExp(r'[\s|\r|\n|\r\n]');
    final newLines = RegExp(r'([\r|\n|\r\n]+)');
    final charsBreakHashtag = RegExp(r'.*[\r|\n|\r\n]+[#|@]');
    // final tokens = rawString.split(re);
    // final tokens = rawString.split(RegExp(r'\s'));
    final tmp = rawString.split(' ');
    // final tokens = tmp;
    final tokens = [];

    //Hacky workaround. Loop through and separate out characters
    //and hastags/mentions separated by newlines
    for (String item in tmp) {
      if (item.startsWith(charsBreakHashtag)) {
        final split = item.split(spaceOrNewlines);
        final match = newLines.firstMatch(item);
        tokens.addAll([split.first, '${match?.group(0)}', '${split.last}']);
      } else
        tokens.add(item);
    }

    //Todo add formatting for tokens between **

    for (String token in tokens) {
      // if (token.startsWith('www.')) {
      //   myChildren.add(TextSpan(
      //       text: '$token ',
      //       style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)));
      // } else
      if (token.startsWith('@')) {
        final mentionedUsername = token.substring(1);
        myChildren.add(TextSpan(
          text: '$mentionedUsername ',
          // style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          // style: Theme.of(context).textTheme.displayLarge!.copyWith(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (mentionedUsername.isEmpty) {
                return;
              }
              widget.onMentionedUsernameTap(mentionedUsername);
              // navigateToRoute(
              //     context, OtherUserProfile(username: mentionedUsername));
            },
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: VmodelColors.text2,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
        ));
        continue;
      }
      if (token.startsWith("#") || token.startsWith("# ")) {
        final hashTag = token;
        myChildren.add(TextSpan(
          text: '$hashTag ',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              widget.onHashTag!(hashTag);
              // navigateToRoute(
              //     context, OtherUserProfile(username: mentionedUsername));
            },
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: VmodelColors.darkSecondaryButtonColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
        ));
      } else {
        myChildren.add(TextSpan(
          text: '$token ',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                // color: VmodelColors.text,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
        ));
      }
    }

    return myChildren;
  }
}
