import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'text_overlayed_image.dart';

class PostBoardsCard extends StatelessWidget {
  const PostBoardsCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });
  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // return TextOverlayedImage(
    //   size: widget.itemSize,
    //   imageUrl: '${widget.boards[index].coverImageUrl}',
    //   title: widget.boards[index].title,
    //   // imageProvider: AssetImage(
    //   //     widget.mockImages[index % widget.mockImages.length]),
    //   gradientStops: [0.75, 1],
    //   onTap: () {
    //     print('[lsox ${widget.boards[index].title} tapped navigating');

    //     ref.read(currentSelectedBoardProvider.notifier).setOrUpdateBoard(
    //           SelectedBoard(
    //             board: widget.boards[index],
    //             source: SelectedBoardSource.userCreatd,
    //           ),
    //         );
    //     navigateToRoute(
    //         context,
    //         ExploreV2(
    //           title: widget.boards[index].title,
    //           providerType: BoardProvider.userCreated,
    //           // userPostBoard: widget.boards[index],
    //         ));
    //   },
    //   onLongPress: () {},
    // );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: CachedNetworkImageProvider(image), fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 10, 10),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 1],
              colors: [Colors.transparent, Colors.black87],
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
