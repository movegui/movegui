import 'package:flutter/material.dart';

class HomeNavObserver extends NavigatorObserver {
  final ValueNotifier<bool> canPopNotifier;
  final Function(String routeName)? onRouteChanged;
  HomeNavObserver(this.canPopNotifier, {this.onRouteChanged,});

  void _update(Route<dynamic>? route) {
    canPopNotifier.value = navigator?.canPop() ?? false;
    if (route != null && onRouteChanged != null) {
      onRouteChanged!(route.settings.name ?? '');
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _update(route);
    super.didPush(route, previousRoute);

  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _update(previousRoute);
    super.didPop(route, previousRoute);

  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _update(route);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _update(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

}
