// ignore_for_file: prefer_const_constructors
import 'package:collection/collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/create_posts/models/photo_post_model.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/enum/album_type.dart';
import '../../../shared/empty_page/empty_page.dart';
import '../../dashboard/new_profile/model/gallery_model.dart';
import '../controller/print_gallery_controller.dart';

class PreviewScreen extends ConsumerStatefulWidget {
  const PreviewScreen(
      {super.key, this.selectedAlbumType, this.username, this.albumType});

  final AlbumType? albumType;
  final String? username;
  final AlbumType? selectedAlbumType;

  @override
  ConsumerState<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends ConsumerState<PreviewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<PhotoPostModel> selectedImages = [];
  int selectedGallery = 0;
  final maximumSelectedLength = 6;
  bool _showPrintIcon = false;

  @override
  void initState() {
    super.initState();
    // ref.read(printGalleryTypeFilterProvider(widget.username).notifier).state =
    //     widget.selectedAlbumType;
    final tabsNumber =
        ref.read(printGalleryListProvider(widget.username)).valueOrNull ?? [];
    _tabController =
        TabController(vsync: this, initialIndex: 0, length: tabsNumber.length);
    _tabController.addListener(_handleTabSelection);
  }

  void onImageSelected(PhotoPostModel item) {
    _showPrintIcon = false;
    if (selectedImages.contains(item)) {
      selectedImages.removeWhere((element) => element == item);
    } else if (selectedImages.length == maximumSelectedLength) {
      VWidgetShowResponse.showToast(ResponseEnum.warning,
          message: "Maximum of $maximumSelectedLength pictures allowed");
    } else {
      selectedImages.add(item);
      if (selectedImages.length == maximumSelectedLength) {
        _showPrintIcon = true;
      }
    }
    setState(() {});
  }

