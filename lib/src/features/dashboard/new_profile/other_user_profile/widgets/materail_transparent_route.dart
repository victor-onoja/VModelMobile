import 'package:flutter/material.dart';

class MaterialTransparentRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  MaterialTransparentRoute({
    required this.builder,
    RouteSettings? settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder builder;
  // Color? barrierColor;
  // String? barrierLabel;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  bool get opaque => false;

  @override
  final bool maintainState;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  Color? get barrierColor => const Color(0x80000000);

  @override
  String? get barrierLabel => null;

  // @override
  // Widget buildPage(BuildContext context, Animation<double> animation,
  //     Animation<double> secondaryAnimation) {
  //   // TODO: implement buildPage
  //   throw UnimplementedError();
  // }

  // @override
  // // TODO: implement transitionDuration
  // Duration get transitionDuration => throw UnimplementedError();
}
