import '../../../../vmodel.dart';

class GalleryTabs extends StatelessWidget {
  const GalleryTabs({super.key, required this.tabs});
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: TabBar(
        labelColor: Theme.of(context).tabBarTheme.labelColor,
        labelStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor.withOpacity(1),
            ),
        // labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor:
            Theme.of(context).tabBarTheme.unselectedLabelColor,
        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontWeight: FontWeight.w500),
        indicatorColor: Theme.of(context).indicatorColor,
        isScrollable: true,
        tabs: tabs,
      ),
    );
  }
}
