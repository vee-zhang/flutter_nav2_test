import 'package:flutter/material.dart';
import 'package:flutter_nav2_test/route_config/book_route_path.dart';

///RouteInformationParser 内部含有一个钩子函数，接受路由信息（RouteInformation），我们可以在这里将它转换成指定的数据类型（BookRoutePath）并使用 Uri 解析：
class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  ///我就是上面说的钩子函数，程序启动时会回调一次，而且路径是/，之后不管怎么玩路由都不再起作用
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return BookRoutePath.home();
    }

    // Handle '/book/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'book') return BookRoutePath.unknown();
      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null) return BookRoutePath.unknown();
      return BookRoutePath.details(id);
    }

    // Handle unknown routes
    return BookRoutePath.unknown();
  }

  ///push和pop之后都会回调这里
  @override
  RouteInformation restoreRouteInformation(BookRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/book/${path.id}');
    }
    return null;
  }
}
