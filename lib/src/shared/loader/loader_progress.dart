import 'dart:async';

import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';

class LoaderProgress extends StatefulWidget {
  const LoaderProgress({
    super.key,
    required this.done,
    required this.loading,
  });

  final bool done;
  final bool loading;

  static Future<void> changeLoadingState({
    required bool loadingState,
    required bool doneState,
  }) async {
    if (loadingState) {
      print("object");
      LoaderProgress(done: doneState, loading: loadingState);
    } else {
      await Future.delayed(Duration(seconds: 3), () async {});
      Navigator.pop(AppNavigatorKeys.instance.navigatorKey.currentContext!);
    }
  }

  @override
  State<LoaderProgress> createState() => _LoaderProgressState();
}

class _LoaderProgressState extends State<LoaderProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = new Tween<double>(begin: 0, end: 1).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.done) {
      _animationController.forward();
    }
    return Center(
      child: Container(
        height: 90,
        width: 90,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Stack(
            children: [
              Center(
                child: CircularProgressIndicator(
                  value: widget.loading ? null : 100,
                ),
              ),
              Center(
                child: AnimatedCheck(
                  progress: _animation,
                  size: 50,
                  strokeWidth: 3,
                  color: Colors.green[400],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
