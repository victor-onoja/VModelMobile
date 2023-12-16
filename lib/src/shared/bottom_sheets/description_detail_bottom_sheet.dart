import 'package:url_launcher/url_launcher.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../../res/res.dart';
import '../buttons/text_button.dart';
import '../html_description_widget.dart';
import '../modal_pill_widget.dart';
import '../../vmodel.dart';

class DetailBottomSheet extends StatelessWidget {
  const DetailBottomSheet({
    super.key,
    required this.title,
    required this.content,
    this.briefLink,
  });

  final String title;
  final String content;
  final String? briefLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: SizerUtil.height * 0.9,
        minHeight: SizerUtil.height * 0.2,
        minWidth: SizerUtil.width,
      ),
      decoration: BoxDecoration(
        // color: VmodelColors.white,
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addVerticalSpacing(15),
          const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
          addVerticalSpacing(24),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: VmodelColors.primaryColor,
                  // fontSize: 12,
                ),
          ),
          addVerticalSpacing(16),
          Flexible(
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: VmodelColors.jobDetailGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16)),
              child: RawScrollbar(
                mainAxisMargin: 4,
                crossAxisMargin: -8,
                thumbVisibility: true,
                // thumbColor: VmodelColors.primaryColor.withOpacity(0.3),
                thumbColor: Theme.of(context).primaryColor.withOpacity(0.3),
                thickness: 4,
                radius: const Radius.circular(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!briefLink.isEmptyOrNull)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Link to external brief:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  // color: VmodelColors.primaryColor,
                                ),
                          ),
                        ),
                      if (!briefLink.isEmptyOrNull)
                        SizedBox(
                          width: double.maxFinite,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              // backgroundColor: VmodelColors.white,
                              backgroundColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme
                                  ?.tertiary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              var url = briefLink!;
                              final uri = Uri.parse(url);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri,
                                    mode: LaunchMode.inAppWebView);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Link'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        // color: VmodelColors.primaryColor,
                                      ),
                                ),
                                addVerticalSpacing(4),
                                Text(
                                  'Tap to visit link',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color:
                                            // VmodelColors.primaryColor
                                            //     .withOpacity(0.3),
                                            Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.color
                                                ?.withOpacity(0.3),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (!briefLink.isEmptyOrNull) addVerticalSpacing(16),
                      HtmlDescription(content: content),
                      // Html(
                      //   data: parseString(context, TextStyle(), content),
                      //   onlyRenderTheseTags: const {
                      //     'em',
                      //     'b',
                      //     'br',
                      //     'html',
                      //     'head',
                      //     'body'
                      //   },
                      //   style: {
                      //     "*": Style(color: Theme.of(context).primaryColor),
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          addVerticalSpacing(16),
          VWidgetsTextButton(
            text: 'Close',
            onPressed: () => goBack(context),
          ),
          addVerticalSpacing(24),
        ],
      ),
    );
  }
}
