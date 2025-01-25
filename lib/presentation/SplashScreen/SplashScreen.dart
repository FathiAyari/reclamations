import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reclamations/presentation/ressources/routes/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushNamed(context, AppRouting.signInScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
