import 'package:flutter/material.dart';


class ContentPopMenu extends StatelessWidget {
  const ContentPopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      constraints: const BoxConstraints(
          maxWidth: 200, minWidth: 160
      ),
      // initialValue: 2,
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      color: const Color.fromRGBO(0, 0, 0, 0.3),
      child:  const Icon(Icons.more_vert, color: Color.fromRGBO(255, 255, 255, 0.8),),
      itemBuilder: (context) {
        return [

        const PopupMenuItem(
          value: 0,
          padding: EdgeInsets.all(0),
          child: PopItem(title: 'Explore',),
        ),

          const PopupMenuItem(
            value: 0,
            padding: EdgeInsets.all(0),
            child: PopItem(title: 'Models',),
          ),

          const PopupMenuItem(
            value: 0,
            padding: EdgeInsets.all(0),
            child: PopItem(title: 'Creators',),
          ),

          const PopupMenuItem(
            value: 0,
            padding: EdgeInsets.all(0),
            child: PopItem(title: 'Photographers',),
          ),

          const PopupMenuItem(
            value: 0,
            padding: EdgeInsets.all(0),
            child: PopItem(title: 'Pets', showLine: false,),
          ),
          const PopupMenuItem(
            value: 0,
            padding: EdgeInsets.all(0),
            child: PopItem(title: 'Commercial', showLine: false,),
          ),
        ];
      },

    );
  }
}


class PopItem extends StatelessWidget {
  const PopItem({Key? key, required this.title, this.showLine = true}) : super(key: key);
  final String title;
  final bool showLine;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white)),
        ),

        showLine ? Container(
          height: 2,
          color: const Color.fromRGBO(255, 255, 255, 0.3),
        ) : const SizedBox()
      ],
    );
  }
}
