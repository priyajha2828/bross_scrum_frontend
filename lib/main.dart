import 'package:BrossScrum/pages/auth_pages/splash_screen.dart';
import 'package:BrossScrum/providers/account_screen_provider/account_screen/account_screen_provider.dart';
import 'package:BrossScrum/providers/account_screen_provider/feedback/feedback_page_provider.dart';
import 'package:BrossScrum/providers/account_screen_provider/invite_people/invite_people_provider.dart';
import 'package:BrossScrum/providers/account_screen_provider/notification_settings_provider/donotdisturb_provider/donotdisturb_provider.dart';
import 'package:BrossScrum/providers/account_screen_provider/notification_settings_provider/notification_setting/notification_settings_provider.dart';
import 'package:BrossScrum/providers/account_screen_provider/settings/manage_account/manage_account_provider.dart';
import 'package:BrossScrum/providers/account_screen_provider/settings/settings_provider/settings_provider.dart';
import 'package:BrossScrum/providers/auth_provider/auth_provider.dart';
import 'package:BrossScrum/providers/home_screen/all_work/all_work_provider.dart';
import 'package:BrossScrum/providers/home_screen/create(+)/create_screen_provider.dart';
import 'package:BrossScrum/providers/home_screen/dashboard/dashboard_screen/dashboard_provider.dart';
import 'package:BrossScrum/providers/home_screen/dashboard/scrum/scrum_provider.dart';
import 'package:BrossScrum/providers/home_screen/home_screen_provider/home_screen_provider.dart';
import 'package:BrossScrum/providers/home_screen/notifications/notification_provider.dart';
import 'package:BrossScrum/providers/home_screen/spaces/space_provider.dart';
import 'package:BrossScrum/providers/intro/intro_provider.dart';
import 'package:BrossScrum/providers/splash_provider/splash_screen_provider.dart';
import 'package:BrossScrum/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => IntroProvider()),
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => AccountScreenProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => DndProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => SendFeedbackProvider()),
        ChangeNotifierProvider(create: (_) => InviteContactProvider()),
        ChangeNotifierProvider(create: (_) => ManageAccountProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => DashboardsProvider()),
        ChangeNotifierProvider(create: (_) => SpacesProvider()),
        ChangeNotifierProvider(create: (_) => CreateProvider()),
        ChangeNotifierProvider(create: (_) => AllWorkProvider()),
        ChangeNotifierProvider(create: (_) => ScrumProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: settingsProvider.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const SplashScreen(),
          onGenerateRoute: RouteGenerator.generateRoutes,
        );
      },
    );
  }
}