import 'package:betapp/View/Controller_And_Constants.dart';
import 'package:betapp/View/Login_SignUp_Screens/login_mode.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant().appColor,
        leading:  GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 25,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Kanit'),
        ),
      ),
      body: SafeArea(
        child: Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme:  TextSelectionThemeData(
              cursorColor: ColorConstant().appColor, // Change global cursor color here
              selectionHandleColor: ColorConstant().appColor, // Change handle color here
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(

              child:
              StreamBuilder(
                  stream: firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var ds= snapshot.data!;
                      return  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            child: const Text(
                              'Full Name',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Kanit'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              readOnly: true,
                              controller: fullNameController,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Kanit'),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(),
                                hintTextDirection: TextDirection.ltr,
                                hintText: ds.get("UserName"),

                                labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontFamily: 'Kanit'),
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 20,
                                    fontFamily: 'Kanit'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: const Text(
                              'WhatsApp Number',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Kanit'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              readOnly: true,
                              controller: whatsappNumberController,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Kanit'),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(),
                                hintTextDirection: TextDirection.ltr,
                                hintText: ds.get("phoneNumber"),

                                labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontFamily: 'Kanit'),
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 20,
                                    fontFamily: 'Kanit'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorConstant().appColor,
                              borderRadius:
                              BorderRadius.circular(5), // Set border radius here
                            ),
                            width: double.infinity,
                            height: 40,
                            child: TextButton(
                                onPressed: () async{
                                  await firebaseAuth.signOut();
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginMode()), (Route<dynamic> route) => false);

                                },
                                child: const Text(
                                  'LOGOUT',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 3,
                                      height: 1,
                                      fontFamily: 'Kanit'),
                                )),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Version 1.0.0',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Kanit'
                              ),
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: const Icon(Icons.error_outline));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),

            ),
          ),
        ),
      ),
    );
  }
}
