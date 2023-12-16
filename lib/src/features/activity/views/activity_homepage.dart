import 'package:flutter/material.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

class ActivityHomepage extends StatelessWidget {
  const ActivityHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Activity",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
