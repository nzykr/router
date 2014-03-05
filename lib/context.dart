part of router;


class Context {
    String pathname;
    // routes can change this to pass data to other routes.
    Map env = {};
    Context(this.pathname);
}
