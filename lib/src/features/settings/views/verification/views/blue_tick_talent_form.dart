import 'package:flutter/services.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';

import '../../../../../res/res.dart';
import '../../../../../shared/appbar/appbar.dart';
import '../../../../../shared/text_fields/dropdown_text_normal.dart';
import '../../../../../vmodel.dart';
import 'blue-tick/blue-tick_homepage.dart';
import 'blue-tick/blue-tick_submitted_page.dart';
import 'blue-tick/widgets/text_field.dart';

class BlueTickCreative extends StatefulWidget {
  const BlueTickCreative({
    super.key,
  });

  @override
  State<BlueTickCreative> createState() => _BlueTickCreativeState();
}

class _BlueTickCreativeState extends State<BlueTickCreative> {
  final platforms = [
    'Facebook',
    'Instagram',
    'Twitter',
    'Snapchat',
    'Tiktok',
    'Youtube',
    'Patreon',
    'Reddit',
    'Linkedin',
    'Website',
    'Other'
  ];

  final socialMediaList =
      ValueNotifier<List<SocialMediaInfo>>([SocialMediaInfo()]);
  final articleList = ValueNotifier<List<ArticleInfo>>([ArticleInfo()]);

  final listScrollController = ScrollController();
  final socialLinksScrollController = ScrollController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        VWidgetsPrimaryButton(
          buttonTitle: 'Continue',
          onPressed: () {
             HapticFeedback.lightImpact();
            navigateToRoute(context, const BusinessTickSubmittedPage());
          },
        )
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Verification",
        elevation: 1,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpacing(25),
                const VWidgetsTextFieldNormal(
                  labelText: 'Display name/Known names',
                  hintText: 'Ex. Molly Mae',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Social links',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              socialMediaList.value.removeLast();
                              setState(() {});
                              socialLinksScrollController.animateTo(
                                  socialLinksScrollController
                                      .position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            icon: const Icon(Icons.remove)),
                        IconButton(
                            onPressed: () {
                              socialMediaList.value = [
                                ...socialMediaList.value,
                                SocialMediaInfo()
                              ];
                              socialLinksScrollController.animateTo(
                                  socialLinksScrollController
                                      .position.maxScrollExtent,
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
                      valueListenable: socialMediaList,
                      builder: (context, value, child) {
                        return ListView.builder(
                            controller: socialLinksScrollController,
                            itemCount: value.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: VWidgetsDropdownNormal(
                                          items: platforms,
                                          itemToString: (item) => item,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return 'Select a platform';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) {
                                            value[index].platform = val;
                                          }),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: VWidgetsTextFieldNormal(
                                          onChanged: (val) {
                                            value[index].username = val;
                                          },
                                          hintText: 'username'),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Links to articles or publications',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
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
                                      hintText:
                                          'Ex. https://vellmagazine.com/reviews/my-brand',
                                      onChanged: (val) {
                                        value[index].articleLink = val;
                                      }),
                                ));
                      }),
                ),
                addVerticalSpacing(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
