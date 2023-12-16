import 'package:flutter/cupertino.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class NewPostPolaroidView extends StatelessWidget {
  final bool shouldHaveBackButton;
  NewPostPolaroidView({super.key, this.shouldHaveBackButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: shouldHaveBackButton,
        centerTitle: true,
        backgroundColor: VmodelColors.appBarBackgroundColor,
        shadowColor: VmodelColors.appBarShadowColor,
        elevation: 0,
        leading: shouldHaveBackButton == true
            ? const VWidgetsBackButton()
            : const Text(""),
        title: Padding(
          padding: const EdgeInsets.only(top: 17),
          child: Text(
            "New post",
            style: VModelTypography1.normalTextStyle.copyWith(
              color: VmodelColors.primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: vWidgetsInitialButton(() {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoActionSheet(
                  cancelButton: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      height: 45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cancel',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ...category.map((e) {
                      return actionWidget(context, e);
                    }),
                  ],
                ),
              ),
            );
          }, "Create a new post"),
        )
      ]),
    );
  }

  final List<String> category = ["Camera", "Gallery", "Polaroid"];

  actionWidget(BuildContext context, String categoryItem) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        color: VmodelColors.white,
        height: 45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              categoryItem,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
