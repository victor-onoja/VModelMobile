import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../res/res.dart';
import '../controller/cropped_data_controller.dart';

// class CroppingStack extends ConsumerStatefulWidget {
//   const CroppingStack(
//       {super.key, required this.views, required this.currentIndex});
//   final List<Widget> views;
//   final int currentIndex;
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CroppingStackState();
// }
//
class CroppingStack extends ConsumerWidget {
  const CroppingStack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelectedIndex = ref.watch(stackIndexProvider);
    final croppedWidgetState = ref.watch(croppedWidgetsProvider);
    print('IIIIIIIIIIInndexx state is rebuilding...');
    if (croppedWidgetState.isEmpty) {
      return Container(
        color: Colors.grey.withOpacity(0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const RenderSvgWithoutColor(
              //   svgHeight: 100,
              //   svgWidth: 100,
              //   svgPath: VIcons.roundedCloseIcon,
              // ),
              // addVerticalSpacing(6),
              Text(
                "Select media".toUpperCase(),
                style: context.textTheme.displayLarge!
                    .copyWith(fontSize: 12.sp,

                  color: VmodelColors.white,
                ),
              )
            ],
          ),
        ),
      );
    }
    return IndexedStack(
        alignment: Alignment.center,
        // index: widget.currentIndex,
        index: currentSelectedIndex,
        children: croppedWidgetState.map((e) => e.cropView).toList());
  }
}
