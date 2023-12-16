import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/res.dart';
import '../../../../shared/username_verification.dart';

class CommentMessage extends StatefulWidget {
  const CommentMessage(
      // this.text,
      {
    Key? key,
    this.trimLines = 2,
    required this.username,
    required this.onUsernameTap,
    required this.onMentionedUsernameTap,
    // required this.isVerified,
    this.isVerified = false,
    // required this.blueTickVerified,
    this.blueTickVerified = false,
    this.isMessageCollapsed,
    required this.text,
  }) : super(key: key);

  final bool isVerified;
  final bool blueTickVerified;
  final String text;
  final String username;
  final int trimLines;
  final VoidCallback onUsernameTap;
  final ValueChanged<String> onMentionedUsernameTap;
  final ValueChanged<bool>? isMessageCollapsed;

  @override
  State<CommentMessage> createState() => _CommentMessageState();
}

class _CommentMessageState extends State<CommentMessage> {
  bool _readMore = true;

  void _onTapLink() {
    _readMore = !_readMore;

    // _readMore is false when message is expanded
    widget.isMessageCollapsed?.call(_readMore);
    setState(() {});
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
                    ...parseString(baseStyle, subStringTrunc, widget.isVerified,
                        widget.blueTickVerified),
                    link
                  ],
                )
              : TextSpan(
                  style: TextStyle(
                      // color: widgetColor,
                      // color: VmodelColors.text,
                      ),
                  children: <InlineSpan>[
                    ...parseString(baseStyle, widget.text, widget.isVerified,
                        widget.blueTickVerified),
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
            children: <InlineSpan>[
              ...parseString(baseStyle, widget.text, widget.isVerified,
                  widget.blueTickVerified),
            ],
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

  List<InlineSpan> parseString(TextStyle baseStyle, String rawString,
      bool isVerified, bool blueTickVerified) {
    final myChildren = <InlineSpan>[
      WidgetSpan(
        child: GestureDetector(
          onTap: () {
            print('oss1 tapped');
            widget.onUsernameTap();
          },
          child: VerifiedUsernameWidget(
            rowMainAxisSize: MainAxisSize.min,
            // iconSize: 8,
            spaceSeparatorWidth: 2,
            username: '${widget.username}',
            // displayName:
            //     "${widget.commentModel.parent!.user?.displayN}",
            textStyle: baseStyle.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
            isVerified: isVerified,
            blueTickVerified: blueTickVerified,
          ),
        ),
      ),
      WidgetSpan(child: addHorizontalSpacing(4)),
      // TextSpan(
      //   text: "${widget.username} ",
      //   recognizer: TapGestureRecognizer()
      //     ..onTap = () {
      //       widget.onUsernameTap();
      //       // navigateToRoute(
      //       //     context, OtherUserProfile(username: mentionedUsername));
      //     },
      //   style: baseStyle.copyWith(
      //     fontSize: 10.sp,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),
    ];
    final tokens = rawString.split(' ');

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
