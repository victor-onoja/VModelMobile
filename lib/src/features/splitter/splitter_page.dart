import 'package:flutter/material.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/normal_back_button.dart';

class SplitterPage extends StatefulWidget {
  const SplitterPage({super.key});

  @override
  State<SplitterPage> createState() => _SplitterPageState();
}

class _SplitterPageState extends State<SplitterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Splitter",
      ),
      body: Center(child: Text("Coming soon...")),
    );
  }
}
