import 'package:flutter/material.dart';
import 'package:vmodel/src/features/vmodel_credits/views/creditHistoryPage.dart';
import 'package:vmodel/src/features/vmodel_credits/views/vmc_notifications.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

import '../../../shared/buttons/normal_back_button.dart';

class NotificationMain extends StatefulWidget {
  static const route = '/notification-screen';
  const NotificationMain({super.key});

  @override
  State<NotificationMain> createState() => _NotificationMainState();
}

class _NotificationMainState extends State<NotificationMain> {
  final _pageController = PageController();

  bool _sliderLeft = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () => _pageController.animateToPage(0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut),
                child: Text(
                  "Notification",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context)
                            .primaryColor
                            .withOpacity(_sliderLeft ? 1 : .5),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: GestureDetector(
                  onTap: () => _pageController.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  child: Text(
                    "VMC history",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(_sliderLeft ? .5 : 1),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: PageView.builder(
              itemCount: 2,
              controller: _pageController,
              onPageChanged: (index) {
                if (index == 0) {
                  _sliderLeft = true;

                  if (mounted) setState(() {});
                } else {
                  _sliderLeft = false;

                  if (mounted) setState(() {});
                }
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return VMCNotifications();
                  // return Container(
                  //   color: Colors.purple,
                  // );
                } else {
                  return CreditHistoryPage(
                    intabs: true,
                  );
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // if (_sliderLeft)
                Container(
                  color: _sliderLeft
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  height: 1,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                // if (!_sliderLeft)
                Container(
                  color: !_sliderLeft
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  height: 1,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
