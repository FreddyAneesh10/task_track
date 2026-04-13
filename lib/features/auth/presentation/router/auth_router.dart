import 'package:go_router/go_router.dart';
import '../view/screens/login_view.dart';
import '../view/screens/signup_view.dart';

class AuthRouter {
  static const String login = '/login';
  static const String signup = '/signup';

  static List<RouteBase> routes = [
    GoRoute(
      path: login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: signup,
      builder: (context, state) => const SignupView(),
    ),
  ];
}
