import 'package:shimmer/shimmer.dart';
import 'package:vmodel/src/vmodel.dart';


class PostShimmerPage extends StatelessWidget {
  const PostShimmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: Shimmer.fromColors(
        // baseColor: const Color(0xffD9D9D9),
        // highlightColor: const Color(0xffF0F1F5),
        baseColor: Theme.of(context).colorScheme.surfaceVariant,
        highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
        // baseColor: Colors.blue,
        // highlightColor: Colors.purple,
        child: Container(
          color: Color(0xFF303030),
          // child: SizedBox(height: 24),
        ),
      ),
    );
  }
}
