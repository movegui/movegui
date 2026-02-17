import 'package:flutter/material.dart';

class HomeNavObserver extends NavigatorObserver {
  final ValueNotifier<bool> canPopNotifier;

  HomeNavObserver(this.canPopNotifier);

  void _update() {
    canPopNotifier.value = navigator?.canPop() ?? false;
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _update();
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _update();
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _update();
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _update();
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
