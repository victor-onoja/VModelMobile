import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class FilterGenders extends StatefulWidget {
  const FilterGenders({Key? key}) : super(key: key);

  @override
  State<FilterGenders> createState() => _FilterGendersState();
}

class _FilterGendersState extends State<FilterGenders> {
  bool maleSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: VmodelColors.primaryColor,
              ),
        ),
        addVerticalSpacing(8),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  maleSelected = true;
                });
              },
              child: Container(
                height: 37,
                width: 59,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: maleSelected
                      ? VmodelColors.primaryColor
                      : VmodelColors.white,
                  border: Border.all(
                    width: 1,
                    color: VmodelColors.primaryColor,
                  ),
                ),
                child: Center(
                    child: Text(
                  "Male",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 14,
                        fontWeight:
                            maleSelected ? FontWeight.w700 : FontWeight.w500,
                        color: maleSelected
                            ? VmodelColors.white
                            : VmodelColors.primaryColor,
                      ),
                )),
              ),
            ),
            addHorizontalSpacing(10),
            GestureDetector(
              onTap: () {
                setState(() {
                  maleSelected = false;
                });
              },
              child: Container(
                height: 37,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: !maleSelected
                      ? VmodelColors.primaryColor
                      : VmodelColors.white,
                  border: Border.all(
                    width: 1,
                    color: VmodelColors.primaryColor,
                  ),
                ),
                child: Center(
                    child: Text("Female",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 14,
                                  fontWeight: maleSelected
                                      ? FontWeight.w500
                                      : FontWeight.w700,
                                  color: maleSelected
                                      ? VmodelColors.primaryColor
                                      : VmodelColors.white,
                                ))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
