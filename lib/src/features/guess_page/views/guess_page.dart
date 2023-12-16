import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/features/guess_page/views/leadership_boards.dart';
import 'package:vmodel/src/res/res.dart';

import '../../../shared/buttons/normal_back_button.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key});

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {
  List options = [
    "MM6",
    "THE ATTICO",
    "AVAVAV",
    "TOM FORD",
  ];

  bool _start = false;
  int _index = -1;

  int _seconds = 60;
  late Timer _timer;

  void startCountdown() {
    const oneSecond = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      if (_seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LinearGradient myGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Theme.of(context).colorScheme.primary, Colors.white],
      stops: [0.0, 1.0],
    );
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: myGradient),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VWidgetsBackButton(
                    buttonColor: Theme.of(context).scaffoldBackgroundColor),
                // addHorizontalSpacing(23),
                Row(
                  children: [
                    for (var index = 0; index < 10; index++)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: VmodelColors.greyColor),
                        ),
                      ),
                  ],
                ),
                addHorizontalSpacing(25),
                SizedBox()
              ],
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Container(
                  height: SizerUtil.height * .5,
                  width: SizerUtil.width * .7,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/bg_signup/bg5.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            addVerticalSpacing(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // startCountdown();
                    // _start = true;
                    // setState(() {});
                  },
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: Duration(minutes: 1),
                    height: 30,
                    width: _start ? 1 : SizerUtil.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: _start
                          ? Colors.red
                          : Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      _seconds == 60 ? "01:00" : "00:$_seconds",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpacing(20),
            SizedBox(
              height: SizerUtil.height * .20,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 55,
                ),
                child: GridView.builder(
                    itemCount: options.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.8,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = index;
                          });
                        },
                        child: Card(
                          elevation: 5,
                          color: index == _index ? Colors.green : null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              options[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    color:
                                        index == _index ? Colors.white : null,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            addVerticalSpacing(20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Highest score by: ",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  ProfilePicture(
                      size: 30,
                      url: VMString.testImageUrl,
                      headshotThumbnail: VMString.testImageUrl),
                  Text(
                    " Jane Doe",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
            addVerticalSpacing(25),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => navigateToRoute(context, LeadershipBoards()),
                child: Text(
                  "View leaderboards",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.6),
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
