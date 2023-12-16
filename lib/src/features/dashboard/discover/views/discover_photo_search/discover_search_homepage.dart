import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vmodel/src/features/dashboard/discover/views/discover_photo_search/discover_photo_search_recent_view.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class DiscoverPhotoSearchPage extends StatefulWidget {
  const DiscoverPhotoSearchPage({super.key});

  @override
  State<DiscoverPhotoSearchPage> createState() =>
      _DiscoverPhotoSearchPageState();
}

class _DiscoverPhotoSearchPageState extends State<DiscoverPhotoSearchPage> {
  bool isUserGallary = true;

  toggleUserGallary() {
    setState(() {
      isUserGallary = !isUserGallary;
    });
  }

  Future<void> reloadData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        backgroundColor: VmodelColors.appBarBackgroundColor,
        appbarTitle: '',
        appBarHeight: 50,
        optionalTitle: GestureDetector(
          onTap: () {
            toggleUserGallary();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Recent",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    // color: Theme.of(context).primaryColor,
                    fontSize: 13.sp),
              ),
              IconButton(
                  onPressed: () {
                    toggleUserGallary();
                  },
                  icon: RenderSvg(
                      svgPath: isUserGallary
                          ? VIcons.downwardArrowIcon
                          : VIcons.upwardArrowIcon))
            ],
          ),
        ),
        leadingIcon: IconButton(
          onPressed: () {
            popSheet(context);
          },
          icon: const RenderSvg(svgPath: VIcons.closeIcon),
        ),
        trailingIcon: [
          IconButton(
            onPressed: () {
              _getFromGallery();
            },
            icon: const RenderSvg(svgPath: VIcons.cameraIcon),
          ),
        ],
      ),
      body:
          isUserGallary ? _buildGridView(context) : const DiscoverRecentPage(),
    );
  }

  _buildGridView(
    BuildContext context,
  ) {
    return RefreshIndicator.adaptive(
      onRefresh: () {HapticFeedback.lightImpact();
        return reloadData();
      },
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 202,
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemCount: assets["models"]!.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
                onTap: () {
                  navigateToRoute(context, const DiscoverPhotoSearchPage());
                },
                child: Image.asset(
                  assets["models"]![index],
                  fit: BoxFit.cover,
                ));
          }),
    );
  }

// TO PICK IMAGE FROM GALLERY
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      XFile imageFile = XFile(pickedFile.path);
    }
  }
}
