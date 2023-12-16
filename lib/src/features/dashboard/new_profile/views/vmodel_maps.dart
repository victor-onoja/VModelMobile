import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'dart:ui' as ui;

import '../controller/all_users_controller.dart';
import '../widgets/image_on_map.dart';

class VModelMaps extends ConsumerStatefulWidget {
  const VModelMaps({super.key});

  @override
  ConsumerState<VModelMaps> createState() => _VModelMapsState();
}

class _VModelMapsState extends ConsumerState<VModelMaps> {
  // GoogleMapController? _controller;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  bool _loading = true;
  bool _loaded = false;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(51.508640967651466, -0.12628985839001558),
    zoom: 6,
  );

  @override
  void initState() {
    super.initState();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future _addMarker() async {
    List<Users> _userList = [];

    final users = await ref.watch(allUsersProvider);
    users.when(
        data: (data) async {
          print("data ${data.length}");
          _loading = false;
          _loaded = true;
          if (mounted) setState(() {});
          for (var user in data) {
            if (user.location != null)
              _userList.add(
                Users(
                  id: user.id!,
                  name: user.username!,
                  lat: user.location!.latitude!,
                  long: user.location!.longitude!,
                  markerIcon:
                      await ImageOnMap(imagePath: user.profilePictureUrl!),
                ),
              );
          }

          for (int i = 0; i < _userList.length; i++) {
            final MarkerId markerId = MarkerId(_userList[i].id);
            final Marker marker = Marker(
              markerId: markerId,
              position: LatLng(_userList[i].lat, _userList[i].long),
              icon: await _userList[i].markerIcon.toBitmapDescriptor(
                  logicalSize: const Size(150, 150),
                  imageSize: const Size(150, 150)),

              //  BitmapDescriptor.fromBytes(users[i].markerIcon),
              infoWindow: InfoWindow(
                  title: _userList[i].name, snippet: _userList[i].name),
              onTap: () {},
            );
            if (this.mounted)
              setState(() {
                _markers[markerId] = marker;
              });
          }
        },
        error: (error, stack) {},
        loading: () {
          _loading = true;
          if (mounted) setState(() {});
        });

    // for (int index = 0; index < users.length; index++) {
    //   Marker marker = Marker(
    //     markerId: MarkerId(users[index].name),
    //     position: LatLng(users[index].lat, users[index].long),
    //     infoWindow: InfoWindow(title: users[index].name),
    //     icon: customIcon![index],
    //   );

    //   _markers[users[index].name] = marker;
    // }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      _addMarker();
    }
    return _loading
        ? Scaffold(body: Center(child: CircularProgressIndicator.adaptive()))
        : Scaffold(
            appBar: VWidgetsAppBar(
              appbarTitle: "Search",
              leadingIcon: const VWidgetsBackButton(),
              trailingIcon: [
                IconButton(
                  onPressed: () {},
                  icon: RenderSvg(
                    svgPath: VIcons.descendingIcon,
                    svgHeight: 15.sp,
                    svgWidth: 15.sp,
                  ),
                )
              ],
            ),
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set<Marker>.of(_markers.values),
                ),
                Positioned(
                  top: 16.0,
                  right: 16.0,
                  child: SizedBox(
                    height: 30.sp,
                    width: 30.sp,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Handle the "My Location" button tap here
                      },
                      child: Icon(
                        Icons.my_location,
                        color: VmodelColors.primaryColor,
                      ),
                      backgroundColor: VmodelColors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class Users {
  String id;
  String name;
  double lat;
  double long;
  ImageOnMap markerIcon;

  Users({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.markerIcon,
  });
}


    // List<Users> user = [
    //   Users(
    //       name: "User1",
    //       lat: 51.542621,
    //       long: -0.229264,
    //       markerIcon: await ImageOnMap(
    //           imagePath: "assets/images/map_avatar/avatar1.png")),
    //   Users(
    //       name: "User2",
    //       lat: 51.4818554844363,
    //       long: -0.05999151456801342,
    //       markerIcon: await ImageOnMap(
    //           imagePath: "assets/images/map_avatar/avatar1.png")),
    //   Users(
    //       name: "User3",
    //       lat: 51.53848164433895,
    //       long: -0.13616407981031375,
    //       markerIcon: await ImageOnMap(
    //           imagePath: "assets/images/map_avatar/avatar1.png")),
    //   Users(
    //       name: "User4",
    //       lat: 51.49634794599104,
    //       long: -0.1361640798103137,
    //       markerIcon: await ImageOnMap(
    //           imagePath: "assets/images/map_avatar/avatar1.png")),
    //   Users(
    //       name: "User5",
    //       lat: 51.49634794599104,
    //       long: -0.11500503390967486,
    //       markerIcon: await ImageOnMap(
    //           imagePath: "assets/images/map_avatar/avatar1.png")),
    //   Users(
    //       name: "User6",
    //       lat: 51.696136047488054,
    //       long: -0.30543644701542555,
    //       markerIcon: await ImageOnMap(
    //           imagePath: "assets/images/map_avatar/avatar1.png")),
    //   Users(
    //       name: "User7",
    //       lat: 51.609931902918824,
    //       long: -0.007012130784009968,
    //       markerIcon: await ImageOnMap(
    //           imagePath: "assets/images/map_avatar/avatar1.png")),
    //   Users(
    //       name: "User8",
    //       lat: 51.478341466653156,
    //       long: -0.31248946231563857,
    //       markerIcon: await ImageOnMap(
    //           imagePath: "assets/images/map_avatar/avatar1.png")),
    //   Users(
    //       name: "User9",
    //       lat: 51.43087572331702,
    //       long: -0.1982306144521881,
    //       markerIcon: await ImageOnMap(
    //           imagePath: "assets/images/map_avatar/avatar1.png")),
    // ];
