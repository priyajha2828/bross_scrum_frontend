import 'package:BrossScrum/pages/account/account_screen.dart';
import 'package:BrossScrum/pages/account/notification_setting/notification_setting.dart';
import 'package:BrossScrum/pages/auth_pages/loginpage.dart';
import 'package:BrossScrum/pages/home_screen/homeScreen.dart';
import 'package:BrossScrum/routes/app_route.dart';
import 'package:flutter/material.dart';

import '../pages/auth_pages/otp_page.dart';
import '../pages/auth_pages/recovery_page.dart';
import '../pages/auth_pages/signuppage.dart';


class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings setting){
    final args = setting.arguments;
    switch(setting.name){
      case AppRoute.login :
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoute.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case AppRoute.recovery:
        return MaterialPageRoute(builder: (_) => const RecoveryPage());
      case AppRoute.otp:
        return MaterialPageRoute(builder: (_)=> const OtpPage());
      case AppRoute.homescreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoute.accountscreen:
        return MaterialPageRoute(builder: (_) => const AccountScreen());
      case AppRoute.notificationsetting:
        return MaterialPageRoute(builder: (_) => const NotificationsPage());

        default:
          return _errorRoute();
    }
  }

  static Route<dynamic>_errorRoute(){
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(title: const Text("Route Error")),
      body: const Center(child: Text("page not found!")),
    )
    );
  }
}