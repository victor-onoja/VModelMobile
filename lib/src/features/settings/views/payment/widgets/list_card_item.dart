import 'package:flutter/cupertino.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class ListCardItem extends StatelessWidget {
  final String cardName;
  final String owner;
  final String exp;
  final bool isDefault;
  final bool isEditable;
  final ValueChanged<bool> onSwitch;
  final Function onTap;

  const ListCardItem(
      {Key? key,
      required this.cardName,
      required this.owner,
      required this.exp,
      required this.isDefault,
      required this.onSwitch,
      required this.isEditable,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[100],
      child: Row(
        children: [
          if (isEditable)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                child: const Icon(Icons.circle, color: Colors.red),
                onTap: () => onTap(),
              ),
            ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cardName,
                    style: descriptionTextStyle.copyWith(
                        fontWeight: FontWeight.w600),
                  ),
                  Image.asset('assets/images/master_card.png')
                ],
              ),
              addVerticalSpacing(8),
              Text(
                owner,
                style: descriptionTextStyle.copyWith(
                    color: VmodelColors.darkGreyColor),
              ),
              addVerticalSpacing(4),
              Text(
                'Exp: $exp',
                style: descriptionTextStyle.copyWith(
                    color: VmodelColors.darkGreyColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Set as a default card',
                    style: descriptionTextStyle,
                  ),
                  CupertinoSwitch(
                    value: isDefault,
                    onChanged: (v) => onSwitch(v),
                  )
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
