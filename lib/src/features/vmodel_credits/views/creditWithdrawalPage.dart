import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/vmodel_credits/widgets/counter_animation.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../shared/buttons/primary_button.dart';
import '../controller/vmc_controller.dart';

class CreditWithdrawalPage extends ConsumerStatefulWidget {
  const CreditWithdrawalPage({super.key});

  @override
  ConsumerState<CreditWithdrawalPage> createState() =>
      _CreditWithdrawalPageState();
}

class _CreditWithdrawalPageState extends ConsumerState<CreditWithdrawalPage> {
  final referCodeCopied = ValueNotifier<bool>(false);
  final referCode = 1050;

  List<String> _dropdownList = [
    "10% off booking",
    "10% off 5 bookings",
    "Featured locally (7 days)",
  ];

  List<String> _rewardPoints = [
    "10k",
    "40k",
    "100k",
  ];
  String selectedValue = "";

  @override
  void initState() {
    super.initState();
    selectedValue = _dropdownList[0];
  }

  @override
  Widget build(BuildContext context) {
    final credits = ref.watch(vmcTotalProvider);
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: VWidgetsAppBar(
          leadingIcon: const VWidgetsBackButton(),
          // appbarTitle: 'Withdraw points',
          appbarTitle: 'Withdrawal (VMC)',
          elevation: 1,
          // trailingIcon: [
          //   Padding(
          //     padding: const EdgeInsets.all(10),
          //     child: IconButton(
          //       onPressed: () =>
          //           navigateToRoute(context, WithdrawalHistoryPage()),
          //       icon: Icon(
          //         Icons.history,
          //         color: Theme.of(context).primaryColor,
          //       ),
          //     ),
          //   )
          // ],
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
                        spreadRadius: 1, //extend the shadow
                        offset: const Offset(0.0, 0.0),
                      ),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  CounterAnimationText(
                                    begin: 0,
                                    end: credits,
                                    durationInMilliseconds: 700,
                                    curve: Curves.fastEaseInToSlowEaseOut,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                  addHorizontalSpacing(5),
                                  Text(
                                    'VMC',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              if (value) const Text('copied!')
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                addVerticalSpacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reward",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    Text(
                      "Price (VMC)",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ],
                ),
                addVerticalSpacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VWidgetsDropDownTextField(
                      isOneLineEllipsize: true,
                      isIncreaseHeightForErrorText: false,
                      // fieldLabel: 'Size)',
                      isExpanded: true,
                      hintText: '',
                      value: selectedValue,
                      onChanged: (val) {
                        setState(() {
                          selectedValue = val;
                        });
                      },

                      minWidth: 60.w,
                      // options: widget.options,
                      options: _dropdownList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        _rewardPoints[_dropdownList.indexOf(selectedValue)],
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: addVerticalSpacing(32)),
                VWidgetsPrimaryButton(
                  onPressed: () {},
                  buttonTitle: "Withdraw",
                  butttonWidth: 90.w,
                ),
                addVerticalSpacing(32),
              ],
            ),
          ),
        ));
  }
}
