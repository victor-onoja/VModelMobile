import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/saved/controller/provider/saved_jobs_proiver.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/shimmer/job_shimmer.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/costants.dart';
import '../../../res/assets/app_asset.dart';
import '../../dashboard/feed/widgets/share.dart';
import '../../jobs/job_market/views/job_detail_creative_updated.dart';
import '../../jobs/job_market/widget/business_user/business_my_jobs_card.dart';

class SavedJobsHomepage extends ConsumerStatefulWidget {
  const SavedJobsHomepage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<SavedJobsHomepage> createState() => _SavedJobsHomepageState();
}

class _SavedJobsHomepageState extends ConsumerState<SavedJobsHomepage> {
  bool enableLargeTile = false;

  late final Debounce _debounce;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _debounce = Debounce(delay: Duration(milliseconds: 300));
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = SizerUtil.height * 0.2;
      if (maxScroll - currentScroll <= delta) {
        _debounce(() {
          ref.read(savedJobsProvider.notifier).fetchMoreData();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _debounce.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final savedJobs = ref.watch(savedJobsProvider);
    return savedJobs.when(
      data: (data) {
        if (data!.isNotEmpty) {
          return Scaffold(
              body: RefreshIndicator.adaptive(
            onRefresh: () async {
              HapticFeedback.lightImpact();
              ref.invalidate(savedJobsProvider);
            },
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      addVerticalSpacing(10),
                      VWidgetsBusinessMyJobsCard(
                        // profileImage: VmodelAssets2.imageContainer,
                        noOfApplicants: data[index].noOfApplicants,
                        profileImage: data[index].creator!.profilePictureUrl,
                        // profileName: "Male Models Wanted in london",
                        jobTitle: data[index].jobTitle,
                        // jobDescription:
                        //     "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
                        jobPriceOption: data[index].priceOption.tileDisplayName,
                        jobDescription: data[index].shortDescription,
                        enableDescription: enableLargeTile,
                        location: data[index].jobType,
                        date: data[index].createdAt.getSimpleDateOnJobCard(),
                        appliedCandidateCount: "16",
                        // jobBudget: "450",
                        jobBudget: VConstants.noDecimalCurrencyFormatterGB
                            .format(data[index].priceValue.round()),
                        candidateType: "Female",
                        // navigateToRoute(
                        //     context, JobDetailPage(job: jobs[index]));
                        onItemTap: () {
                          navigateToRoute(
                              context, JobDetailPageUpdated(job: data[index]));
                        },
                        shareJobOnPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: true,
                            useRootNavigator: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => const ShareWidget(
                              shareLabel: 'Share Job',
                              shareTitle: "Male Models Wanted in london",
                              shareImage: VmodelAssets2.imageContainer,
                              shareURL:
                                  "Vmodel.app/job/tilly's-bakery-services",
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }),
          ));
        } else {
          return Center(
              child: Text(
            "Saved Jobs is empty",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ));
        }
      },
      loading: () {
        return Scaffold(
         body: jobShimmer(context),
        );
      },
      error: (error, stackTrace) {
        print("loading error $error $stackTrace");
        return Scaffold(
          appBar: VWidgetsAppBar(
            leadingIcon: VWidgetsBackButton(),
            appbarTitle: widget.title,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.replay_rounded),
              SizedBox(height: 16),
              RenderSvg(
                svgPath: VIcons.retry,
                svgHeight: 40,
                svgWidth: 40,
              ),
              addVerticalSpacing(15),
              Center(
                  child: Text(
                "An error occured",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              )),
              addVerticalSpacing(40),
              VWidgetsPrimaryButton(
                butttonWidth: SizerUtil.width * .4,
                buttonColor:
                    Theme.of(context).buttonTheme.colorScheme?.secondary,
                buttonTitleTextStyle:
                    Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                onPressed: () => ref.refresh(savedJobsProvider),
                buttonTitle: "Try again",
              ),
            ],
          ),
        );
      },
    );
  }
}
