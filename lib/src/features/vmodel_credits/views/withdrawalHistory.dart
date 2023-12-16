import 'package:flutter/material.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

import '../../../shared/buttons/normal_back_button.dart';

class WithdrawalHistoryPage extends StatefulWidget {
  const WithdrawalHistoryPage({super.key});

  @override
  State<WithdrawalHistoryPage> createState() => _WithdrawalHistoryPageState();
}

class _WithdrawalHistoryPageState extends State<WithdrawalHistoryPage> {
  List<VMCHistoryModel> _listCreditHistory = [
    VMCHistoryModel(action: "10% off next booking", creditEarned: "10,000"),
    VMCHistoryModel(
        action: "Featured Profile on VModel's Homepage",
        creditEarned: "20,000"),
    VMCHistoryModel(
        action: "10% Discount on Next 5 Bookings", creditEarned: "30,000"),
    VMCHistoryModel(action: "10% off next booking", creditEarned: "10,000"),
    VMCHistoryModel(
        action: "Featured Profile on VModel's Homepage",
        creditEarned: "20,000"),
    VMCHistoryModel(
        action: "10% Discount on Next 5 Bookings", creditEarned: "30,000"),
    VMCHistoryModel(action: "10% off next booking", creditEarned: "10,000"),
    VMCHistoryModel(
        action: "Featured Profile on VModel's Homepage",
        creditEarned: "20,000"),
    VMCHistoryModel(
        action: "10% Discount on Next 5 Bookings", creditEarned: "30,000"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: 'Withdraw points',
        elevation: 1,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reward",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "VMC Spent",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 50),
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _listCreditHistory[index].action!,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Text(
                              _listCreditHistory[index].creditEarned!,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if (_listCreditHistory.last ==
                          _listCreditHistory[index]) ...[
                        Column(
                          children: [
                            addVerticalSpacing(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Points spent",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  "2000",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            addVerticalSpacing(30),
                          ],
                        ),
                      ]
                    ],
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: _listCreditHistory.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VMCHistoryModel {
  String? action;
  String? creditEarned;

  VMCHistoryModel({
    this.action,
    this.creditEarned,
  });
}
