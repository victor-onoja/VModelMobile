import 'package:vmodel/src/features/dashboard/discover/widget/category_button.dart';
import 'package:vmodel/src/features/jobs/job_market/data/mock_data.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsBusinessOfferDetailsCard extends StatefulWidget {
  final String? profileImage;
  final String? profileName;
  final String? profileType;
  final String? jobDescription;
  final String? jobLocation;
  final String? jobStartDate;
  final String? gender;
  final String? contratLength;
  final String? jobPricePerTime;
  final String? aboutDescription;
  final String? jobRating;
  final String? jobTotalFee;

  const VWidgetsBusinessOfferDetailsCard(
      {required this.profileImage,
      required this.profileName,
      required this.profileType,
      required this.jobDescription,
      required this.jobRating,
      required this.aboutDescription,
      required this.contratLength,
      required this.gender,
      required this.jobLocation,
      required this.jobPricePerTime,
      required this.jobStartDate,
      required this.jobTotalFee,
      super.key});

  @override
  State<VWidgetsBusinessOfferDetailsCard> createState() =>
      _VWidgetsBusinessOfferDetailsCardState();
}

class _VWidgetsBusinessOfferDetailsCardState
    extends State<VWidgetsBusinessOfferDetailsCard> {
  @override
  Widget build(BuildContext context) {
    String selectedChip = "Job Description";

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.profileName!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: VmodelColors.primaryColor,
              ),
        ),
        addVerticalSpacing(6),
        Text(
          widget.profileType!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: VmodelColors.primaryColor.withOpacity(0.5),
              ),
        ),
        addVerticalSpacing(12),
        Flexible(
          child: Text(
            widget.jobDescription!,
            maxLines: 500,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: VmodelColors.primaryColor,
                ),
          ),
        ),
        addVerticalSpacing(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Location",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor.withOpacity(0.5),
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  "Job Rating",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor.withOpacity(0.5),
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  "Price",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor.withOpacity(0.5),
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  "Start Date",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor.withOpacity(0.5),
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  "Gender",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor.withOpacity(0.5),
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  "Contract Length",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor.withOpacity(0.5),
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  "Total Fee",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor.withOpacity(0.5),
                      ),
                ),
              ],
            ),
            addHorizontalSpacing(25),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.jobLocation!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor,
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  widget.jobRating!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor,
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  "£ ${widget.jobPricePerTime}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor,
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  widget.jobStartDate!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor,
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  widget.gender!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor,
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  widget.contratLength!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor,
                      ),
                ),
                addVerticalSpacing(3),
                Text(
                  widget.jobTotalFee!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor,
                      ),
                ),
              ],
            )
          ],
        ),
        addVerticalSpacing(5),
        const Divider(
          thickness: 1,
        ),
        SizedBox(
          height: 56,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return CategoryButton(
                isSelected: selectedChip == categories[index],
                text: categories[index],
                onPressed: () =>
                    setState(() => selectedChip = categories[index]),
              );
            },
          ),
        ),
        addVerticalSpacing(12),
        Flexible(
          child: Text(
            widget.jobDescription!,
            maxLines: 500,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: VmodelColors.primaryColor,
                ),
          ),
        ),
      ],
    );
  }
}
