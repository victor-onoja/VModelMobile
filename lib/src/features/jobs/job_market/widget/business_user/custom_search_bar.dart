import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';

class FilterableList extends ConsumerStatefulWidget {
  final Function(String) onItemTapped;
  final double elevation;
  final double maxListHeight;
  final TextStyle suggestionTextStyle;
  final Widget? loader;
  final Color? suggestionBackgroundColor;
  final bool loading;
  final Widget Function(String data)? suggestionBuilder;

  const FilterableList(
      {Key? key,
      required this.onItemTapped,
      this.loader,
      this.suggestionBuilder,
      this.elevation = 5,
      this.maxListHeight = 150,
      this.suggestionTextStyle = const TextStyle(),
      this.suggestionBackgroundColor,
      this.loading = false})
      : super(key: key);

  @override
  ConsumerState<FilterableList> createState() => _FilterableListState();
}

class _FilterableListState extends ConsumerState<FilterableList> {
  String items = '';
  String? name = '';
  bool showCat = false;
  // String search = '';
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);

    Color suggestionBackgroundColor = widget.suggestionBackgroundColor ??
        scaffold?.widget.backgroundColor ??
        theme.scaffoldBackgroundColor;

    return Scaffold(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        body: SafeArea(
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(top: 80, right: 15, left: 15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromRGBO(80, 60, 59, 1),
                    )),
                child: TextFormField(
                  cursorColor: const Color.fromRGBO(39, 39, 39, 1),
                  style: const TextStyle(
                      color: Color.fromRGBO(39, 39, 39, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(80, 60, 59, 1), width: 5),
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          goBack(context);
                        },
                        child: const Icon(Icons.cancel,
                            color: Color.fromRGBO(80, 60, 59, 1))),
                    //focusedBorder: InputBorder.none,
                    // enabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(20),
                    //   borderSide: BorderSide(
                    //     color: const Color.fromRGBO(237, 239, 245, 1),
                    //   ),
                    // ),
                    //errorBorder: InputBorder.none,
                    //disabledBorder: InputBorder.none,
                    hintText: "search jobs",
                    hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(80, 60, 59, 1)),
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
