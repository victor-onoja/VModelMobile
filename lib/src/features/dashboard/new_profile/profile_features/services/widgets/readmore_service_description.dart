import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../shared/html_description_widget.dart';

class DescriptionText extends StatefulWidget {
  const DescriptionText(
      // this.text,
      {
    Key? key,
    this.trimLines = 10,
    required this.readMore,
    required this.text,
  }) : super(key: key);

  final String text;
  final int trimLines;
  final VoidCallback readMore;

  @override
  State<DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  bool _readMore = true;

  void _onTapLink() {
    widget.readMore();
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

    // final widgetColor = Colors.black;
    TextSpan link = TextSpan(
        text: "...Read more",
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
              // color: colorClickableText,
            ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        final text = TextSpan(
          text: '${widget.text}',
          style: baseStyle.copyWith(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
          ),
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
        } else {
          textSpan = TextSpan(
            text: '',
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
    final myChildren = <InlineSpan>[];

    myChildren.add(WidgetSpan(child: HtmlDescription(content: rawString)));

    return myChildren;
  }
}
