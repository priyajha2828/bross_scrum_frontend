import 'package:BrossScrum/pages/auth_pages/splash_screen.dart';
import 'package:BrossScrum/providers/auth_provider/auth_provider.dart';
import 'package:BrossScrum/providers/splash_provider/splash_screen_provider.dart';
import 'package:BrossScrum/routes/app_route.dart';
import 'package:BrossScrum/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_)=> SplashScreenProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      onGenerateRoute: RouteGenerator.generateRoutes,

    );
  }
}
