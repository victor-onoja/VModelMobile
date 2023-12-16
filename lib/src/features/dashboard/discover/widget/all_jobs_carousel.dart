// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vmodel/src/core/utils/costants.dart';
// import 'package:vmodel/src/features/dashboard/feed/widgets/share.dart';
// import 'package:vmodel/src/features/jobs/job_market/views/job_detail_creative_updated.dart';
// import 'package:vmodel/src/features/jobs/job_market/widget/business_user/business_my_jobs_card.dart';
// import 'package:vmodel/src/res/assets/app_asset.dart';
// import 'package:vmodel/src/res/icons.dart';
// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
// import 'package:vmodel/src/vmodel.dart';

// import '../../../jobs/job_market/model/job_post_model.dart';

// class AlljobsCarousel extends ConsumerStatefulWidget {
//   final List<JobPostModel> jobs;
//   final bool enableLargeTile;
//   final ScrollController controller;
//   const AlljobsCarousel(this.jobs,
//       {super.key, this.enableLargeTile = false, required this.controller});

//   @override
//   ConsumerState<AlljobsCarousel> createState() => _AlljobsCarouselState();
// }

// class _AlljobsCarouselState extends ConsumerState<AlljobsCarousel> {
//   bool _disableNext = false;
//   bool _disablePrevious = true;

//   final CarouselController _controller = CarouselController();
//   int get totalPages => (widget.jobs.length / itemsPerPage).ceil();

//   int _currentIndex = 0;
//   List<JobPostModel> jobs = [];
//   final itemsPerPage = 10;

//   Widget _buildPageIndicator() {
//     List<Widget> indicators = [];

//     for (int i = 0; i < totalPages; i++) {
//       if (i <= 5) {
//         indicators.add(
//           GestureDetector(
//             onTap: () {
//               _controller.animateToPage(
//                 i,
//               );
//               setState(() {});
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8.0),
//               padding: const EdgeInsets.all(6),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(3),
//                 color: i != _currentIndex
//                     ? const Color.fromARGB(255, 214, 212, 212)
//                     : Theme.of(context).colorScheme.tertiary,
//               ),
//               child: Text(
//                 (i + 1).toString(),
//                 style: TextStyle(
//                   color: i != _currentIndex
//                       ? Theme.of(context).scaffoldBackgroundColor
//                       : Theme.of(context).scaffoldBackgroundColor,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         );
//       } else if (i == 6) {
//         indicators.add(
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Icon(
//               Icons.more_horiz,
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//         );
//       } else if (i == totalPages - 1) {
//         indicators.add(
//           GestureDetector(
//             onTap: () {
//               _controller.animateToPage(
//                 i,
//               );
//               setState(() {});
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8.0),
//               padding: const EdgeInsets.all(6),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(3),
//                 color: i != _currentIndex
//                     ? const Color.fromARGB(255, 214, 212, 212)
//                     : VmodelColors.primaryColor,
//               ),
//               child: Text(
//                 (i + 1).toString(),
//                 style: TextStyle(
//                   color: i != _currentIndex
//                       ? Theme.of(context).primaryColor
//                       : VmodelColors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//     }

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: indicators,
//     );
//   }

//   @override
//   void dispose() {
//     // _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     jobs = widget.jobs;
//     return Column(
//       children: [
//         addVerticalSpacing(20),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [_jobNavigationWidget()],
//           ),
//         ),
//         CarouselSlider(
//           items: List.generate(
//             (jobs.length / itemsPerPage).ceil(),
//             (index) => GestureDetector(
//               child: ListView.builder(
//                   controller: widget.controller,
//                   itemCount: _itemCount,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   itemBuilder: (context, index) {
//                     final indx = (_currentIndex) * itemsPerPage;
//                     JobPostModel? jobItem;

