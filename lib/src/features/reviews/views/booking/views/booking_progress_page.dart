import 'package:dm_stepper/dm_stepper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/utils/costants.dart';
import '../widgets/item_card.dart';

class BookingsProgressPage extends ConsumerStatefulWidget {
  const BookingsProgressPage({super.key});

  @override
  ConsumerState<BookingsProgressPage> createState() =>
      _BookingsProgressPageState();
}

class _BookingsProgressPageState extends ConsumerState<BookingsProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appbarTitle: "Booking details",
        trailingIcon: [],
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              addVerticalSpacing(16),
              VWidgetsBusinessBookingItemCard(
                onItemTap: () {
                  // navigateToRoute(context, BookingJobDetailPage(job: jobItem));
                },
                statusColor: Colors.blue,
                enableDescription: false,
                profileImage: VMString.testImageUrl,
                jobPriceOption: "Per Hour",
                location: "On Location",
                noOfApplicants: 3,
                profileName: 'My First job',
                jobDescription: 'The first sentence' * 33,
                date: DateTime.now().getSimpleDateOnJobCard(),
                appliedCandidateCount: "16",
                jobBudget: VConstants.noDecimalCurrencyFormatterGB.format(838),
                candidateType: "Female",
                shareJobOnPressed: () {},
              ),
              addVerticalSpacing(16),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: DMStepper(
                    getDMStepList(),
                    stepCircleSize: 10,
                    // backgroundColor: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DMStepModel> getDMStepList() {
    return [
      DMStepModel(
        label: '',
        title: '',
        stepIcon: const SizedBox.shrink(),
        stepLabelWidget: const IconWithText(
          iconAsset: VIcons.bookingPencil,
          text: 'Booking created',
          isDone: true,
        ),
        dmStepType: DMStepType.done,
        dmStepColorsModel: DMStepColorsModel().copyWith(
          // doneIcon: Colors.black,
          doneBackground: Theme.of(context).colorScheme.primary,
          doneLink: Theme.of(context).colorScheme.primary,
          currentBackground: Theme.of(context).colorScheme.primary,
          currentLink: Theme.of(context).colorScheme.primary,
          nextBackground: Colors.grey.shade300,
        ),
      ),
      DMStepModel(
        title: '',
        stepLabelWidget: const IconWithText(
          iconAsset: VIcons.bookingCalendar,
          text: 'In progress',
          isDone: true,
        ),
        stepIcon: const SizedBox.shrink(),
        dmStepType: DMStepType.next,
        dmStepColorsModel: DMStepColorsModel().copyWith(
          doneBackground: Theme.of(context).colorScheme.primary,
          doneLink: Theme.of(context).colorScheme.primary,
          currentBackground: Theme.of(context).colorScheme.primary,
          currentLink: Theme.of(context).colorScheme.primary,
          nextBackground: Colors.grey.shade300,
        ),
      ),
      DMStepModel(
        title: '',
        stepLabelWidget: const IconWithText(
          iconAsset: VIcons.bookingRoundedOutlineStar,
          text: 'Completed',
          isDone: false,
        ),
        stepIcon: const SizedBox.shrink(),
        dmStepType: DMStepType.next,
        dmStepColorsModel: DMStepColorsModel().copyWith(
          doneBackground: Theme.of(context).colorScheme.primary,
          doneLink: Theme.of(context).colorScheme.primary,
          currentBackground: Theme.of(context).colorScheme.primary,
          currentLink: Theme.of(context).colorScheme.primary,
          nextBackground: Colors.grey.shade300,
        ),
      ),
      DMStepModel(
        title: '',
        stepLabelWidget: const IconWithText(
          iconAsset: VIcons.bookingRoundedOutlineStar,
          text: 'Client review',
          isDone: false,
        ),
        stepIcon: const SizedBox.shrink(),
        dmStepType: DMStepType.next,
        dmStepColorsModel: DMStepColorsModel().copyWith(
          doneBackground: Theme.of(context).colorScheme.primary,
          currentBackground: Theme.of(context).colorScheme.primary,
          currentLink: Theme.of(context).colorScheme.primary,
          nextBackground: Colors.grey.shade300,
        ),
      ),
      DMStepModel(
        title: '',
        stepLabelWidget: const IconWithText(
          iconAsset: VIcons.bookingRoundedOutlineStar,
          text: 'Payment complete',
          isDone: false,
        ),
        stepIcon: const SizedBox.shrink(),
        dmStepType: DMStepType.next,
        dmStepColorsModel: DMStepColorsModel().copyWith(
          doneBackground: Theme.of(context).colorScheme.primary,
          currentBackground: Theme.of(context).colorScheme.primary,
          currentLink: Theme.of(context).colorScheme.primary,
          nextBackground: Colors.grey.shade300,
        ),
      ),
    ];
  }
}

class IconWithText extends StatelessWidget {
  const IconWithText(
      {super.key,
      required this.iconAsset,
      required this.text,
      required this.isDone});
  final String iconAsset;
  final String text;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RenderSvg(svgPath: iconAsset),
        addHorizontalSpacing(8),
        Text(
          text,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
