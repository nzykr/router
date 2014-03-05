library router;

import 'dart:async';

part 'route.dart';
part 'context.dart';

class Router {
  List<Route> routes = [];

  Route route(String pathname, var callback) {
    Route route = new Route(pathname, callback);
    routes.add(route);
    return route;
  }

  // routes are run in order
  // to halt the execution a route can return a future that
  // completes with an error or throw an execption.
  dispatch(String pathname) {
    List<Route> handlers = routes.where((r) => r.matches(pathname)).toList();
    Context context = new Context(pathname);
    var d = Future.forEach(handlers, (handler) {
      var res = handler(context);
      return res;
    }).catchError((e) {
      print('handler threw an error');
      throw e;
    });
    return d;
  }

  go(String href) {
    Uri uri = Uri.parse(href);
    return dispatch(uri.path);
  }
}
