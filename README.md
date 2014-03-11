router
======

Minimal client router for dart.

Routes run in order, they get a context with an environment map passed to them, they can modify it to pass data to other routes.

To halt execution, they can return a future that completes with an error, or throw an exception.


## Example

```
  import 'package:router/router.dart';
  import 'dart:async';
  
  Router router = new Router();
  
  // get images
  router.route('/images', (context) {
    Completer completer = new Completer();
    request('/images.json')
      .then((res) {
        context.env['images'] = res.body
        completer.complete(res.body);
        })
    return completer.future;
  });
    
  // render images
  router.route('/images', (context) {
    var view = new ImagesView(context.env['images']);
    view.render();
  });
  
    
  // stop executing routes if no user if logged in
  router.route('/admin', (context) {
    if (!user.isAdmin()) {
      throw Unauthorized();
    }
  });
  
  
  // catch the error
  router.error((error, context) {
    if (error is Unautorized) {
      renderError();
    }
  });
  
```
  
