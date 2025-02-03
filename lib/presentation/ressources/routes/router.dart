import 'package:flutter/material.dart';
import 'package:reclamations/presentation/Authentication/ResetPassword/ResetPassword.dart';
import 'package:reclamations/presentation/Authentication/SignIn/SignIn.dart';
import 'package:reclamations/presentation/Authentication/SignUp/SignUp.dart';
import 'package:reclamations/presentation/SplashScreen/SplashScreen.dart';
import 'package:reclamations/presentation/admin/home_admin.dart';
import 'package:reclamations/presentation/client/home_client.dart';


class AppRouting {
  static final String splashScreen = "/";
  static final String signInScreen = "/sign_in";
  static final String resetPassword = "/reset_password";
  static final String signUp = "/sign_up";
  static final String adminHome = "/admin_home";
  static final String clientHome = "/client_home";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case "/sign_in":
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case "/reset_password":
        return MaterialPageRoute(builder: (_) => Resetpassword());
      case "/sign_up":
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case "/admin_home":
        return MaterialPageRoute(builder: (_) => HomeAdmin());
      case "/client_home":
        return MaterialPageRoute(builder: (_) => HomeClient());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
