import 'package:flutter/material.dart';

class VWidgetsReportOptionsTile extends StatefulWidget {
  final String optionTitle;
  final VoidCallback onTap;
  final bool isOptionSelected;
  const VWidgetsReportOptionsTile({
    super.key,
    required this.isOptionSelected,
    required this.optionTitle,
    required this.onTap,
  });

  @override
  State<VWidgetsReportOptionsTile> createState() =>
      _VWidgetsReportOptionsTileState();
}

class _VWidgetsReportOptionsTileState extends State<VWidgetsReportOptionsTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                widget.optionTitle,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    // color: VmodelColors.primaryColor,
                    ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Icon(
                  widget.isOptionSelected
                      ? Icons.radio_button_on_rounded
                      : Icons.radio_button_off_rounded,
                  size: 20,
                )),
          ],
        ),
      ),
    );
  }
}
