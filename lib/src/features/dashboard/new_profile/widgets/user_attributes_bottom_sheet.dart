import 'package:auto_size_text/auto_size_text.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

import '../../../../core/models/app_user.dart';
import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../shared/buttons/text_button.dart';
import '../../../../shared/modal_pill_widget.dart';
import '../../../../vmodel.dart';

class UserAttributesBottomSheet extends StatelessWidget {
  const UserAttributesBottomSheet({
    super.key,
    required this.title,
    this.user,
  });

  final String title;
  final VAppUser? user;

  @override
  Widget build(BuildContext context) {
    // print();
    return Container(
      constraints: BoxConstraints(
        maxHeight: SizerUtil.height * 0.9,
        minHeight: SizerUtil.height * 0.2,
        minWidth: SizerUtil.width,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: VmodelColors.primaryColor,
                  // fontSize: 12,
                ),
          ),
          addVerticalSpacing(16),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: VmodelColors.jobDetailGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16)),
              child: RawScrollbar(
                mainAxisMargin: 4,
                crossAxisMargin: -8,
                thumbVisibility: true,
                thumbColor: VmodelColors.white.withOpacity(0.3),
                thickness: 4,
                radius: const Radius.circular(10),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  // childAspectRatio: 4 / 2.5,
                  childAspectRatio: 16 / 11,
                  children: [
                    _item(context,
                        field: 'Industry', value: '${user?.userType}'),
                    if (_isAttributeNotNullOrEmpty(user?.label))
                      _item(context,
                          field: 'Specialisation',
                          value: '${user?.label?.split(' ').firstOrNull}'),
                    _item(context,
                        field: 'Rating out of 5',
                        valueWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RenderSvg(
                              svgPath: VIcons.star,
                              svgHeight: 12,
                              svgWidth: 12,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            addHorizontalSpacing(2),
                            AutoSizeText(
                              '4.5',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    // color: VmodelColors.primaryColor,
                                  ),
                            ),
                          ],
                        )),
                    if (user?.yearsOfExperience != 0)
                      if (_isAttributeNotNullOrEmpty(user?.yearsOfExperience))
                        _item(context,
                            field: 'Years of Experience',
                            value: '${user?.yearsOfExperience}'),
                    if (_isAttributeNotNullOrEmpty(user?.personality))
                      _item(context,
                          field: 'Personality', value: '${user?.personality}'),
                    if ((user?.socials?.twitter?.noOfFollows != null) &&
                        (user?.socials?.twitter?.noOfFollows != 0))
                      _item(context,
                          field: 'Twitter followers',
                          value:
                              '${formatNumberWithSuffix(user!.socials!.twitter!.noOfFollows!)}'),
                    if ((user?.socials?.tiktok?.noOfFollows != null) &&
                        (user?.socials?.tiktok?.noOfFollows != 0))
                      _item(context,
                          field: 'Tiktok followers',
                          value:
                              '${formatNumberWithSuffix(user!.socials!.tiktok!.noOfFollows!)}'),
                    if ((user?.socials?.youtube?.noOfFollows != null) &&
                        (user?.socials?.youtube?.noOfFollows != 0))
                      _item(context,
                          field: 'Youtube subscribers',
                          value:
                              '${formatNumberWithSuffix(user!.socials!.youtube!.noOfFollows!)}'),
                    if ((user?.socials?.facebook?.noOfFollows != null) &&
                        (user?.socials?.facebook?.noOfFollows != 0))
                      _item(context,
                          field: 'Facebook followers',
                          value:
                              '${formatNumberWithSuffix(user!.socials!.facebook!.noOfFollows!)}'),
                    if ((user?.socials?.instagram?.noOfFollows != null) &&
                        (user?.socials?.instagram?.noOfFollows != 0))
                      _item(context,
                          field: 'Instagram followers',
                          value:
                              '${formatNumberWithSuffix(user!.socials!.instagram!.noOfFollows!)}'),
                    if ((user?.socials?.snapchat?.noOfFollows != null) &&
                        (user?.socials?.snapchat?.noOfFollows != 0))
                      _item(context,
                          field: 'Snapchat followers',
                          value:
                              '${formatNumberWithSuffix(user!.socials!.snapchat!.noOfFollows!)}'),
                    if ((user?.socials?.pinterest?.noOfFollows != null) &&
                        (user?.socials?.pinterest?.noOfFollows != 0))
                      _item(context,
                          field: 'Pinterest followers',
                          value:
                              '${formatNumberWithSuffix(user!.socials!.pinterest!.noOfFollows!)}'),
                    if ((user?.socials?.patreon?.noOfFollows != null) &&
                        (user?.socials?.patreon?.noOfFollows != 0))
                      _item(context,
                          field: 'Patreon followers',
                          value:
                              '${formatNumberWithSuffix(user!.socials!.patreon!.noOfFollows!)}'),
                    if ((user?.socials?.reddit?.noOfFollows != null) &&
                        (user?.socials?.reddit?.noOfFollows != 0))
                      _item(context,
                          field: 'Reddit followers',
                          value:
                              '${formatNumberWithSuffix(user!.socials!.reddit!.noOfFollows!)}'),
                    if ((user?.socials?.linkedin?.noOfFollows != null) &&
                        (user?.socials?.linkedin?.noOfFollows != 0))
                      _item(context,
                          field: 'Linkedin followers',
                          value:
                              '${formatNumberWithSuffix(user!.socials!.linkedin!.noOfFollows!)}'),
                    if (user?.userType
                            ?.toLowerCase()
                            .contains('photographer') ??
                        false)
                      _item(context,
                          field: 'Camera Type', value: 'Canon 5D Mark IV'),
                    if (user!.height!.value.isNotEmpty)
                      if (user?.height!.value != "0" ||
                          user?.height!.value != null)
                        if (_isAttributeNotNullOrEmpty(user?.height))
                          _item(context,
                              field: 'Height',
                              value: '${user?.height!.value} cm'),
                    if (user!.userType!.toLowerCase() != "stylist")
                      if (!user!.isBusinessAccount!)
                        if (_isAttributeNotNullOrEmpty(user?.modelSize))
                          _item(context,
                              field: 'Size', value: '${user?.modelSize} (UK)'),
                    if (user?.bust!.value != "0")
                      if (_isAttributeNotNullOrEmpty(user?.bust!.value))
                        _item(context,
                            field: 'Bust', value: '${user?.bust!.value} cm'),
                    if (user?.waist!.value != '0')
                      if (_isAttributeNotNullOrEmpty(user?.waist!.value))
                        _item(context,
                            field: 'Waist', value: '${user?.waist!.value} cm'),
                    if (_isAttributeNotNullOrEmpty(user?.ethnicity))
                      _item(context,
                          field: 'Ethnicity', value: '${user?.ethnicity}'),
                    if (_isAttributeNotNullOrEmpty(user?.eyes))
                      _item(context, field: 'Eyes', value: '${user?.eyes}'),
                    if (_isAttributeNotNullOrEmpty(user?.hair))
                      _item(context, field: 'Hair', value: '${user?.hair}'),
                  ],
                ),
              ),
            ),
          ),
          addVerticalSpacing(16),
          VWidgetsTextButton(
            text: 'Close',
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: VmodelColors.primaryColor,
                  // fontSize: 12,
                ),
            onPressed: () => goBack(context),
          ),
          addVerticalSpacing(24),
        ],
      ),
    );
  }

  bool _isAttributeNotNullOrEmpty(
    dynamic attribute,
    // {
    // required bool Function() extraCheck,
    // }
  ) {
    if (attribute is String?) return attribute != null && attribute.isNotEmpty;
    return attribute != null;
  }

  Widget _item(BuildContext context,
      {required String field, String? value, Widget? valueWidget}) {
    return Container(
      // color: Colors.red.shade300,
      // height: 800,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          valueWidget ??
              AutoSizeText(
                value!.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      // color: VmodelColors.primaryColor,
                    ),
              ),
          addVerticalSpacing(8),
          Text(
            field,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(

                // color: VmodelColors.primaryColor.withOpacity(0.3),
                ),
          ),
        ],
      ),
    );
  }
}
