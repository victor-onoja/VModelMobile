import 'package:vmodel/src/features/dashboard/discover/widget/discover_photo_search_bottomsheet.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class DiscoverPhotoSearchPage extends StatefulWidget {
  const DiscoverPhotoSearchPage({super.key});

  @override
  State<DiscoverPhotoSearchPage> createState() =>
      _DiscoverPhotoSearchPageState();
}

class _DiscoverPhotoSearchPageState extends State<DiscoverPhotoSearchPage>
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
    return Scaffold(
      appBar: const VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(), appbarTitle: "Photo Search"),
      
      body: Stack(children: [
          //Image.asset("name"),
         Align(
          alignment: Alignment.bottomCenter,
          child: _showModalBottomSheet()
          ),

        // _showModalBottomSheet(),
      ]),
    );
  }

  Widget _showModalBottomSheet() => DraggableScrollableSheet(

        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.5,
  
        builder: (BuildContext context, ScrollController scrollController) => Padding(
            padding: const EdgeInsets.fromLTRB(12,25,12,0),
            child: 
            
            GridView.builder(
              scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: MediaQuery.of(context).size.height / 2.65,
                  maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: assets["models"]!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return VWidgetsPhotoSearchCard(
                    onTap: () {},
                    hashtags: const ["#Face", "#Glamour", "#Runway",],
                    image: assets["models"]![index],
                    profileImage: assets["models"]![index],
                    profileName: "Samantha",
                  );
                }),
                ),
      );
}
