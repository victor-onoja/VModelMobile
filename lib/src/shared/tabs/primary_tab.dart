import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class VWidgetsTabs extends StatefulWidget {
  final List<String> tabItems;
  final List<Widget> tabViews;
  final double containerHeight;
  final double containerWidth;
  final double tabBarHeight;
  final double tabViewHeight;

  const VWidgetsTabs({
    super.key,
    required this.tabItems,
    required this.containerHeight,
    required this.containerWidth,
    required this.tabBarHeight,
    required this.tabViewHeight,
    required this.tabViews,
  });

  @override
  State<VWidgetsTabs> createState() => _VWidgetsTabsState();
}

class _VWidgetsTabsState extends State<VWidgetsTabs>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: widget.tabViews.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.tabItems.length == widget.tabViews.length);
    return Column(
      children: [
        SizedBox(
          height: widget.tabBarHeight,
          child: TabBar(
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                return states.contains(MaterialState.focused)
                    ? null
                    : Colors.transparent;
              },
            ),
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: Theme.of(context).textTheme.displayMedium,
            labelColor: VmodelColors.appBarBackgroundColor,
            labelStyle: Theme.of(context).textTheme.displayMedium,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Theme.of(context).primaryColor,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                )),
            controller: _tabController,
            tabs: widget.tabItems.map((e) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      width: 1.5,
                      color: Theme.of(context).primaryColor,
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 14.0,
                  ),
                  child: Text(e.toString()),
                ),
              );
            }).toList(),
          ),
        ),
        addVerticalSpacing(6),
        SizedBox(
          height: widget.tabViewHeight,
          child: TabBarView(
            controller: _tabController,
            children: widget.tabViews,
          ),
        )
      ],
    );
  }
}
