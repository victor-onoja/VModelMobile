import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:vmodel/src/features/refer_and_earn/widgets/action_button.dart';
import 'package:vmodel/src/res/gap.dart';

import '../../../core/utils/shared.dart';
import '../../../shared/appbar/appbar.dart';
import '../widgets/reward_card.dart';

class ReferAndEarnInviteContactPage extends StatelessWidget {
  final Contact contact;
  const ReferAndEarnInviteContactPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(),
          appbarTitle: 'Invite contact',
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Text(contact.displayName ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 26)),
              addVerticalSpacing(20),
              ReferAndEarnActionButton(
                  onPressed: () {}, title: 'Invite contact'),
              addVerticalSpacing(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('How Rewards work',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text('More options',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: RewardsInfoCard(
                      titleText: 'Free Cash Rewards:',
                      subtitleText:
                          'Get £10 for every new friend who completes their first job!',
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
