import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsJobDetailsCard extends StatelessWidget {
  final String? userName;
  final String? location;
  final String? duration;
  final String? gender;
  final String? budget;
  final String? jobInfo;
  final ImageProvider<Object>? image;
  final List<String>? categoryTags;
  final VoidCallback? onPressedShare;
  final VoidCallback? onPressedLocation;
  final VoidCallback? onPressedSendMessege;
  final VoidCallback? onPressedSendOffer;

  const VWidgetsJobDetailsCard(
      {required this.userName,
      required this.location,
      required this.duration,
      required this.gender,
      required this.budget,
      required this.jobInfo,
      required this.image,
      required this.categoryTags,
      required this.onPressedShare,
      required this.onPressedLocation,
      required this.onPressedSendMessege,
      required this.onPressedSendOffer,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child:  Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(userName!,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: VmodelColors.primaryColor,
                          fontSize: 12.sp)),
                  IconButton(
                      onPressed: onPressedShare,
                      icon: const RenderSvg(
                        svgPath: VIcons.shareIcon,
                        svgHeight: 24,
                        svgWidth: 24,
                      ))
                ],
              ),
              addVerticalSpacing(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40.0,
                    backgroundImage: image,
                  ),
                  addHorizontalSpacing(40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Location",
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.greyColor,
                              fontSize: 10.sp)),
                      addVerticalSpacing(3),
                      Text("Gender",
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.greyColor,
                              fontSize: 10.sp)),
                      addVerticalSpacing(3),
                      Text("Duration",
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.greyColor,
                              fontSize: 10.sp)),
                      addVerticalSpacing(3),
                      Text("Budget",
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.greyColor,
                              fontSize: 10.sp)),
                    ],
                  ),
                  addHorizontalSpacing(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(location!,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.primaryColor,
                              fontSize: 10.sp)),
                      addVerticalSpacing(3),
                      Text(gender!,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.primaryColor,
                              fontSize: 10.sp)),
                      addVerticalSpacing(3),
                      Text(duration!,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.primaryColor,
                              fontSize: 10.sp)),
                      addVerticalSpacing(3),
                      Text("£$budget",
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.primaryColor,
                              fontSize: 10.sp)),
                    ],
                  ),
                ],
              ),
              addVerticalSpacing(20),
              categoryTagsUI(context),
              addVerticalSpacing(10),
              Text(jobInfo!,
                    // textAlign: TextAlign.start,
                    maxLines: 100,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor,
                        fontSize: 11.5.sp)),
              
              addVerticalSpacing(10),
              Row(
                children: [
                  IconButton(
                      onPressed: onPressedLocation,
                      icon: const RenderSvgWithoutColor(
                        svgPath: VIcons.locationAtoBIcon,
                        svgHeight: 28,
                        svgWidth: 28,
                      )),
                  addHorizontalSpacing(5),
                  Flexible(
                    child: VWidgetsPrimaryButton(
                      onPressed: onPressedSendMessege,
                      buttonTitle: "Send message",
                      enableButton: true,
                    ),
                  ),
                  addHorizontalSpacing(5),
                  Flexible(
                    child: VWidgetsPrimaryButton(
                      onPressed: onPressedSendMessege,
                      buttonTitle: "Send an offer",
                      enableButton: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }

  Widget categoryTagsUI(BuildContext context) {
    return Wrap(
      children: [
        ...categoryTags!.map(
          (e) {
            return  Padding(
                padding: const VWidgetsPagePadding.all(2),
                child: Container(
                 width: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: VmodelColors.greyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:6.0, vertical: 8.0),
                    child: Text(
                        e,
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.primaryColor,
                       )),
                  ),
                  
                ),
              
            );
          },
        ),
      ],
    );
  }
}
