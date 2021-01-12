import 'package:flutter/material.dart';

///页面在路由时的过度动画
class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  ///markForPush ，打开页面时使用过渡动画。
  ///markForAdd，打开页面时不使用过渡动画。
  ///markForPop，弹出页面时使用动画，并通知应用，即将该事件传递给 AppRouterDelegate 的 onPopPage 函数。
  ///markForComplete ，弹出页面时不使用过渡动画，同样会通知应用。
  ///markForRemove ，弹出页面时不使用过渡动画，不会通知应用。
  @override
  Iterable<RouteTransitionRecord> resolve({
    List<RouteTransitionRecord> newPageRouteHistory,
    Map<RouteTransitionRecord, RouteTransitionRecord>
        locationToExitingPageRoute,
    Map<RouteTransitionRecord, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }

    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }

      results.add(exitingPageRoute);
    }
    return results;
  }
}
