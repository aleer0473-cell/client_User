
import 'package:betapp/View/BPro_App_Wallet/bpro_app_wallet_main.dart';
import 'package:betapp/constant/customdialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constants.dart';



class AuthUtils{


  registerUser(

      String email,

      String password,
      String name,
      String phoneNumber,

      BuildContext context
      )async{
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {

//         })
     FirebaseFirestore.instance.collection("users").doc(firebaseAuth.currentUser!.uid).set(
        {
          'UserName':name,
          'Email':email,
          "userStatus":"pending",
          "phoneNumber":phoneNumber,
          "betProname":"",
          "betPropassword":"",
          "balance":"0",
          "userPassword":password,
          "boolPhone":false,
          "time": DateTime.now(),





        }
      )
            .then((value) {

          Customdialog().showInSnackBar("Registered Successfully", context);
          Customdialog.closeDialog(context);
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => BProWalletMain()), (
              route) => false);

        });
      }  ).catchError((onError){
        throw onError;
        Navigator.pop(context);
        Customdialog.showBox(context,onError);

      });
    }on FirebaseAuthException catch(e){
      Navigator.pop(context);

      Customdialog.showBox(context,e.toString());


    }
  }


  loginUser(
      String email,
      String password,
      BuildContext context,
      )async{
    try{
      Customdialog.showDialogBox(context);
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        Customdialog().showInSnackBar("Logged in", context);
        Customdialog.closeDialog(context);


        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) =>BProWalletMain()), (
            route) => false);

      }  ).catchError((onError){
        throw onError;
      });
    }
    catch(e){
      Navigator.pop(context);
      Customdialog.showBox(context,"Invalid username or password");
    }
  }




  registerUserWithNumber(

      String email,

      String password,
String userPhone,
      String name,


      BuildContext context
      )async{
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {

//         })
        FirebaseFirestore.instance.collection("users").doc(firebaseAuth.currentUser!.uid).set(
            {
              'UserName':name,
              'Email':email,
              "userStatus":"pending",
              "phoneNumber":userPhone,
              "betProname":"",
              "betPropassword":"",
              "balance":"0",
              "userPassword":password,
              "boolPhone":true,
              "time": DateTime.now(),


            }
        )
            .then((value) {
          Customdialog().showInSnackBar("Registered Successfully", context);

          Customdialog.closeDialog(context);
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => BProWalletMain()), (
              route) => false);


        });
      }  ).catchError((onError){
        throw onError;
        Navigator.pop(context);
        Customdialog.showBox(context,onError);

      });
    }on FirebaseAuthException catch(e){
      Navigator.pop(context);

      Customdialog.showBox(context,e.toString());


    }
  }

  Future<void> loginUserWithPhoneNumber(String userPhone, String userPassword, BuildContext context) async {
    try {
      // Query Firestore for a user with the provided phone number
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: userPhone)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // User found, now check the password
        var userData = userQuery.docs.first.data() as Map<String, dynamic>;
        if (userData['userPassword'] == userPassword) {
          // Password matches, proceed to login
          String email = userData['Email'];

          // Sign in with email and password to get Firebase Auth token
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: userPassword);
          // Navigate to home screen or any other screen after successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BProWalletMain()),
          );
        } else {
          // Password does not match
          Customdialog.showBox(context, "Incorrect password. Please try again.");
        }
      } else {
        // No user found with the provided phone number
        Customdialog.showBox(context, "No user found with this phone number.");
      }
    } catch (e) {
      // Handle errors
      Customdialog.showBox(context, "Login failed: ${e.toString()}");
    }
  }
  resetPassword(String email,BuildContext context)async{
    try{
      await    firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        Customdialog.closeDialog(context);
        Customdialog.closeDialog(context);
        Customdialog.closeDialog(context);
        Customdialog().showInSnackBar("Please Check your email and Password", context);
      }).catchError((e){
        throw e;
      });
    }
    catch(e){
      Navigator.pop(context);
      Customdialog.showBox(context,e.toString());
    }
  }

}
