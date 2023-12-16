import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vmodel/src/features/refer_and_earn/views/invite_contacts.dart';
import 'package:vmodel/src/features/refer_and_earn/views/onboarding.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../res/icons.dart';
import '../../../res/strings.dart';
import '../../../shared/appbar/appbar.dart';
import '../../../shared/rend_paint/render_svg.dart';
import '../widgets/action_button.dart';
import '../widgets/reward_card.dart';

class ReferAndEarnHomepage extends StatefulWidget {
  const ReferAndEarnHomepage({super.key});
  static const routeName = 'inviteAndEarn';

  @override
  State<ReferAndEarnHomepage> createState() => _ReferAndEarnHomepageState();
}

class _ReferAndEarnHomepageState extends State<ReferAndEarnHomepage> {
  final referCodeCopied = ValueNotifier<bool>(false);
  final referCode = 'VMD-RZY5';
  final pageIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, value, child) {
          if (value == 0) {
            return ReferAndEarnOnboarding(pageIndex: pageIndex);
          }
          return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: const VWidgetsAppBar(
                leadingIcon: VWidgetsBackButton(),
                appbarTitle: "Invite & Earn",
                elevation: 0,
              ),
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpacing(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Your invite code',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                          GestureDetector(
                              onTap: () async {
                                await Clipboard.setData(
                                    ClipboardData(text: referCode));
                                referCodeCopied.value = true;

                                Future.delayed(const Duration(seconds: 2),
                                    () => referCodeCopied.value = false);
                              },
                              child: SvgPicture.asset(
                                VIcons.copyUrlIcon,
                                color: Theme.of(context).iconTheme.color,
                              ))
                          // IconButton(
                          //     onPressed: () async {
                          //       await Clipboard.setData(
                          //           ClipboardData(text: referCode));
                          //       referCodeCopied.value = true;

                          //       Future.delayed(const Duration(seconds: 2),
                          //           () => referCodeCopied.value = false);
                          //     },
                          //     icon: const Icon(Icons.copy))
                        ],
                      ),
                      addVerticalSpacing(10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            // CustomBoxShadow(
                            //     color: Colors.grey.withOpacity(.5),
                            //     offset: Offset(5.0, 5.0),
                            //     blurRadius: 5.0,
                            //     blurStyle: BlurStyle.outer)
                            BoxShadow(
                              color: Colors.black.withOpacity(.07),
                              blurRadius: 5.0, // soften the shadow
                              spreadRadius: -3, //extend the shadow
                              offset: const Offset(0.0, 0.0),
                            )
                            // BoxShadow(
                            //   color: Colors.black.withOpacity(.07),
                            //   blurRadius: 10.0, // soften the shadow
                            //   spreadRadius: 5.0, //extend the shadow
                            //   offset: const Offset(
                            //     2.0, // Move to right 10  horizontally
                            //     5.0, // Move to bottom 10 Vertically
                            //   ),
                            // )
                          ],
                        ),
                        child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: ValueListenableBuilder(
                                valueListenable: referCodeCopied,
                                builder: (context, value, child) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 20),
                                    child: Column(
                                      children: [
                                        Text(referCode,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )),
                                        Text(
                                          'copied!',
                                          style: TextStyle(
                                              color: value
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.transparent),
                                        )
                                      ],
                                    ),
                                  );
                                })),
                      ),
                      addVerticalSpacing(35),
                      Text('More options',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                      addVerticalSpacing(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ReferAndEarnActionButton(
                                title: 'Share link', onPressed: () {}),
                          ),
                          addHorizontalSpacing(40),
                          Expanded(
                            child: ReferAndEarnActionButton(
                                title: 'Invite contacts',
                                onPressed: () {
                                  navigateToRoute(context,
                                      const ReferAndEarnInviteContactsPage());
                                }),
                          ),
                        ],
                      ),

                      addVerticalSpacing(20),
                      // Text('How Rewards work',
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .titleLarge!
                      //         .copyWith(fontWeight: FontWeight.bold)),
                      addVerticalSpacing(15),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            RewardsInfoCard(
                              leadingSvgAsset: RenderSvgWithoutColor(
                                svgPath: VIcons.discordLogo,
                                svgHeight: 50,
                                svgWidth: 50,
                              ),
                              titleText: 'Invite via discord:',
                              subtitleText:
                                  'Unlock Rewards by Sharing VModel with Friends',
                              onCopyPressed: () => copyTextToClipboard(
                                  VMString.vmodelDiscordPioneersUrl),
                              // 'Get £10 for every new friend who completes their first job!',
                            ),
                            RewardsInfoCard(
                              leadingSvgAsset: RenderSvg(
                                svgPath: VIcons.inviteAndEarnEmailIcon,
                                svgHeight: 50,
                                svgWidth: 50,
                                color: Theme.of(context).iconTheme.color,
                              ),

                              titleText: 'Invite via email:',
                              subtitleText:
                                  'Expand your network and earnings with email invitations!',
                              // 'Get £10 for every new friend who completes their first job!',
                            ),
                            RewardsInfoCard(
                              leadingSvgAsset: RenderSvg(
                                svgPath: VIcons.inviteViaQRCodeIcon,
                                svgHeight: 50,
                                svgWidth: 50,
                                color: Theme.of(context).iconTheme.color,
                              ),

                              titleText: 'Invite via QR code:',
                              subtitleText:
                                  'Effortless Networking and Earnings with QR Code Invitations',
                              // 'Get £10 for every new friend who completes their first job!',
                            ),
                          ],
                        ),
                      )

                      // Container(
                      //   // height: 65.h,
                      //   width: MediaQuery.of(context).size.width,
                      //   decoration: const BoxDecoration(
                      //       color: Color(0xFF503C3B),
                      //       borderRadius: BorderRadius.only(
                      //         bottomLeft: Radius.circular(40),
                      //         bottomRight: Radius.circular(40),
                      //       )),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 39.0),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         addVerticalSpacing(20),
                      //         Text(
                      //           "Refer your friends and earn",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .displayLarge!
                      //               .copyWith(
                      //                   color: VmodelColors.white,
                      //                   fontSize: 17.sp,
                      //                   fontWeight: FontWeight.w600),
                      //         ),
                      //         addVerticalSpacing(25),
                      //         RenderSvg(
                      //           svgPath: VIcons.surpriseIcon,
                      //           color: VmodelColors.white,
                      //           svgHeight: 150,
                      //           svgWidth: 150,
                      //         ),
                      //         addVerticalSpacing(20),
                      //         VWidgetsBulletPointTextWithButton(
                      //             text:
                      //                 "Get £10 for every new friend who completes their first job!",
                      //             onTapMore: () {}),
                      //         VWidgetsBulletPointTextWithButton(
                      //             text:
                      //                 "You will also be rewarded with 500 VModelCore Points.",
                      //             onTapMore: () {}),
                      //         VWidgetsBulletPointTextWithButton(
                      //             text:
                      //                 "Use your VMC Points to unlock exclusive items like coupons, discounts, full mystery boxes containing rewards such as a Pro account for 1 year, 0% fee for 5 jobs, blue tick verification, and more!",
                      //             onTapMore: () {}),
                      //         addVerticalSpacing(25),
                      //         VWidgetsReferAndEarnCodeField(
                      //             generatedCode: "VMD-RZY5", onTapCopyCode: () {}),
                      //         addVerticalSpacing(40),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // addVerticalSpacing(5),
                      // Text(
                      //   "or",
                      //   style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      //       color: VmodelColors.primaryColor,
                      //       fontWeight: FontWeight.w600),
                      // ),
                      // addVerticalSpacing(15),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         "Share via",
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .displayLarge!
                      //             .copyWith(
                      //                 color: VmodelColors.primaryColor,
                      //                 fontWeight: FontWeight.w600),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // addVerticalSpacing(10),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   padding: const EdgeInsets.symmetric(horizontal: 8),
                      //   reverse: false,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       ShareToAccountsWidget(
                      //         onTap: () {},
                      //         size: 60,
                      //         svgPath: VIcons.twitterCircle,
                      //       ),
                      //       ShareToAccountsWidget(
                      //         onTap: () {},
                      //         size: 60,
                      //         svgPath: VIcons.facebookCircle,
                      //       ),
                      //       ShareToAccountsWidget(
                      //         onTap: () {},
                      //         size: 60,
                      //         svgPath: VIcons.whatsAppCircle,
                      //       ),
                      //       ShareToAccountsWidget(
                      //         onTap: () {},
                      //         size: 60,
                      //         svgPath: VIcons.mailIconCircle,
                      //       ),
                      //       ShareToAccountsWidget(
                      //         onTap: () {},
                      //         size: 60,
                      //         svgPath: VIcons.messageBubbles,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // addVerticalSpacing(25),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      //   child: SizedBox(
                      //     height: 50,
                      //     child: TextField(
                      //       textAlign: TextAlign.center,
                      //       style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      //             color: VmodelColors.primaryColor,
                      //             fontSize: 15.sp,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //       decoration: InputDecoration(
                      //         // border: OutlineInputBorder(
                      //         //   borderRadius: BorderRadius.circular(10.0),

                      //         // ),
                      //         isCollapsed: true,
                      //         contentPadding:
                      //             const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      //         filled: true,
                      //         fillColor: const Color(0xFFD9D9D9).withOpacity(0.5),
                      //         hintText: "jennifer@vmodel.app",
                      //         hintStyle: Theme.of(context)
                      //             .textTheme
                      //             .displayLarge!
                      //             .copyWith(
                      //               color: VmodelColors.primaryColor.withOpacity(0.3),
                      //               fontSize: 15.sp,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //         enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: const Color(0xFFD9D9D9).withOpacity(0),
                      //             ),
                      //             borderRadius:
                      //                 const BorderRadius.all(Radius.circular(8))),
                      //         focusedBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: const Color(0xFFD9D9D9).withOpacity(0),
                      //             ),
                      //             borderRadius:
                      //                 const BorderRadius.all(Radius.circular(8))),
                      //         disabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: const Color(0xFFD9D9D9).withOpacity(0),
                      //             ),
                      //             borderRadius:
                      //                 const BorderRadius.all(Radius.circular(8))),
                      //         border: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: const Color(0xFFD9D9D9).withOpacity(0),
                      //             ),
                      //             borderRadius:
                      //                 const BorderRadius.all(Radius.circular(8))),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // addVerticalSpacing(60),
                    ],
                  ),
                ),
              ));
        });
  }
}
