import 'package:flutter_html/flutter_html.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class HelpDetailsViewTwo extends StatelessWidget {
  final String? tutorialDetailsTitle;
  final String? tutorialDetailsDescription;
  const HelpDetailsViewTwo(
      {super.key, this.tutorialDetailsTitle, this.tutorialDetailsDescription});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Help and support",
        appBarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Container(
            // margin: const VWidgetsPagePadding.only(10, 10, 10),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  tutorialDetailsTitle.toString(),
                  style: theme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: Theme.of(context).primaryColor),
                ),
                addVerticalSpacing(16),
                Html(
                  data: "$tutorialDetailsDescription<br>",
                  style: {
                    "p": Style(
                      fontSize: FontSize(15),
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                      // padding: HtmlPaddings()
                    ),
                    "ol": Style(
                      fontSize: FontSize(15),
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                    "li": Style(
                      fontSize: FontSize(15),
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                      padding: HtmlPaddings(top: HtmlPadding(10)),
                    ),
                  },
                )
              ],
            )),
      ),
    );
  }
}

// Theme.of(context).textTheme.displayLarge!.copyWith(
//                         fontWeight: FontWeight.w500,
//                         color: Theme.of(context).primaryColor),