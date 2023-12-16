import 'package:vmodel/src/vmodel.dart';

class Polaroid3 extends StatelessWidget {
  const Polaroid3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.zero,
        // mainAxisSpacing: 7,
        // // crossAxisSpacing: 2,
        // crossAxisCount: 2,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/models/bitmap3.png',
                  // height: 296,
                  //width: 20,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
                Image.asset(
                  'assets/images/models/bitmap4.png',
                  // height: 296,
                  //width: 20,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
                Image.asset(
                  'assets/images/models/bitmap5.png',
                  // height: 296,
                  // width: 150,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/models/bitmap6.png',
                  // height: 296,
                  // width: 150,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
                Image.asset(
                  'assets/images/models/bitmap7.png',
                  // height: 296,
                  //width: 20,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
                Image.asset(
                  'assets/images/models/bitmap8.png',
                  // height: 296,
                  //width: 20,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/models/bitmap9.png',
                  // height: 296,
                  //width: 20,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
                Image.asset(
                  'assets/images/models/bitmap10.png',
                  // height: 296,
                  //width: 20,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
                Image.asset(
                  'assets/images/models/bitmap11.png',
                  // height: 296,
                  //width: 20,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/models/bitmap12.png',
                  // height: 296,
                  //width: 20,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
                Image.asset(
                  'assets/images/models/bitmap13.png',
                  // height: 296,
                  //width: 20,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
                Image.asset(
                  'assets/images/models/bitmap14.png',
                  // height: 296,
                  //width: 20,
                  height: 205.h,
                  fit: BoxFit.fitHeight,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ]);
  }
}
