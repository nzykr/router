import 'package:unittest/unittest.dart';
import 'package:router/router.dart';


void main() {

  group('Route', () {

    test('returns true when it matches the path', () {
      Route route = new Route('/test', () => null);
      expect(route.matches('/test'), isTrue);
    });

    test('calls its callback when it called', () {
      Route route = new Route('/test', expectAsync((Context ctx) {}));
      route(new Context('/test'));
    });
    
  });


  group('Router', () {

    test('registers a route', () {
      Router router = new Router();
      router.route('/test', () => null);

      expect(router.routes.length, equals(1));
    });

    test('runs all routes that mathces the path', () {
      Router router = new Router();

      var callback = expectAsync((ctx) => null, count:2);
      
      router.route('/test', callback);
      router.route('/test', callback);

      router.dispatch('/test');
    });
    
  });
}
