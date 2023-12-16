import 'package:vmodel/src/vmodel.dart';

class VWidgetsRadioTile extends StatefulWidget {
  final String? title;
  final bool isSelected;
  final VoidCallback onTap;

  const VWidgetsRadioTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<VWidgetsRadioTile> createState() => _VWidgetsRadioTile();
}

class _VWidgetsRadioTile extends State<VWidgetsRadioTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title!,
                  style: widget.isSelected
                      ? Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            // color: VmodelColors.primaryColor,
                          )
                      : Theme.of(context).textTheme.displayMedium!.copyWith(
                            // color: VmodelColors.primaryColor.withOpacity(0.5),
                            // color:
                            //     Theme.of(context).primaryColor.withOpacity(0.5),
                            color: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.color
                                ?.withOpacity(0.5),
                          ),
                ),
                widget.isSelected
                    ? const Icon(
                        Icons.radio_button_checked_rounded,
                        // color: VmodelColors.primaryColor,
                      )
                    : Icon(
                        Icons.radio_button_off_rounded,
                        // color: VmodelColors.primaryColor.withOpacity(0.5),
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
              ],
            ),
            // const Divider(
            //   thickness: 1,
            // )
          ],
        ),
      ),
    );
  }
}
