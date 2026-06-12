import 'package:BrossScrum/pages/auth_pages/splash_screen.dart';
import 'package:BrossScrum/providers/account_screen_provider/account_screen/account_screen_provider.dart';
import 'package:BrossScrum/providers/account_screen_provider/notification_settings_provider/donotdisturb_provider/donotdisturb_provider.dart';
import 'package:BrossScrum/providers/account_screen_provider/notification_settings_provider/notification_setting/notification_settings_provider.dart';
import 'package:BrossScrum/providers/account_screen_provider/settings/settings_provider/settings_provider.dart';
import 'package:BrossScrum/providers/auth_provider/auth_provider.dart';
import 'package:BrossScrum/providers/home_screen/home_screen_provider.dart';
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
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF3F4F6),
            cardColor: const Color(0xFFFFFFFF),
            dividerColor: const Color(0xFFF3F4F6),
            iconTheme: const IconThemeData(color: Color(0xFF42526E)),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFF3F4F6),
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFF374151)),
              titleTextStyle: TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Color(0xFF1F2937)),
              bodyMedium: TextStyle(color: Color(0xFF4B5563)),
              titleLarge: TextStyle(color: Color(0xFF1F2937)),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF111827),
            cardColor: const Color(0xFF1F2937),
            dividerColor: const Color(0xFF374151),
            iconTheme: const IconThemeData(color: Color(0xFF9CA3AF)),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF111827),
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFFF9FAFB)),
              titleTextStyle: TextStyle(
                color: Color(0xFFF9FAFB),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Color(0xFFF9FAFB)),
              bodyMedium: TextStyle(color: Color(0xFF9CA3AF)),
              titleLarge: TextStyle(color: Color(0xFFF9FAFB)),
            ),
          ),
          home: const SplashScreen(),
          onGenerateRoute: RouteGenerator.generateRoutes,
        );
      },
    );
  }
}