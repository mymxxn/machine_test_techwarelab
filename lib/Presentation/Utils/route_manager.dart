import 'package:machine_test_techware/Presentation/View/Product/product_list_screen.dart';
import 'package:machine_test_techware/Presentation/View/pin_login_screen.dart';
import 'package:machine_test_techware/Presentation/View/registeration_screen.dart';
import 'package:machine_test_techware/Presentation/View/sign_in_screen.dart';
import 'package:machine_test_techware/Presentation/View/splash_screen.dart';

class RouteManager {
  static const String splashScreen = '/splash';
  static const String registerationScreen = '/registeration';
  static const String signInScreen = '/signIn';
  static const String pinLoginScreen = '/pinLogin';
  static const String homeScreen = '/home';
  static final routes = {
    splashScreen: (context) => SplashScreen(),
    registerationScreen: (context) => RegisterationScreen(),
    signInScreen: (context) => SignInScreen(),
    pinLoginScreen: (context) => PinLogin(),
    homeScreen: (context) => ProductListScreen(),
  };
}
