import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/utils/shared.dart';
import '../../../res/colors.dart';
import '../../../shared/appbar/appbar.dart';

class BetaDashBoardWeb extends StatefulWidget {
  const BetaDashBoardWeb({super.key, required this.title, required this.url});

  final String title, url;

  @override
  State<BetaDashBoardWeb> createState() => _BetaDashBoardWebState();
}

class _BetaDashBoardWebState extends State<BetaDashBoardWeb> {
  late final WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: VWidgetsAppBar(
        appBarHeight: 50,
        backgroundColor: VmodelColors.appBarBackgroundColor,
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: widget.title,
      ),
      body: Column(
        children: [
          Expanded(
              child: WebViewWidget(
            controller: _controller,
          ))
        ],
      ),
    );
  }
}
