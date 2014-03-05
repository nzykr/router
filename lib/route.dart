part of router;

class Route {
  String pathname;
  Function callback;

  Route(this.pathname, this.callback);
  
  bool matches(String pathname) {
    return this.pathname == pathname;
  }

  call(Context ctx) {
    return callback(ctx);
  }
}

