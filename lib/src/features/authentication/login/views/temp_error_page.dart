import '../../../../vmodel.dart';

class TempErrorPage extends StatelessWidget {
  const TempErrorPage({Key? key, required this.fullErrorMessage, required this.stackTrace})
      : super(key: key);
  final String fullErrorMessage;
  final String stackTrace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              RichText(
                softWrap: true,
                overflow: TextOverflow.clip,
                text: _parseString(fullErrorMessage),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextSpan _parseString(String rawString) {
    final myChildren = <InlineSpan>[];
    final parent = TextSpan(
      children: myChildren,
    );
    final tokens = rawString.split('\n');

    List<Color> colors = [
      Colors.redAccent,
      Colors.black,
      Colors.tealAccent,
      Colors.blue,
      Colors.pink,
      Colors.green,
      Colors.deepPurple,
    ];

    for (int i = 0; i < tokens.length; i++) {
      myChildren.add(TextSpan(
          text: '${tokens[i]} \n $i) ===================================\n',
          style: TextStyle(color: colors[i] )));
    }
    myChildren.add(TextSpan(
        text: '$stackTrace\n  ============= Stack Trace======================\n',
        style: const TextStyle(color: Colors.black)));

    return parent;
  }
}
