import 'package:flutter/material.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Reports",
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Stack(
                children: [
                  Card(
                    elevation: 2,
                    shadowColor: Theme.of(context).colorScheme.onBackground,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My App Crashed while I was using it",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          addVerticalSpacing(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 7,
                                child: Text(
                                  "The app crashed while I was attempting to visit my portfolio.The crash occurred immediately immediately immediately immediately",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 15,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          // color: Theme.of(context).colorScheme.onBackground,
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(3)),
                      child: Text(
                        index.isEven ? "RESOLVED" : "OPEN",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
