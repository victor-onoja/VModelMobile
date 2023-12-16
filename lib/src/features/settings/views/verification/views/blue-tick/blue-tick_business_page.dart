import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/blue-tick_homepage.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/blue-tick_submitted_page.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/widgets/text_field.dart';

import '../../../../../../core/utils/shared.dart';
import '../../../../../../res/res.dart';
import '../../../../../../shared/appbar/appbar.dart';
import '../../../../../../shared/buttons/primary_button.dart';

// class ArticleInfo {
//   String? articleLink;
//   ArticleInfo({this.articleLink});
// }

class BlueTickBusinessPage extends StatefulWidget {
  const BlueTickBusinessPage({super.key});

  @override
  State<BlueTickBusinessPage> createState() => _BlueTickBusinessPageState();
}

class _BlueTickBusinessPageState extends State<BlueTickBusinessPage> {
  final articleList = ValueNotifier<List<ArticleInfo>>([ArticleInfo()]);

  final listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [
          VWidgetsPrimaryButton(
            buttonTitle: 'Continue',
            onPressed: () { HapticFeedback.lightImpact();
              navigateToRoute(context, const BusinessTickSubmittedPage());
            },
          )
        ],
        appBar: const VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(),
          appbarTitle: "Verification",
          elevation: 1,
        ),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            addVerticalSpacing(25),
            const VWidgetsTextFieldNormal(
              labelText: 'Business/brand/venture name',
              hintText: 'Ex. Vmodel',
            ),
            addVerticalSpacing(15),
            const VWidgetsTextFieldNormal(
              labelText: 'Government registration number',
              hintText: 'Ex. 145806702',
            ),
            addVerticalSpacing(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Links to articles or publications',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: VmodelColors.primaryColor)),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          articleList.value.removeLast();
                          setState(() {});
                          listScrollController.animateTo(
                              listScrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        icon: const Icon(Icons.remove)),
                    IconButton(
                        onPressed: () {
                          articleList.value = [
                            ...articleList.value,
                            ArticleInfo()
                          ];
                          listScrollController.animateTo(
                              listScrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
              ],
            ),
            Flexible(
              child: ValueListenableBuilder(
                  valueListenable: articleList,
                  builder: (context, value, child) {
                    return ListView.builder(
                        controller: listScrollController,
                        itemCount: value.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: VWidgetsTextFieldNormal(
                                onChanged: (val) {
                                  value[index].articleLink = val;
                                },
                                hintText:
                                    'Ex. https://vellmagazine.com/reviews/my-brand',
                              ),
                            ));
                  }),
            ),
          ]),
        )));
  }
}
