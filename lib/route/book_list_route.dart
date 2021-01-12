import 'package:flutter/material.dart';
import 'package:flutter_nav2_test/entity/book.dart';

///书籍列表页面，通过传递过来的onTapped回调父级刷新路由
class BooksListRoute extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTapped;
  final VoidCallback onAuthd;

  BooksListRoute(
      {@required this.books, @required this.onTapped, @required this.onAuthd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [RaisedButton(onPressed: onAuthd, child: Text('auth'))],
      ),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            )
        ],
      ),
    );
  }
}
