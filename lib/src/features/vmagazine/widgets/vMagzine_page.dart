import 'package:video_player/video_player.dart';
import 'package:vmodel/src/vmodel.dart';


class VWidgetsVmagazinePage extends StatefulWidget {
  final String? magazineText;
  final String? magazineImages;
  final Color? textColor;

  const VWidgetsVmagazinePage({
    this.magazineText,
    this.magazineImages,
    this.textColor,
    super.key});

  @override
  State<VWidgetsVmagazinePage> createState() => _VWidgetsVmagazinePageState();
}

class _VWidgetsVmagazinePageState extends State<VWidgetsVmagazinePage> {

  late VideoPlayerController _videoController;
  playVideo(String video) {
    _videoController = VideoPlayerController.asset(video)
      ..initialize().then((_) {
        _videoController.setLooping(false);
        _videoController.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          
          Image.asset(
          widget.magazineImages!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 30.h,
          ),
          // SizedBox(
          //   height: 30.h,
          
          //   child: playVideo("assets/videos/ins3.mp4"),
          // ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.magazineText!,
              style : Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: widget.textColor,
                          fontWeight: FontWeight.w500,
                        ),
              ),
          ),
        ],
      ),
    );
  }
}