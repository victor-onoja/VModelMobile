import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/guess_page/views/guess_page.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

import '../../../../shared/buttons/normal_back_button.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Games",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: ListView.separated(
        itemCount: 1,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: () {
                navigateToRoute(context, GuessPage());
              },
              child: Text("Guess Game",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        // color: Theme.of(context).primaryColor,
                      )),
            ),
          );
        },
      ),
    );
  }
}
