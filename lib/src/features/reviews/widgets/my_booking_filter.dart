import 'package:flutter/material.dart';

class MyBookingFilter extends StatelessWidget {
  const MyBookingFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
            child: const  Text("Radio PopupMenuBotton"),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("Android"),
                    Radio(
                      activeColor: Colors.pink,
                      groupValue: 1,
                      onChanged: ( i) {},
                      value: 1,
                    ),
                    
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("Flutter"),
                    Radio(
                      groupValue: 1,
                      onChanged: ( i) {},
                      value: 1,
                    ),
     
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("Dart"),
                    Radio(
                      groupValue: 1,
                      onChanged: ( i) {},
                      value: 1,
                    ),
                   
                  ],
                ),
              ),
            ],
          );
  }
}