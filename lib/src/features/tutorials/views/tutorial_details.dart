import 'package:vmodel/src/features/help_support/widgets/help_point.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class TutorialDetailsView extends StatelessWidget {
  final String helpDetailsTitle;
  const TutorialDetailsView({super.key, this.helpDetailsTitle = "Account settings"});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon:  VWidgetsBackButton(),
        
        appbarTitle: "Tutorials",
        appBarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const VWidgetsPagePadding.horizontalSymmetric(17),
          padding: const VWidgetsPagePadding.verticalSymmetric(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                helpDetailsTitle.toString(),
                style: theme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: Theme.of(context).primaryColor),
              ),
              addVerticalSpacing(16),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                style: theme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.5.sp,
                    color: Theme.of(context).primaryColor),
              ),
              addVerticalSpacing(10),
              const VWidgetsHelpDetailsPointTile(),
              const VWidgetsHelpDetailsPointTile(),
              addVerticalSpacing(20),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                style: theme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
