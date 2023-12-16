import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/jobs/job_market/model/job_post_model.dart';
import 'package:vmodel/src/features/jobs/job_market/views/job_detail_creative_updated.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/job_sub_item.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class JobSubList extends ConsumerWidget {
  final String title;
  final List<JobPostModel> items;
  final bool? eachUserHasProfile;
  final Widget? route;
  final ValueChanged onTap;
  final VoidCallback? onViewAllTap;
  final bool isCurrentUser;
  final String username;
  const JobSubList({
    Key? key,
    required this.isCurrentUser,
    required this.username,
    required this.title,
    required this.items,
    required this.onTap,
    this.onViewAllTap,
    this.eachUserHasProfile = false,
    this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        addVerticalSpacing(10),
        GestureDetector(
          onTap: () {
            onViewAllTap?.call();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  )
              ),
              Text(
                "View all".toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      ),
              ),
            ],
          ),
        ),
       addVerticalSpacing(9),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "No data for ${title}",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(),
            ),
          ),
        if (items.isNotEmpty)
          SizedBox(
            height: SizerUtil.height * 0.35,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: JobSubItem(
                      item: items[index],
                      onTap: () {
                        navigateToRoute(
                            context, JobDetailPageUpdated(job: items[index]));
                      },
                      onLongPress: () {},
                    ),
                  );
                }),
          ),
        addVerticalSpacing(5),
      ],
    );
  }
}
