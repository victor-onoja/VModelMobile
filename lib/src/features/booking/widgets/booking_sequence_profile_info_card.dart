import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsBookingSequenceProfileInfoCard extends StatelessWidget {
  final String? profileName;
  final String? profileImage;
  final String? address;
  final String? startDate;
  final String? endDate;
  final String? dateEstimation;

  const VWidgetsBookingSequenceProfileInfoCard({
    super.key,
    required this.profileName,
    required this.profileImage,
    required this.address,
    required this.startDate,
    required this.endDate,
    required this.dateEstimation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(profileImage!),
                fit: BoxFit.cover,
              )),
        ),
        addHorizontalSpacing(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              profileName!,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: VmodelColors.primaryColor),
            ),
            addVerticalSpacing(4),
            Text(address!,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: VmodelColors.primaryColor)),
            Row(
              children: [
                Row(
                  children: [
                    Text(
                      startDate!,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: VmodelColors.primaryColor),
                    ),
                    Text(
                      " - ",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: VmodelColors.text3),
                    ),
                    Text(
                      endDate!,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: VmodelColors.primaryColor),
                    ),
                  ],
                ),
                addHorizontalSpacing(6),
                Text(
                  "In $dateEstimation weeks",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500, color: VmodelColors.text3),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
