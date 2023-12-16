import 'package:flutter/material.dart';

class CounterAnimationTextState extends State<CounterAnimationText>
    with SingleTickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: Duration(milliseconds: widget.durationInMilliseconds),
        vsync: this);
    _animation = IntTween(begin: widget.begin, end: widget.end).animate(
        CurvedAnimation(parent: _animationController, curve: widget.curve));

    _animationController.forward();
  }

  /// The build method, which returns an [AnimatedBuilder], with the animation.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Text(_animation.value.toString(), style: widget.textStyle);
        });
  }
}

/// The animation class.
class CounterAnimationText extends StatefulWidget {
  final int begin; // The beginning of the int animation.
  final int end; // The the end of the int animation (result).
  final int durationInMilliseconds; // The duration of the animation.
  final Curve curve; // The curve of the animation (recommended: easeOut).
  final TextStyle textStyle; // The TextStyle.

  const CounterAnimationText(
      {required this.begin,
      required this.end,
      required this.durationInMilliseconds,
      required this.curve,
      required this.textStyle,
      super.key});

  @override
  CounterAnimationTextState createState() => CounterAnimationTextState();
}
