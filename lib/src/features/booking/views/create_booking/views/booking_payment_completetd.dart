import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class PaymentCompletedView extends StatefulWidget {
  const PaymentCompletedView({Key? key}) : super(key: key);

  @override
  State<PaymentCompletedView> createState() => _PaymentCompletedViewState();
}

class _PaymentCompletedViewState extends State<PaymentCompletedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            VmodelAssets1.paymentBackground,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Congratulations!",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: VmodelColors.appBarBackgroundColor),
                    ),
                    addVerticalSpacing(20),
                    Text(
                      "Your booking with Sarah Tierney is \nscheduled for Sunday, September 4, \n14:00",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.appBarBackgroundColor),
                    ),
                    addVerticalSpacing(40),
                    GestureDetector(
                      onTap: () {
                        goBack(context);
                      },
                      child: Container(
                        height: 40,
                        width: 117,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: VmodelColors.appBarBackgroundColor,
                        ),
                        child: Center(
                          child: Text(
                            "Done",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: VmodelColors.greyDeepText),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
