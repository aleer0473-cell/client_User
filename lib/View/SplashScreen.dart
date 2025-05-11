import 'package:betapp/View/BPro_App_Wallet/bpro_app_wallet_main.dart';
import 'package:betapp/View/onboarding/onbording.dart';
import 'package:betapp/utills/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        Future.delayed(const Duration(seconds: 2)).then((value) =>
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Onbording())));
      } else {
        Future.delayed(const Duration(seconds: 2)).then((value) =>
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => BProWalletMain()),
                (route) => false));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              // "assets/images/playstore.png",
              "assets/images/logo2.jpeg",
              scale: 3,
            )),
      ),
    );
  }
}
