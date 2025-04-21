// import 'package:betapp/View/Login_SignUp_Screens/UsingPhone/continue_using_phone_login.dart';
// import 'package:betapp/constant/customdialog.dart';
// import 'package:betapp/utills/authutils.dart';
// import 'package:betapp/utills/colors.dart';
// import 'package:betapp/widgets/mybutton.dart';
// import 'package:betapp/widgets/mytext.dart';
// import 'package:betapp/widgets/mytextfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:random_string/random_string.dart';

// class CreateAnAccountPhoneScreen extends StatefulWidget {
//   const CreateAnAccountPhoneScreen({Key? key}) : super(key: key);

//   @override
//   _CreateAnAccountPhoneScreenState createState() =>
//       _CreateAnAccountPhoneScreenState();
// }

// class _CreateAnAccountPhoneScreenState
//     extends State<CreateAnAccountPhoneScreen> {
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();

//   String? email;
//   Future<void> generateAndSendEmail() async {
//     String randomUsername = randomAlphaNumeric(8);
//     email = '$randomUsername@gmail.com';

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             body: SafeArea(
//                 child: SingleChildScrollView(
//                     child: Padding(
//               padding: EdgeInsets.only(
//                   left: Get.width * 0.04,
//                   top: Get.height * 0.08,
//                   right: Get.width * 0.04),
//               child: AnimationLimiter(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: AnimationConfiguration.toStaggeredList(
//                       duration: const Duration(milliseconds: 375),
//                       childAnimationBuilder: (widget) => SlideAnimation(
//                             horizontalOffset: 50.0,
//                             child: FadeInAnimation(
//                               child: widget,
//                             ),
//                           ),
//                       children: [
//                         Row(
//                           children: [
//                             MyText(
//                               text: "Create Account",
//                               textcolor: ColorConstant().blackColor,
//                               fontSize: Get.width * 0.07,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             SizedBox(
//                               width: 6,
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.04,
//                         ),
//                         MyText(
//                           text: "Name",
//                           textcolor: ColorConstant().blackColor,
//                           fontSize: Get.width * 0.037,
//                           fontWeight: FontWeight.w400,
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.005,
//                         ),
//                         MyTextField(
//                           controller: nameController,
//                           show: false,
//                           keyboardType: TextInputType.phone,
//                           hintText: "Enter Your Name",
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.025,
//                         ),
//                         MyText(
//                           text: "Phone Numbers",
//                           textcolor: ColorConstant().blackColor,
//                           fontSize: Get.width * 0.037,
//                           fontWeight: FontWeight.w400,
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.005,
//                         ),
//                         MyTextField(
//                           controller: phoneController,
//                           show: false,
//                           keyboardType: TextInputType.phone,
//                           hintText: "Enter Phone Number",
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.025,
//                         ),
//                         MyText(
//                           text: "Password",
//                           textcolor: ColorConstant().blackColor,
//                           fontSize: Get.width * 0.037,
//                           fontWeight: FontWeight.w400,
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.005,
//                         ),
//                         MyTextField(
//                           controller: passwordController,
//                           eye: true,
//                           show: true,
//                           keyboardType: TextInputType.visiblePassword,
//                           hintText: "Password",
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.06,
//                         ),
//                         MyButton(
//                           color: ColorConstant().appColor,
//                           text: "Register",
//                           onPressed: () {
//                             if (phoneController.text.isEmpty ||
//                                 passwordController.text.isEmpty ||
//                                 nameController.text.isEmpty) {
//                               Fluttertoast.showToast(
//                                 msg: (phoneController.text.isEmpty &&
//                                         passwordController.text.isEmpty &&
//                                         nameController.text.isEmpty)
//                                     ? 'Please fill in all fields'
//                                     : (phoneController.text.isEmpty)
//                                         ? 'Please enter your phone number'
//                                         : 'Please enter your password',
//                                 toastLength: Toast.LENGTH_SHORT,
//                                 gravity: ToastGravity.BOTTOM,
//                                 timeInSecForIosWeb: 1,
//                                 backgroundColor: Colors.black.withOpacity(0.5),
//                                 textColor: Colors.white,
//                                 fontSize: 16.0,
//                               );
//                             } else {
//                               Customdialog.showDialogBox(context);

//                               generateAndSendEmail();
//                               print(email);
//                               AuthUtils().registerUserWithNumber(
//                                   email.toString().toLowerCase(),
//                                   passwordController.text.trim(),
//                                   phoneController.text.trim(),
//                                   nameController.text.trim(),
//                                   context);
//                             }
//                           },
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.06,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             MyText(
//                               text: "Already have not an account?",
//                               textcolor: Colors.black,
//                               fontSize: Get.width * 0.037,
//                             ),
//                             SizedBox(
//                               width: Get.width * 0.02,
//                             ),
//                             GestureDetector(
//                                 onTap: () {
//                                   Get.to(ContinueUsingPhone());
//                                 },
//                                 child: MyText(
//                                   text: "Login",
//                                   textcolor: Colors.black,
//                                   fontSize: Get.width * 0.04,
//                                   fontWeight: FontWeight.w700,
//                                 )),
//                           ],
//                         ),
//                       ]),
//                 ),
//               ),
//             )))));
//   }
// }



import 'package:betapp/View/Login_SignUp_Screens/UsingPhone/continue_using_phone_login.dart';
import 'package:betapp/constant/customdialog.dart';
import 'package:betapp/utills/authutils.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/widgets/mybutton.dart';
import 'package:betapp/widgets/mytext.dart';
import 'package:betapp/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

class CreateAnAccountPhoneScreen extends StatefulWidget {
  const CreateAnAccountPhoneScreen({Key? key}) : super(key: key);

  @override
  _CreateAnAccountPhoneScreenState createState() =>
      _CreateAnAccountPhoneScreenState();
}

class _CreateAnAccountPhoneScreenState
    extends State<CreateAnAccountPhoneScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? email;
  Future<void> generateAndSendEmail() async {
    String randomUsername = randomAlphaNumeric(8);
    email = '$randomUsername@gmail.com';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.04,
                  top: Get.height * 0.08,
                  right: Get.width * 0.04),
              child: AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                      children: [
                        Row(
                          children: [
                            MyText(
                              text: "Create Account",
                              textcolor: ColorConstant().blackColor,
                              fontSize: Get.width * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        MyText(
                          text: "Name",
                          textcolor: ColorConstant().blackColor,
                          fontSize: Get.width * 0.037,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        MyTextField(
                          controller: nameController,
                          show: false,
                          keyboardType: TextInputType.phone,
                          hintText: "Enter Your Name",
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        MyText(
                          text: "Phone Numbers",
                          textcolor: ColorConstant().blackColor,
                          fontSize: Get.width * 0.037,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        MyTextField(
                          controller: phoneController,
                          show: false,
                          keyboardType: TextInputType.phone,
                          hintText: "Enter Phone Number",
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        MyText(
                          text: "Password",
                          textcolor: ColorConstant().blackColor,
                          fontSize: Get.width * 0.037,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        MyTextField(
                          controller: passwordController,
                          eye: true,
                          show: true,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "Password",
                        ),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        MyButton(
                          color: ColorConstant().appColor,
                          text: "Register",
                          onPressed: () {
                            if (phoneController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                nameController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: (phoneController.text.isEmpty &&
                                        passwordController.text.isEmpty &&
                                        nameController.text.isEmpty)
                                    ? 'Please fill in all fields'
                                    : (phoneController.text.isEmpty)
                                        ? 'Please enter your phone number'
                                        : 'Please enter your password',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black.withOpacity(0.5),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else {
                              Customdialog.showDialogBox(context);

                              generateAndSendEmail();
                              print(email);
                              AuthUtils().registerUserWithNumber(
                                  email.toString().toLowerCase(),
                                  passwordController.text.trim(),
                                  phoneController.text.trim(),
                                  nameController.text.trim(),
                                  context);
                            }
                          }
                        ),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(
                              text: "Already have not an account?",
                              textcolor: Colors.black,
                              fontSize: Get.width * 0.037,
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.to(AuthTabScreen());
                                },
                                child: MyText(
                                  text: "Login",
                                  textcolor: Colors.black,
                                  fontSize: Get.width * 0.04,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ]),
                ),
              ),
            )))));
  }
}
