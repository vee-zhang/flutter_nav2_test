import 'package:flutter/material.dart';
import 'package:flutter_nav2_test/entity/book.dart';

///可以用默认的MaterialPage，也可以自定义page
class BookDetailsPage extends Page {
  final Book book;

  BookDetailsPage({
    this.book,
  }) : super(key: ValueKey(book));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BookDetailsRoute(book: book);
      },
    );
  }
}

///书籍详情页面，只做了显示详情，无任何交互
class BookDetailsRoute extends StatelessWidget {
  final Book book;

  BookDetailsRoute({
    @required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}
