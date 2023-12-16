import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../res/gap.dart';
import '../../../../../refer_and_earn/widgets/action_button.dart';

class BlueTickOnboarding extends StatelessWidget {
  const BlueTickOnboarding({required this.pageIndex, super.key});

  final ValueNotifier<int> pageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            addVerticalSpacing(MediaQuery.of(context).size.height * 0.15),
            Text('Verified:\nElevate,\nYour\nPresence\nwith the\nBlue Tick!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    height: 1.8,
                    fontWeight: FontWeight.bold)),
            addVerticalSpacing(35),
            Text('Establish Trust and Credibility with your Clients!',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).primaryColor)),
            addVerticalSpacing(55),
            SizedBox(
              width: 150,
              child: ReferAndEarnActionButton(
                  onPressed: () { HapticFeedback.lightImpact();
                    pageIndex.value = 1;
                  },
                  title: 'Continue'),
            ),
          ],
        )),
      ),
    ));
  }
}
