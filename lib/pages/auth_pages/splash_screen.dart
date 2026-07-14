import 'package:BrossScrum/providers/splash_provider/splash_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intro/intro_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  @override

  void initState(){
    super.initState();

    Future.microtask(() async{
      final provider = Provider.of<SplashScreenProvider>(context, listen: false);

      await provider.startSplash();

      if(mounted){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => const IntroPage(),
          ),
        );
      }
    }
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Image.asset(
              'assets/images/brossscrumlogo.png',
            width: 200,
          ),
        ),
      ),
    );
  }
}
