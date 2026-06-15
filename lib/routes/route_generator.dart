import 'package:BrossScrum/pages/account/account_screen_page/account_screen.dart';
import 'package:BrossScrum/pages/account/give_feedback/give_feedback_page/give_feedback.dart';
import 'package:BrossScrum/pages/account/notification_setting/do_not_disturb/do_not_disturb.dart';
import 'package:BrossScrum/pages/account/notification_setting/notification_setting_page/notification_setting.dart';
import 'package:BrossScrum/pages/account/settings/theme/theme_page.dart';
import 'package:BrossScrum/pages/auth_pages/loginpage.dart';
import 'package:BrossScrum/pages/home_screen/home_screen/homeScreen.dart';
import 'package:BrossScrum/pages/home_screen/my_open_issue/my_open_issue.dart';
import 'package:BrossScrum/routes/app_route.dart';
import 'package:flutter/material.dart';

import '../pages/account/invite people/invite_people.dart';
import '../pages/account/settings/manage_account/manage_account_page.dart';
import '../pages/account/settings/settingsPage/settings.dart';
import '../pages/auth_pages/otp_page.dart';
import '../pages/auth_pages/recovery_page.dart';
import '../pages/auth_pages/signuppage.dart';
import '../pages/home_screen/dashboard/dashboard.dart';
import '../pages/home_screen/notifications/notifications_page.dart';
import '../pages/home_screen/spaces/spaces_screen/spaces_screen.dart';
import '../pages/intro/intro_page.dart';
import '../resources/navigation/bottom_navi_bar.dart';



class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings setting){
    final args = setting.arguments;
    switch(setting.name){
      case AppRoute.intro:
        return MaterialPageRoute(builder: (_) => const IntroPage());
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
      case AppRoute.donotdisturb:
        return MaterialPageRoute(builder: (_) => const DoNotDisturbPage());
      case AppRoute.setting:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case AppRoute.theme:
        return MaterialPageRoute(builder: (_) => const ThemePage());
      case AppRoute.manageaccount:
        return MaterialPageRoute(builder: (_) => const ManageAccountPage());
      case AppRoute.invitepeople:
        return MaterialPageRoute(builder: (_) => const InviteContactPage());
      case AppRoute.feedback:
        return MaterialPageRoute(builder: (_) => const SendFeedbackPage());
      case AppRoute.notification:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case AppRoute.bottonnavibar:
        return MaterialPageRoute(builder: (_) => const BottomNaviBarPage());
      case AppRoute.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardsScreen());
      case AppRoute.spaces:
        return MaterialPageRoute(builder: (_) => const SpacesScreen() );
      case AppRoute.myopenissue:
        return MaterialPageRoute(builder: (_) => const MyOpenIssue());

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