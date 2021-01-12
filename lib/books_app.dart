import 'package:flutter/material.dart';
import 'package:flutter_nav2_test/route_config/book_route_delegate.dart';
import 'package:flutter_nav2_test/route_config/book_route_information_parser.dart';

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Books App',
        routerDelegate: BookRouterDelegate(),
        routeInformationParser: BookRouteInformationParser(),
      );
}
