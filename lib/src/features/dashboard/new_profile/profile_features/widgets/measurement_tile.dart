import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/network/graphql_service.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class MeasusementTile extends ConsumerWidget {
  final String? title;
  final String? label;
  const MeasusementTile({Key? key, this.title, this.label}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);

    TextTheme theme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title!,
          style: theme.displayMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
            fontSize: 13.sp,
          ),
        ),
        addVerticalSpacing(3),
        Text(
          label!,
          style: theme.displayMedium!.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
