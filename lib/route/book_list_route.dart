import 'package:flutter/material.dart';
import 'package:flutter_nav2_test/entity/book.dart';
import 'package:url_launcher/url_launcher.dart';

///书籍列表页面，通过传递过来的onTapped回调父级刷新路由
class BooksListRoute extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTapped;

  BooksListRoute({@required this.books, @required this.onTapped});

  final client_id =
      '77a05f59086ffbc86109c4c2a4456e498c3bca2452ec4c499a23d1412649cfb3';

  final redirect_uri = 'http://flutterbooksample.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [RaisedButton(onPressed: _auth, child: Text('auth'))],
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

  _auth() {
    launch(
        'https://gitee.com/oauth/authorize?client_id=${client_id}&redirect_uri=${redirect_uri}&response_type=code');
  }
}
