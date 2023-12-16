import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsBusinessOffersHomePageCard extends StatelessWidget {
  final String? senderProfileImage;
  final String? jobSender;
  final VoidCallback? viewOnPressed;
  final VoidCallback? acceptedOnPressed;
  final String? receivedJobTime;
  const VWidgetsBusinessOffersHomePageCard(
      {required this.senderProfileImage,
      required this.jobSender,
      required this.viewOnPressed,
      required this.acceptedOnPressed,
      required this.receivedJobTime,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
            Row(
              children: [
                Padding(
                  padding: const VWidgetsPagePadding.verticalSymmetric(4),
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Container(
                      decoration: VModelBoxDecoration.avatarDecoration.copyWith(
                          color: VmodelColors.appBarBackgroundColor,
                          image: DecorationImage(
                            image: AssetImage(
                              senderProfileImage!,
                              //e.picPath,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
                addHorizontalSpacing(12),
             Text(
                 "$jobSender",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: VmodelColors.primaryColor,
                  ),
                
                ),
                addHorizontalSpacing(4),
                Text(
                 "sent you an offer",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: VmodelColors.primaryColor.withOpacity(1),
                  ),
                ),
                addHorizontalSpacing(4),
                Text(
                 receivedJobTime!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: VmodelColors.primaryColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
        
        Flexible(
          child: SizedBox(
            width: 80,
            child: VWidgetsPrimaryButton(
              buttonTitle: "View",
              onPressed: viewOnPressed,
              enableButton: true,),
          ),
        ),
      ],
    );
  }
}
