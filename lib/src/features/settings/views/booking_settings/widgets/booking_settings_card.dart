import 'package:vmodel/src/vmodel.dart';

class VWidgetsBookingSettingsCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  const VWidgetsBookingSettingsCard(
      {required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              title!,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor),
            ),
            const Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
