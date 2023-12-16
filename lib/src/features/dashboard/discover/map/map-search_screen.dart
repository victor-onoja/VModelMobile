import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vmodel/src/features/dashboard/discover/map/widget/map_search_card.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../res/assets/app_asset.dart';
import '../../dash/dashboard_ui.dart';

class MapSearchView extends StatefulWidget {
  const MapSearchView({Key? key}) : super(key: key);

  @override
  State<MapSearchView> createState() => _MapSearchViewState();
}

class _MapSearchViewState extends State<MapSearchView>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 600);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => dismissKeyboard(),
      child: Scaffold(
        extendBody: true,
        appBar: VWidgetsAppBar(
          appBarHeight: 50,
          appbarTitle: 'Map Search',
          backgroundColor: Colors.white,
          leadingIcon: VWidgetsBackButton(
            onTap: () {
              navigateToRoute(context, const DashBoardView());
            },
          ),
          trailingIcon: [
            Flexible(
              child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: false,
                    transitionAnimationController: controller,
                    backgroundColor: Colors.white,
                    // backgroundColor: Colors.green,
                    context: context,
                    builder: (context) => _showModalBottomSheet(),
                  );
                  // navigateToRoute(context, NotificationsView());
                },
                icon: listSortingIcon,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 12, right: 8),
            //   child: SizedBox(
            //     height: 30,
            //     width: 100,
            //     child: Row(
            //       children: [
            //         Flexible(
            //           child: IconButton(
            //             padding: const EdgeInsets.all(0),
            //             onPressed: () {},
            //             icon: const RenderSvg(svgPath: VIcons.setting),
            //           ),
            //         ),
            //         Flexible(
            //           child: IconButton(
            //             padding: const EdgeInsets.all(0),
            //             onPressed: () {
            //               navigateToRoute(context, NotificationsView());
            //             },
            //             icon: const RenderSvg(svgPath: VIcons.notification),
            //           ),
            //         ),
            //         addHorizontalSpacing(5),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    // Image.asset(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height,
                    //   "assets/images/map.png",
                    //   fit: BoxFit.cover,
                    // ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: _googleMapWidget(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                color: VmodelColors.text.withOpacity(0.15)),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Icon(Icons.search_outlined,
                                color: VmodelColors.text),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color:
                                        VmodelColors.text.withOpacity(0.15))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color:
                                        VmodelColors.text.withOpacity(0.15))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color:
                                        VmodelColors.text.withOpacity(0.15))),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    color: VmodelColors.text.withOpacity(0.15)),
                            hintText: "Search...",
                            constraints: const BoxConstraints(maxHeight: 40),
                            contentPadding: const EdgeInsets.all(8)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Container(
              //   color:
              //       Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
              //   height: 270,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //     children: const [
              //       MapSearchSubItem(
              //         imagePath: 'assets/images/models/model01.png',
              //       ),
              //       MapSearchSubItem(
              //         imagePath: 'assets/images/models/model_11.png',
              //       ),
              //       MapSearchSubItem(
              //         imagePath: 'assets/images/models/model02.png',
              //       ),
              //     ],
              //   ),
              // ),
              GestureDetector(
                onVerticalDragStart: (update) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: false,
                    transitionAnimationController: controller,
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => _showModalBottomSheet(),
                  );
                },
                child: Container(
                  height: 75,
                  width: 100.w,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color:
                                  VmodelColors.primaryColor.withOpacity(0.15)),
                        ),
                      ),
                      Text(
                        "150 people",
                        style: textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: VmodelColors.text,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController cntlr) {
    // _controller = _cntlr;
    // // _cntlr.setMapStyle(OneBankConstants.dARK_THEME ? darkMapTheme : null);
    // _location.onLocationChanged.listen((l) async {
    //   _controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 12),
    //     ),
    //   );
    // });
  }

  GoogleMap _googleMapWidget() {
    LatLng initialcameraposition = const LatLng(6.5244, 3.3792);
    return GoogleMap(
      initialCameraPosition:
          CameraPosition(target: initialcameraposition, zoom: 12),
      mapType: MapType.normal,
      onMapCreated: onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onCameraMove: (position) => initialcameraposition = position.target,
      // markers: _markers.map((e) => e).toSet(),
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
    );
  }
}

Widget _showModalBottomSheet() => DraggableScrollableSheet(
      expand: false,
      key: UniqueKey(),
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: .5,
      builder: (context, controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView(
          controller: controller,
          children: const [
            MapSearchCard(
              initialPage: 0,
            ),
            MapSearchCard(
              initialPage: 1,
            ),
            MapSearchCard(
              initialPage: 2,
            ),
          ],
        ),
      ),
    );
