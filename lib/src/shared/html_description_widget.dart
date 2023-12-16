import 'package:flutter_html/flutter_html.dart';
import 'package:vmodel/src/vmodel.dart';

import '../res/res.dart';

class HtmlDescription extends StatelessWidget {
  const HtmlDescription({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: parseString(context, TextStyle(), content),
      onlyRenderTheseTags: const {'em', 'b', 'br', 'html', 'head', 'body'},
      style: {
        "*": Style(color: Theme.of(context).primaryColor),
      },
    );
  }

  String parseString(
      BuildContext context, TextStyle baseStyle, String rawString) {
    final myChildren = <InlineSpan>[];
    final tokens = rawString.split(' ');
    const String boldPattern = r'\*\*([^*]+)\*\*';
    final RegExp linkRegExp = RegExp(boldPattern, caseSensitive: false);
    final RegExp italicRegExp = RegExp(r'\*([^*]+)\*', caseSensitive: false);
    final RegExp listRegExp = RegExp(
      r'^(\s*\-)(\s.+)$',
      caseSensitive: false,
      multiLine: true,
    );

    //Todo add formatting for tokens between **
    String newString = rawString.replaceAllMapped(linkRegExp, (match) {
      return '<b>${match.group(1)}</b>';
      // }).replaceAll(RegExp(r"(\r\n|\r|\n)"), '<br>');
    }).replaceAll(RegExp(r"(\r\n|\r|\n)", multiLine: true), '<br>\n');

    newString = newString.replaceAllMapped(italicRegExp, (match) {
      return '<em>${match.group(1)}</em>';
    });

    newString = newString.replaceAllMapped(listRegExp, (match) {
      print('[@@oso] Found a match');
      // return '<ul><li> ${match.group(2)} ${match.group(3)} </li></ul>';
      return '${VMString.bullet} ${match.group(2)}';
    });

    final htmlDocBoilerplate = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
  </head>
  <body>
  $newString
  </body>
</html>
""";
    return htmlDocBoilerplate;
  }
}
