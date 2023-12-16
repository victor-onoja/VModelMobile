
import 'package:flutter/cupertino.dart';
import 'package:vmodel/src/res/typography/textstyle.dart';



  Route<void> _modalBuilder(BuildContext context, Object? arguments) {
  return CupertinoModalPopupRoute<void>(builder: (BuildContext context) {
    return CupertinoActionSheet(
      // title: Text(''),
      // message: Text(''),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            'Edit',
            style: VmodelTypography2.kTitleStyle
          ),
          onPressed: () {
            Navigator.of(context).pop('Edit');
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Share', style: VmodelTypography2.kTitleStyle),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Save', style:VmodelTypography2.kTitleStyle),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Send', style: VmodelTypography2.kTitleStyle),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Archive', style: VmodelTypography2.kTitleStyle),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child:
          Text('Make portfolio main photo', style: VmodelTypography2.kTitleStyle),
          onPressed: () {
            _showActionSheet2(context);
          },
        ),
        CupertinoActionSheetAction(
          child:
          Text('Make polaroid main photo', style: VmodelTypography2.kTitleStyle),
          onPressed: () {
            _showActionSheet(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
              'delete',
              style: VmodelTypography2.kTitleStyle
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],

      cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
              style: VmodelTypography2.kTitleStyle
          )),
    );
  });
}

void _showActionSheet(BuildContext context) {
  showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              'follow user',
              style: VmodelTypography2.kTitleStyle
            ),
            onPressed: () {
              Navigator.of(context).pop('');
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
                'Thumbs up',
                style: VmodelTypography2.kTitleStyle
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
                'Save',
                style: VmodelTypography2.kTitleStyle
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
                'Post a comment',
                style: VmodelTypography2.kTitleStyle
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
                'Share',
                style: VmodelTypography2.kTitleStyle
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
                'Save',
           style: VmodelTypography2.kTitleStyle,
              ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
                'Send',
                style: VmodelTypography2.kTitleStyle
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
                'Message user',
                style: VmodelTypography2.kTitleStyle
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
                'Book user',
                style: VmodelTypography2.kTitleStyle
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
                'Report photo',
                style: VmodelTypography2.kTitleStyle
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
                style: VmodelTypography2.kTitleStyle
            )),
      ));
}

void _showActionSheet2(BuildContext context) {
  showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                    'unfollow user',
                    style: VmodelTypography2.kTitleStyle
                ),
                onPressed: () {
                  Navigator.of(context).pop('');
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                    'Remove Thumbs up',
                    style: VmodelTypography2.kTitleStyle
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                    'View comments',
                    style: VmodelTypography2.kTitleStyle
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                    'Share',
                    style: VmodelTypography2.kTitleStyle
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                    'Save',
                    style: VmodelTypography2.kTitleStyle
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                    'Send',
                    style: VmodelTypography2.kTitleStyle
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                    'Message model',
                    style: VmodelTypography2.kTitleStyle
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                    'Book model',
                    style: VmodelTypography2.kTitleStyle
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                    'Report photo',
                    style: VmodelTypography2.kTitleStyle
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                    'Cancel',
                    style: VmodelTypography2.kTitleStyle
                )),
          ));
}