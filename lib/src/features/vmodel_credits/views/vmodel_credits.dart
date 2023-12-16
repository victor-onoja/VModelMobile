import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/vmodel_credits/controller/vmc_controller.dart';
import 'package:vmodel/src/features/vmodel_credits/views/creditHistoryPage.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/controller/app_user_controller.dart';
import '../../../shared/appbar/appbar.dart';
import '../../settings/widgets/settings_submenu_tile_widget.dart';
import '../../tutorials/models/tutorial_mock.dart';
import '../widgets/counter_animation.dart';
import 'vmodel_credit_onboarding.dart';

class UserVModelCreditHomepage extends ConsumerStatefulWidget {
  const UserVModelCreditHomepage({super.key});
  static const routeName = 'vmc';

  @override
  ConsumerState<UserVModelCreditHomepage> createState() =>
      _UserVModelCreditHomepageState();
}

class _UserVModelCreditHomepageState
    extends ConsumerState<UserVModelCreditHomepage> {
  final referCodeCopied = ValueNotifier<bool>(false);
  final referCode = 1050;
  final pageIndex = ValueNotifier<int>(0);
  late final faqs;

  @override
  void initState() {
    super.initState();

    faqs = HelpSupportModel.vmodelCredits();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(appUserProvider);
    final user = userState.valueOrNull;
    final vmc = ref.watch(vmcRecordProvider);
    return ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, value, child) {
          if (value == 0) {
            return VModelCreditsOnboarding(pageIndex: pageIndex);
          }

          return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: VWidgetsAppBar(
                leadingIcon: const VWidgetsBackButton(),
                appbarTitle: 'VModel Credits',
              ),
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpacing(25),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.07),
                              blurRadius: 5.0, // soften the shadow
                              spreadRadius: -3, //extend the shadow
                              offset: const Offset(0.0, 0.0),
                            )
                          ],
                        ),
                        child: GestureDetector(
                          onTap: vmc.value != null
                              ? () => navigateToRoute(
                                  context,
                                  CreditHistoryPage(
                                    // vmcRecordModel: vmc.value,
                                    intabs: false,
                                  ))
                              : null,
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
                                          vmc.when(
                                            data: (data) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.baseline,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  CounterAnimationText(
                                                    begin: 0,
                                                    end: ref.watch(
                                                        vmcTotalProvider),
                                                    durationInMilliseconds: 700,
                                                    curve: Curves
                                                        .fastEaseInToSlowEaseOut,
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .headlineLarge!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                  ),
                                                  // Text(
                                                  //   '$referCode',
                                                  //   style: Theme.of(context)
                                                  //       .textTheme
                                                  //       .headlineLarge!
                                                  //       .copyWith(
                                                  //         fontWeight: FontWeight.bold,
                                                  //       ),
                                                  // ),
                                                  addHorizontalSpacing(5),
                                                  Text(
                                                    'VMC',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              );
                                            },
                                            error: (error, stacktrace) {
                                              return Center(
                                                child: Text(error.toString()),
                                              );
                                            },
                                            loading: () => SizedBox(
                                              height: 17,
                                              width: 17,
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Theme.of(context)
                                                            .primaryColor),
                                              ),
                                            ),
                                          ),
                                          if (value) const Text('copied!')
                                        ],
                                      ),
                                    );
                                  })),
                        ),
                      ),
                      addVerticalSpacing(16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 18,
                              right: 18,
                            ),
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: faqs.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                // return popularFAQs[index];

                                return VWidgetsSettingsSubMenuTileWidget(
                                    title: faqs[index].title!,
                                    onTap: () {
                                      var ss = faqs[index];
                                      // navigateToRoute(
                                      //     context,
                                      //     HelpDetailsViewTwo(
                                      //       tutorialDetailsTitle: ss.title,
                                      //       tutorialDetailsDescription: ss.body,
                                      //     ));
                                    });
                              }),
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
