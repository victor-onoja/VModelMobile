import 'package:flutter/material.dart';
import 'package:vmodel/src/core/utils/size_config.dart';
import '../../../res/colors.dart';
import 'animation.dart';

class NewSplash extends StatelessWidget {
  const NewSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const AnimatedLogo(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: VmodelColors.mainColor),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    'BETA',
                    style: TextStyle(color: VmodelColors.mainColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
