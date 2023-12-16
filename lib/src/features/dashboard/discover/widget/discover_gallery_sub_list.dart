import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';

class DiscoverGallerySubList extends ConsumerWidget {
  // final String title;
  // final List<DiscoverItemObject> items;
  // final bool? eachUserHasProfile;
  // final Widget? route;
  // final ValueChanged onTap;
  // final VoidCallback? onViewAllTap;
  final List<String> imageList;
  const DiscoverGallerySubList({
    Key? key,
    required this.imageList,
    // required this.items,
    // required this.onTap,
    // this.onViewAllTap,
    // this.eachUserHasProfile = false,
    // this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVerticalSpacing(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Text(
            "Popular Galleries",
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        addVerticalSpacing(10),
        Container(
          height: SizerUtil.height * 0.3,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  width: SizerUtil.height * 0.26,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: [
                      for (var index = 0; index < 4; index++)
                        Container(
                          height: 110,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: index == 0
                                  ? Radius.circular(10)
                                  : Radius.circular(0),
                              topRight: index == 1
                                  ? Radius.circular(10)
                                  : Radius.circular(0),
                              bottomLeft: index == 2
                                  ? Radius.circular(10)
                                  : Radius.circular(0),
                              bottomRight: index == 3
                                  ? Radius.circular(10)
                                  : Radius.circular(0),
                            ),
                            child: Image.asset(imageList[index],
                                fit: BoxFit.cover),
                          ),
                        ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
