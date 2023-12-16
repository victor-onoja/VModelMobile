import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
import '../../../../vmodel.dart';

class ServiceSortBottomSheet extends ConsumerStatefulWidget {
  const ServiceSortBottomSheet({
    Key? key,
    required this.onSelectSort,
    required this.sortByList,
  }) : super(key: key);
  final void Function(int index) onSelectSort;
  final List<Map<String, dynamic>> sortByList;

  @override
  ConsumerState<ServiceSortBottomSheet> createState() =>
      _JobMarketFilterBottomSheetState();
}

class _JobMarketFilterBottomSheetState
    extends ConsumerState<ServiceSortBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        separatorBuilder: (context, index) =>
            Divider(thickness: 0.5, height: 20),
        itemCount: widget.sortByList.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              VWidgetsBottomSheetTile(
                onTap: () => widget.onSelectSort(index),
                message: widget.sortByList[index]['sort'],
              ),
              IconButton(
                onPressed: () => widget.onSelectSort(index),
                icon: widget.sortByList[index]["selected"]
                    ? const Icon(
                        Icons.radio_button_checked_rounded,
                        // color: VmodelColors.primaryColor,
                      )
                    : Icon(
                        Icons.radio_button_off_rounded,
                        // color: VmodelColors.primaryColor.withOpacity(0.5),
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
