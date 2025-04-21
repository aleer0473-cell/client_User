import 'package:betapp/View/BPro_App_Wallet/bpro_app_wallet_main.dart';
import 'package:betapp/View/Controller_And_Constants.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/utills/constants.dart';
import 'package:betapp/widgets/mybutton.dart';
import 'package:betapp/widgets/mytextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final GlobalKey<FormState>key=GlobalKey<FormState>();
  var id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Details',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Kanit'),
        ),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorConstant().appColor, // Change global cursor color here
            selectionHandleColor: ColorConstant().appColor, // Change handle color here
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: key,
            child: AnimationLimiter(



              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),

                    children: [
                      StreamBuilder(
                          stream: firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasData) {
                              var ds= snapshot.data!;
                              id=ds.id;

                              return SizedBox();
                            } else if (snapshot.hasError) {
                              return Center(child: const Icon(Icons.error_outline));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                      MyTextField(
                        controller: fullNameController,
                        show: false,
                        keyboardType: TextInputType.name,
                        hintText: "Enter Full Name",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextField(
                        controller: whatsappNumberController,
                        show: false,
                        keyboardType: TextInputType.phone,
                        hintText: "Enter WhatsApp Number",
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      MyButton(
                        color: ColorConstant().appColor,
                        text:  "Finish",
                        onPressed: () async{
                          if (whatsappNumberController.text.isEmpty ||
                              fullNameController.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: (whatsappNumberController.text.isEmpty &&
                                  fullNameController.text.isEmpty)
                                  ? 'Please fill in all fields'
                                  : (emailController.text.isEmpty)
                                  ? 'Please enter field'
                                  : 'Please enter field',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else {
                            await firebaseFirestore.collection("users").doc(id).update({
                              "UserName": fullNameController.text.trim(),
                              "phoneNumber":whatsappNumberController.text.trim(),

                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Data updated successfully"),
                            ));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BProWalletMain()),
                            );
                          }
                        },
                      ),
                    ]
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
