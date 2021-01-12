import 'package:flutter/material.dart';
import 'package:flutter_nav2_test/constant/constant.dart';
import 'package:flutter_nav2_test/entity/book.dart';
import 'package:flutter_nav2_test/route/auth_route.dart';
import 'package:flutter_nav2_test/route/book_details_route.dart';
import 'package:flutter_nav2_test/route/book_list_route.dart';
import 'package:flutter_nav2_test/route/unknown_route.dart';
import 'package:flutter_nav2_test/route_config/book_route_path.dart';
import 'package:flutter_nav2_test/route_config/no_animation_transition_delegate.dart';

// final pages = [
//   MaterialPage(
//     key: ValueKey('BooksListPage'),
//     //child 是个widget
//     child: BooksListRoute(
//       books: books,
//       onTapped: _handleBookTapped,
//     ),
//   ),
//   //从这开始后面的会覆盖到前一个MaterialPage之上
//   if (show404)
//     MaterialPage(key: ValueKey('UnknownPage'), child: UnknownRoute())
//   else if (_selectedBook != null)
//     // BookDetailsPage(book: _selectedBook)
//     MaterialPage(
//         key: ValueKey(_selectedBook),
//         child: BookDetailsRoute(
//           book: _selectedBook,
//         ))
// ];

///路由规则代理，用来配置路由规则
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Book _selectedBook;
  bool show404 = false;
  bool showAuth = false;

  @override
  BookRoutePath get currentConfiguration {
    if (show404) {
      return BookRoutePath.unknown();
    }
    return _selectedBook == null
        ? BookRoutePath.home()
        : BookRoutePath.details(books.indexOf(_selectedBook));
  }

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        transitionDelegate: NoAnimationTransitionDelegate(),
        //pages是自定义的路由栈，遵循后进先出法则，后进的会覆盖先进的，并且先进的不会被释放而且能保存状态
        pages: [
          MaterialPage(
            key: ValueKey('BooksListPage'),
            //child 是个widget
            name: '书籍列表',
            child: BooksListRoute(
              books: books,
              onTapped: _handleBookTapped,
            ),
          ),
          //从这开始后面的会覆盖到前一个MaterialPage之上
          if (show404)
            MaterialPage(key: ValueKey('UnknownPage'), child: UnknownRoute())
          else if (_selectedBook != null)
            // BookDetailsPage(book: _selectedBook)
            MaterialPage(
                key: ValueKey(_selectedBook),
                child: BookDetailsRoute(
                  book: _selectedBook,
                ),
                arguments: _selectedBook),

          if (showAuth) MaterialPage(key: ValueKey('Auth'), child: Auth())
        ],
        //onPopPage必须写，当子页面Navigator.pop调用时会回调这里
        onPopPage: (route, result) {
          //可以用route.didPop()判断自页面是否pop成功。那么问题来了，什么时候会返回失败呢？当然是pop被拦截的时候了。
          if (!route.didPop(result)) {
            return false;
          }

          // Update the list of pages by setting _selectedBook to null
          _selectedBook = null;
          show404 = false;
          showAuth = false;

          //由于不是个widget，所以不能setState(){}，改用notifyListeners，那么原理就大概知道了
          notifyListeners();

          return true;
        },
      );

  ///新页面打开时回调这里，传递的path是[BookRouteInformationParser]的[parseRouteInformation]返回的
  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    if (path.isUnknown) {
      _selectedBook = null;
      show404 = true;
      return;
    }

    if (path.isDetailsPage) {
      if (path.id < 0 || path.id > books.length - 1) {
        show404 = true;
        return;
      }

      _selectedBook = books[path.id];
    } else {
      _selectedBook = null;
    }

    show404 = false;
  }

  void _handleBookTapped(Book book) {
    _selectedBook = book;
    notifyListeners();
  }
}
