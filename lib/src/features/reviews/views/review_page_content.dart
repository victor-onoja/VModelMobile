import 'package:vmodel/src/features/reviews/widgets/review_icons.dart';
import 'package:vmodel/src/features/reviews/widgets/review_rating.dart';
import 'package:vmodel/src/features/reviews/widgets/user_review_info.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class ReviewsPageContent extends StatefulWidget {
  const ReviewsPageContent({super.key});

  @override
  State<ReviewsPageContent> createState() => _ReviewsPageContentState();
}

class _ReviewsPageContentState extends State<ReviewsPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appBarHeight: 50,
        leadingIcon: const VWidgetsBackButton(),
        backgroundColor: VmodelColors.background,
        appbarTitle: "Reviews",
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Christopher M. Davies",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: VmodelColors.primaryColor),
              ),
              addVerticalSpacing(16),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2, color: VmodelColors.primaryColor),
                        image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/portfolio_images/c9.jpeg',
                            ),
                            fit: BoxFit.cover)),
                  ),
                  addHorizontalSpacing(35),
                  const ReviewUserInfo(),
                ],
              ),
              addVerticalSpacing(15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReviewRatings(
                    rating: '4.5',
                    title: 'Job Quality',
                  ),
                  ReviewRatings(
                    rating: '5',
                    title: 'Timing',
                  ),
                  ReviewRatings(
                    rating: '4.9',
                    title: 'Work Ethic',
                  ),
                ],
              ),
              addVerticalSpacing(25),
              Text(
                'I’m very happy working with you guys, I’m so happy i got invited into this app and have got a model booked just under 24hrs! Model arrived on time, had great personality and understood what we were looking for before the shoot. I’ll gladly hire this creative again! :)',
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: VmodelColors.primaryColor),
              ),
              addVerticalSpacing(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "4.8",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: VmodelColors.primaryColor),
                  ),
                  addHorizontalSpacing(3),
                  const RenderSvg(
                    svgPath: VIcons.star,
                    svgHeight: 14,
                    svgWidth: 14,
                    color: VmodelColors.primaryColor,
                  ),
                ],
              ),
              addVerticalSpacing(15),
              const ReviewIcons(),
            ],
          ),
        ),
      )),
    );
  }
}