//                     jobItem = jobs[index + indx];
//                     return Container(
//                       padding: EdgeInsets.only(
//                           bottom: index == (_itemCount - 1) ? 100 : 0),
//                       child: VWidgetsBusinessMyJobsCard(
//                         // profileImage: VmodelAssets2.imageContainer,
//                         profileImage: jobItem.creator.profilePictureUrl,
//                         // profileName: "Male Models Wanted in london",
//                         profileName: jobItem.jobTitle,
//                         // jobDescription:
//                         //     "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
//                         jobPriceOption: jobItem.priceOption.tileDisplayName,
//                         jobDescription: jobItem.shortDescription,
//                         enableDescription: widget.enableLargeTile,
//                         location: jobItem.jobType,
//                         time: "3:30 hr",
//                         appliedCandidateCount: "16",
//                         // jobBudget: "450",
//                         jobBudget: VConstants.noDecimalCurrencyFormatterGB
//                             .format(jobItem.priceValue.round()),
//                         candidateType: "Female",
//                         // navigateToRoute(
//                         //     context, JobDetailPage(job: jobs[index]));
//                         onItemTap: () {
//                           navigateToRoute(
//                               context, JobDetailPageUpdated(job: jobs[index]));
//                         },
//                         shareJobOnPressed: () {
//                           showModalBottomSheet(
//                             isScrollControlled: true,
//                             isDismissible: true,
//                             useRootNavigator: true,
//                             backgroundColor: Colors.transparent,
//                             context: context,
//                             builder: (context) => const ShareWidget(
//                               shareLabel: 'Share Job',
//                               shareTitle: "Male Models Wanted in london",
//                               shareImage: VmodelAssets2.imageContainer,
//                               shareURL:
//                                   "Vmodel.app/job/tilly's-bakery-services",
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }),
//             ),
//           ),
//           carouselController: _controller,
//           options: CarouselOptions(
//             height: MediaQuery.of(context).size.height * .75,
//             padEnds: true,

//             viewportFraction: 1,
//             // aspectRatio: 1,
//             initialPage: 0,
//             enableInfiniteScroll: false,
//             onPageChanged: (index, reason) {
//               _currentIndex = index;
//               setState(() {});
//             },
//           ),
//         ),
//         const SizedBox(height: 100),
//       ],
//     );
//   }

//   int get _itemCount {
//     return ((_currentIndex + 1) * itemsPerPage) > jobs.length
//         ? jobs.length % itemsPerPage
//         : itemsPerPage;
//   }

//   Container _jobNavigationWidget() {
//     return Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   _disableNext = false;
//                   if (_currentIndex > 0) {
//                     _currentIndex--;
//                     _controller.previousPage(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     );
//                     if (_currentIndex <= 0) {
//                       _disablePrevious = true;
//                     } else {
//                       _disablePrevious = false;
//                     }
//                   } else {
//                     _disablePrevious = true;
//                   }
//                   setState(() {});
//                 },
//                 child: RenderSvg(
//                   svgPath: VIcons.backButttonIcon,
//                   color: _disablePrevious
//                       ? Theme.of(context).primaryColor.withOpacity(.3)
//                       : Theme.of(context).primaryColor,
//                 ),
//               ),
//               addHorizontalSpacing(10),
//               _buildPageIndicator(),
//               GestureDetector(
//                 onTap: () {
//                   _disablePrevious = false;
//                   if (_currentIndex < (totalPages - 1)) {
//                     _currentIndex++;
//                     _controller.nextPage(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     );
//                     _disableNext = false;
//                     if (_currentIndex >= (totalPages - 1)) {
//                       _disableNext = true;
//                     } else {
//                       _disableNext = false;
//                     }
//                   } else {
//                     _disableNext = true;
//                   }
//                   setState(() {});
//                 },
//                 child: Transform.rotate(
//                   angle: 3.14159265,
//                   child: RenderSvg(
//                     svgPath: VIcons.backButttonIcon,
//                     color: _disableNext
//                         ? Theme.of(context).primaryColor.withOpacity(.3)
//                         : Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