  void _handleTabSelection() {
    setState(() {
      selectedImages = [];
    });

    // for (int i = 0; i < imageList.length; i++) {
    //   imageList[i].selected = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final galleriesState = ref.watch(printGalleryListProvider(widget.username));
    final galleries = galleriesState.valueOrNull ?? [];

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: const VWidgetsBackButton(),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Preview',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [
            IconButton(
                onPressed: _showPrintIcon ? () {} : null,
                icon: RenderSvg(
                  svgPath: VIcons.menuPrint,
                  color: _showPrintIcon ? null : VmodelColors.greyColor,
                ))
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                //padding: EdgeInsets.symmetric(horizontal: 10),
                indicatorColor: Theme.of(context).indicatorColor,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Theme.of(context).tabBarTheme.labelColor,
                unselectedLabelColor:
                    Theme.of(context).tabBarTheme.unselectedLabelColor,
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                labelStyle: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                isScrollable: true,
                tabs: galleries.map((e) => Tab(text: e.name)).toList(),
              ),
            ),
          ),
        ),
        body: galleriesState.when(
            data: (data) {
              if (data.isEmpty) {
                return const EmptyPage(
                  svgSize: 30,
                  svgPath: VIcons.gridIcon,
                  // title: 'No Galleries',
                  subtitle: 'Upload media to see content here.',
                );
              }
              return Column(
                children: [
                  SizedBox(
                    height: height * 0.55,
                    child: TabBarView(
                      controller: _tabController,
                      children:
                          galleries.map((e) => _gridView(height, e)).toList(),
                    ),
                  ),
                  addVerticalSpacing(5),
                  Container(
                    height: 6,
                    width: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),
                  ),
                  addVerticalSpacing(1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: SizedBox(
                      //decoration: BoxDecoration(borderRadius: BorderRadius.all(radius)),
                      height: 180,
                      child: Material(
                        color: Colors.white,
                        shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 56,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 56,
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                    ),
                                    addVerticalSpacing(4.5),
                                    Divider(
                                      color: VmodelColors.primaryColor,
                                      thickness: 2,
                                      height: 0,
                                    ),
                                    addVerticalSpacing(11.3),
                                    divider(),
                                    divider(padding: true),
                                    divider(),
                                    divider(padding: true),
                                    divider(),
                                    divider(padding: true),
                                    divider(),
                                    divider(padding: true),
                                    divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 22,
                                          width: 22,
                                          color:
                                              Color.fromRGBO(217, 217, 217, 1),
                                        ),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor:
                                              Color.fromRGBO(217, 217, 217, 1),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              addHorizontalSpacing(10),
                              Expanded(
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 3,
                                            mainAxisSpacing: 6,
                                            mainAxisExtent: 80),
                                    itemCount: maximumSelectedLength,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    VmodelColors.primaryColor,
                                                image: selectedImages.length >
                                                        index
                                                    ? DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                                selectedImages[
                                                                        index]
                                                                    .url),
                                                        fit: BoxFit.cover)
                                                    : null),
                                            child: selectedImages.length <=
                                                    index
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: RenderSvg(
                                                      svgPath:
                                                          VIcons.galleryAddIcon,
                                                      svgHeight: 10,
                                                      svgWidth: 10,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : null,
                                          ));
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
            error: ((error, stackTrace) {
              return Center(
                child: Container(
                    color: VmodelColors.white,
                    child: EmptyPage(
                      svgSize: 30,
                      svgPath: VIcons.gridIcon,
                      // title: 'No Galleries',
                      subtitle: 'Error: $error',
                    )),
              );
            }),
            loading: () => Center(child: CircularProgressIndicator.adaptive())));
  }

  divider({bool padding = false}) {
    return Padding(
      padding: EdgeInsets.only(right: padding ? 20 : 0, bottom: 5.65),
      child: Divider(
        color: Color.fromRGBO(217, 217, 217, 1),
        height: 0,
      ),
    );
  }

  Widget _gridView(double height, GalleryModel gallery) {
    final temp = gallery.postSets.map((e) => e.photos);
    final allPhotos = temp.flattened.toList();
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            mainAxisExtent: height * 0.252),
        itemCount: allPhotos.length,
        itemBuilder: (BuildContext context, int index) {
          final data = allPhotos[index];
          // final data = galleries.value[index];

          return InkWell(
            onTap: () {
              // data.selected = !data.selected;
              onImageSelected(data);

              // if (data.selected) {
              //   setState(() {
              //     selectedImages.add(data.image);
              //   });
              // } else {
              //   setState(() {
              //     selectedImages.remove(data.image);
              //   });
              // }
            },
            child: Container(
                //height: 200,

                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(data.url,
                            maxHeight: 300),
                        fit: BoxFit.cover)),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      margin: EdgeInsets.only(right: 6, top: 6),
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: VmodelColors.primaryColor)),
                      // child: data.selected
                      child: selectedImages.contains(data)
                          ? Center(
                              child: CircleAvatar(
                              backgroundColor: VmodelColors.primaryColor,
                              radius: 4,
                            ))
                          : null),
                )),
          );
        });
  }
}

// class PrintGridView extends StatefulWidget {
//   const PrintGridView({super.key});

//   @override
//   State<PrintGridView> createState() => _PrintGridViewState();
// }

// class _PrintGridViewState extends State<PrintGridView> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 3,
//             mainAxisSpacing: 3,
//             mainAxisExtent: height * 0.252),
//         itemCount: imageList.length,
//         itemBuilder: (BuildContext context, int index) {
//           final data = imageList[index];
//           // final data = galleries.value[index];

//           return InkWell(
//             onTap: () {
//               data.selected = !data.selected;

//               if (data.selected) {
//                 setState(() {
//                   selectedImages.add(data.image);
//                 });
//               } else {
//                 setState(() {
//                   selectedImages.remove(data.image);
//                 });
//               }
//             },
//             child: Container(
//                 //height: 200,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage(
//                             'assets/images/models/${data.image}.png'),
//                         fit: BoxFit.cover)),
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                       margin: EdgeInsets.only(right: 6, top: 6),
//                       height: 14,
//                       width: 14,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: VmodelColors.primaryColor)),
//                       child: data.selected
//                           ? Center(
//                               child: CircleAvatar(
//                               backgroundColor: VmodelColors.primaryColor,
//                               radius: 4,
//                             ))
//                           : null),
//                 )),
//           );
//         });
//   }
// }
