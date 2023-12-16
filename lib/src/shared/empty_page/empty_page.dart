import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class EmptyPage extends StatelessWidget {
  // final String? title;
  final String svgPath;
  final String subtitle;
  final double svgSize;
  final bool shouldCenter;
  const EmptyPage(
      {required this.svgPath,
      required this.svgSize,
      //  this.title,
      required this.subtitle,
      super.key,
      this.shouldCenter = true});

  @override
  Widget build(BuildContext context) {
    return !shouldCenter
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  addVerticalSpacing(MediaQuery.of(context).size.width * 0.145),
                  // Icon(Icons.camera),
                  RenderSvg(
                    svgHeight: svgSize,
                    svgWidth: svgSize,
                    svgPath: svgPath,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.3),
                    // color: Theme.of(context).primaryColor.withOpacity(0.3),
                    // color: Colors.pink,
                  ),
                  // Text(
                  //   title!,
                  //   style: context.textTheme.headlineMedium!.copyWith(
                  //       color: context.theme.primaryColor, fontSize: 20.sp),
                  // ),
                  addVerticalSpacing(6),
                  // Text(
                  //   subtitle,
                  //   style: context.textTheme.displayLarge!
                  //       .copyWith(fontSize: 11.sp),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: context.textTheme.displayLarge!
                          .copyWith(fontSize: 11.sp),
                    ),
                  )
                ],
              ),
            ),
          )
        : LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              // physics: AlwaysScrollableScrollPhysics(),
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Container(
                height: constraints.maxHeight,
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // addVerticalSpacing(MediaQuery.of(context).size.width * 0.145),
                    // Icon(Icons.camera),
                    RenderSvg(
                      svgHeight: svgSize,
                      svgWidth: svgSize,
                      svgPath: svgPath,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.3),
                      // color: Colors.pink,
                    ),
                    // Text(
                    //   title!,
                    //   style: context.textTheme.headlineMedium!.copyWith(
                    //       color: context.theme.primaryColor, fontSize: 20.sp),
                    // ),
                    addVerticalSpacing(6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: context.textTheme.displayLarge!
                            .copyWith(fontSize: 11.sp),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
  }
}
