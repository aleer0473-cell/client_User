import 'package:betapp/View/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyD7pDP_nySsUdTglXSQ1NUDc6blTOiXVOg",
          appId: "1:1009360561313:android:8386e700c4d29ed7bd7ce0",
          messagingSenderId: "1009360561313",
          projectId: "insect-microscopy-disease-dete",
          storageBucket: 'insect-microscopy-disease-dete.appspot.com'));

  runApp(BProUserApp());
}

class BProUserApp extends StatefulWidget {
  const BProUserApp({super.key});

  @override
  State<BProUserApp> createState() => _BProUserAppState();
}

class _BProUserAppState extends State<BProUserApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// is ma imughe krna hai //