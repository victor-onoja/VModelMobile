import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vmodel/src/features/booking/controller/booking_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar_title_text.dart';
import 'package:vmodel/src/core/utils/shared.dart';

class BookingSettingsOptions extends StatelessWidget {
  const BookingSettingsOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookingController controller = Get.put(BookingController());
    return Scaffold(
      appBar: AppBar(
        title: const VWidgetsAppBarTitleText(titleText: "Price"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const VWidgetsBackButton(),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            child: GetBuilder<BookingController>(builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  addVerticalSpacing(5),
                  Row(
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text("Glamour",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                      )),
                      IconButton(
                        onPressed: () {
                          controller.decreaseGlamour();
                        },
                        icon: const Icon(Icons.remove_circle, size: 30),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          width: 150,
                          height: 50,
                          child: Center(
                            child: Text(
                              controller.glamour.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 17),
                            ),
                          )),
                      IconButton(
                        onPressed: () {
                          controller.increaseGlamour();
                        },
                        icon: const Icon(Icons.add_circle_rounded, size: 30),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text("Comercial",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                      )),
                      IconButton(
                        onPressed: () {
                          controller.decreaseCmercial();
                        },
                        icon: const Icon(Icons.remove_circle, size: 30),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          width: 150,
                          height: 50,
                          child: Center(
                            child: Text(
                              controller.cmercial.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 17),
                            ),
                          )),
                      IconButton(
                        onPressed: () {
                          controller.increaseCmercial();
                        },
                        icon: const Icon(Icons.add_circle_rounded, size: 30),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text("Fashion",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                      )),
                      IconButton(
                        onPressed: () {
                          controller.decreaseFashion();
                        },
                        icon: const Icon(Icons.remove_circle, size: 30),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          width: 150,
                          height: 50,
                          child: Center(
                            child: Text(
                              controller.fashion.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 17),
                            ),
                          )),
                      IconButton(
                        onPressed: () {
                          controller.increaseFashion();
                        },
                        icon: const Icon(Icons.add_circle_rounded, size: 30),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text("Food",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                      )),
                      IconButton(
                        onPressed: () {
                          controller.decreaseFood();
                        },
                        icon: const Icon(Icons.remove_circle, size: 30),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          width: 150,
                          height: 50,
                          child: Center(
                            child: Text(
                              controller.food.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          )),
                      IconButton(
                        onPressed: () {
                          controller.increaseFood();
                        },
                        icon: const Icon(Icons.add_circle_rounded, size: 30),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 200),
            child: vWidgetsInitialButton(() {}, "Done"),
          )
        ],
      ),
    );
  }
}
