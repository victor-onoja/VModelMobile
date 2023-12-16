import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class MostViewdAlbum extends ConsumerStatefulWidget {
  const MostViewdAlbum({super.key});

  @override
  ConsumerState<MostViewdAlbum> createState() => _MostViewdAlbumState();
}

class _MostViewdAlbumState extends ConsumerState<MostViewdAlbum> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return SizedBox(
          height: SizerUtil.height * 0.21,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 9 / 4),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // height: 50,
                // width: 50,
                color: Colors.red,
              );
            },
          ),
        );
      },
    );
  }
}

// child: ListView.builder(
      //     scrollDirection: Axis.horizontal,
      //     padding: const EdgeInsets.symmetric(horizontal: 12),
      //     // itemCount: items.length,
      //     itemCount: 5,
      //     itemBuilder: (BuildContext context, int index) {
      //       return GridView.builder(
      //         itemCount: 4,
      //         gridDelegate:
      //             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      //         itemBuilder: (BuildContext context, int index) {},
      //       );
      //     }),
