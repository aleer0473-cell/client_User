import 'package:betapp/View/Login_SignUp_Screens/UsingEmail/continue_using_email_login.dart';
import 'package:betapp/View/Login_SignUp_Screens/UsingPhone/continue_using_phone_login.dart';
import 'package:betapp/utills/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginMode extends StatefulWidget {
  const LoginMode({super.key});
  @override
  State<LoginMode> createState() => _LoginModeState();
}
class _LoginModeState extends State<LoginMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
            child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 70,
          ),

          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset("assets/images/playstore.png",scale: 3,)),
          const SizedBox(
            height: 150,
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:   ColorConstant().appColor,// Set border radius here
            ),
            width: 250,
            height: 50,
            child: TextButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => ContinueUsingPhone()),
                  // );
                  // Get.to(EmailAuthTabScreen());
                      Get.to(ContinueUsingEmail());

                },
                child: const Text(
                  'CONTINUE USING PHONE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                      wordSpacing: 0.1,
                      height: 1,
                      fontFamily: 'Kanit'),
                )),
          ),
          const SizedBox(
            height: 15,
          ),

          Container(
            decoration: BoxDecoration(
              color:  ColorConstant().appColor,
              borderRadius: BorderRadius.circular(15),
            ),
            width: 250,
            height: 50,
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContinueUsingEmail()),
                  );
                },
                child: const Text(
                  'CONTINUE USING EMAIL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                      wordSpacing: 0.1,
                      height: 1,
                      fontFamily: 'Kanit'),
                )),
          ),

          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          const Text(
            'Version 1.0',
            style: TextStyle(
                fontSize: 19, color: Colors.black, fontFamily: 'Kanit'),
          ),
          const SizedBox(
            height: 10,
          ),

        ],
      ),
    )));
  }
}
