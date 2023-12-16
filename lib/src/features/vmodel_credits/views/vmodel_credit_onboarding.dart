import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vmodel/src/features/refer_and_earn/widgets/action_button.dart';
import 'package:vmodel/src/res/gap.dart';


class VModelCreditsOnboarding extends StatelessWidget {
  const VModelCreditsOnboarding({required this.pageIndex, super.key});

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
            Text('Earn and \nRedeem\nYour\nVModel\nCredits',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      height: 1.8,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    )),
            addVerticalSpacing(35),
            Text(
              'Earn Exciting Rewards for Every Referral.',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            addVerticalSpacing(55),
            SizedBox(
              width: 150,
              child: ReferAndEarnActionButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
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
