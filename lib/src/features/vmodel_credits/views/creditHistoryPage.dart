import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/vmodel_credits/views/creditWithdrawalPage.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

import '../controller/vmc_controller.dart';
import '../../../core/utils/debounce.dart';

class CreditHistoryPage extends ConsumerStatefulWidget {
  const CreditHistoryPage({super.key, required this.intabs});
  final bool intabs;

  @override
  ConsumerState<CreditHistoryPage> createState() => _CreditHistoryPageState();
}

class _CreditHistoryPageState extends ConsumerState<CreditHistoryPage> {
  // List<VMCHistoryModel> _listCreditHistory = [];
  final _pageController = PageController();
  final _scrollController = ScrollController();
  final _debounce = Debounce();
  bool _isRefresh = false;
  final _loadingMore = ValueNotifier(false);

  @override
  void initState() {
    _scrollController.addListener(loadMoreCallback);
    // _listCreditHistory = [
    //   VMCHistoryModel(action: "Account Created", creditEarned: "50"),
    //   VMCHistoryModel(action: "Booking Confirmed", creditEarned: "100"),
    //   VMCHistoryModel(action: "Account Created", creditEarned: "500"),
    //   VMCHistoryModel(action: "Posting original content", creditEarned: "5"),
    //   VMCHistoryModel(
    //       action: "Getting Likes on Your Content", creditEarned: "5"),
    //   VMCHistoryModel(
    //       action: "Sharing Content from Others	",
    //       creditEarned:
    //           widget.vmcRecordModel!.vmcrecord!.shareContent.toString()),
    //   VMCHistoryModel(
    //       action: "Booking Multiple Gigs in a Month	", creditEarned: "5"),
    //   VMCHistoryModel(
    //       action: "Referring a Friend to VModel",
    //       creditEarned:
    //           widget.vmcRecordModel!.vmcrecord!.referAFriend.toString()),
    //   VMCHistoryModel(
    //       action: "Receiving Positive Reviews",
    //       creditEarned: widget.vmcRecordModel!.vmcrecord!.receivePositiveReviews
    //           .toString()),
    // ];
    super.initState();
  }

  _onRefresh() async {
    setState(() {
      _isRefresh = true;
    });
    await ref.refresh(vmcRecordProvider.future);
    setState(() {
      _isRefresh = false;
    });
  }

  void loadMoreCallback() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final delta = SizerUtil.height * 0.2;
    if (maxScroll - currentScroll <= delta) {
      print('Scroll listender fetching more items [[55]]');
      _debounce(() async {
        _loadingMore.value = true;
        await ref.read(vmcRecordProvider.notifier).fetchMoreHandler();
        _loadingMore.value = false;
      });
    }
  }

  @override
  dispose() {
    _scrollController.removeListener(loadMoreCallback);
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.intabs
          ? null
          : VWidgetsAppBar(
              leadingIcon: VWidgetsBackButton(),
              appbarTitle: "VMC Histroy",
              elevation: 0,
              trailingIcon: [
                // IconButton(
                //     onPressed: () => Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (builder) => VMCLeaderboard())),
                //     icon: Icon(
                //       Icons.leaderboard,
                //       color: Theme.of(context).iconTheme.color,
                //     ))
              ],
            ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Action",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          // fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "VMC Earned",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          // fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            ref.watch(vmcRecordProvider).when(data: (actions) {
              if (actions == null) {
                return Center(child: Text("Data is null"));
              }
              if (actions.isEmpty) {
                return Center(
                    child: Text("No VMC history, engage to earn credits"));
              }
              return Container(
                  margin: EdgeInsets.only(top: 30, bottom: 50),
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    children: [
                      Expanded(
                          child: RefreshIndicator.adaptive(
                        // notificationPredicate: (notification) {
                        //   print(notification.metrics.pixels <= -120);
                        //   return false;
                        // },
                        onRefresh: () async {
                          HapticFeedback.lightImpact();
                          _onRefresh();
                        },
                        child: ListView.separated(
                          controller: _scrollController,
                          itemCount: actions.length + 1,
                          shrinkWrap: true,
                          physics: _isRefresh
                              ? NeverScrollableScrollPhysics()
                              : BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            if (index == actions.length) {
                              return ValueListenableBuilder(
                                  valueListenable: _loadingMore,
                                  builder: ((context, value, child) {
                                    if (value) {
                                      //Scroll to the end for loading indicator
                                      // to be visible
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        _scrollController.jumpTo(
                                            _scrollController
                                                .position.maxScrollExtent);
                                      });
                                    }
                                    return value
                                        ? Center(
                                            child: Container(
                                            width: 30,
                                            height: 30,
                                            padding: EdgeInsets.all(4),
                                            child: CircularProgressIndicator
                                                .adaptive(strokeWidth: 2),
                                          ))
                                        : SizedBox.shrink();
                                  }));
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      actions[index].action,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                            fontSize: 14,
                                            color:
                                                actions[index].pointsEarned < 0
                                                    ? Colors.red
                                                    : null,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  addHorizontalSpacing(24),
                                  Text(
                                    actions[index].pointsEarned.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                          fontSize: 14,
                                          color: actions[index].pointsEarned < 0
                                              ? Colors.red
                                              : null,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )),
                      addVerticalSpacing(16),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Points Earned",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    // fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              // "${widget.vmcRecordModel!.vmcrecord!.totalVmcPoints}",
                              ref.watch(vmcTotalProvider).toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    // fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
            }, error: ((error, stackTrace) {
              return Center(child: Text("Error occurred"));
            }), loading: () {
              return Center(child: CircularProgressIndicator.adaptive());
            }),
            Align(
              alignment: Alignment.bottomCenter,
              child: VWidgetsPrimaryButton(
                onPressed: () =>
                    navigateToRoute(context, CreditWithdrawalPage()),
                buttonTitle: "Withdraw",
                butttonWidth: 90.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget oldBody() {
// return Column(
//   children: [
//     Padding(
//       padding:
//           const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         mainAxisAlignment:
//             MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             _listCreditHistory[index].action!,
//             style: Theme.of(context)
//                 .textTheme
//                 .displayMedium
//                 ?.copyWith(
//                   fontSize: 12,
//                   fontWeight: FontWeight.normal,
//                 ),
//           ),
//           Text(
//             _listCreditHistory[index].creditEarned!,
//             style: Theme.of(context)
//                 .textTheme
//                 .displayMedium
//                 ?.copyWith(
//                   fontSize: 12,
//                   fontWeight: FontWeight.normal,
//                 ),
//           ),
//         ],
//       ),
//     ),
//     if (_listCreditHistory.last ==
//         _listCreditHistory[index]) ...[
//       Column(
//         children: [
//           addVerticalSpacing(30),
//           Row(
//             mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Total Points Earned",
//                 style: Theme.of(context)
//                     .textTheme
//                     .displayMedium
//                     ?.copyWith(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//               Text(
//                 // "${widget.vmcRecordModel!.vmcrecord!.totalVmcPoints}",
//                 "lsjsjls",
//                 style: Theme.of(context)
//                     .textTheme
//                     .displayMedium
//                     ?.copyWith(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//             ],
//           ),
//           addVerticalSpacing(30),
//         ],
//       ),
//     ]
//   ],
// );
// }

class VMCHistoryModel {
  String? action;
  String? creditEarned;

  VMCHistoryModel({
    this.action,
    this.creditEarned,
  });
}
