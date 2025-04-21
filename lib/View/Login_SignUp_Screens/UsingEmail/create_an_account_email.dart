import 'package:betapp/View/Login_SignUp_Screens/UsingEmail/continue_using_email_login.dart';
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

class CreateAnAccountEmailScreen extends StatefulWidget {
  const CreateAnAccountEmailScreen({Key? key}) : super(key: key);

  @override
  _CreateAnAccountEmailScreenState createState() =>
      _CreateAnAccountEmailScreenState();
}

class _CreateAnAccountEmailScreenState
    extends State<CreateAnAccountEmailScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int selected = 0;
  void clickfunction(int i) {
    if (i == 0) {
      setState(() {
        selected == 1 ? selected = 0 : selected = 1;
      });
    }
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
                          text: "Email",
                          textcolor: ColorConstant().blackColor,
                          fontSize: Get.width * 0.037,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        MyTextField(
                          controller: emailController,
                          show: false,
                          keyboardType: TextInputType.phone,
                          hintText: "Enter Email",
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        MyText(
                          text: "WhatsApp Number",
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
                          hintText: "Enter WhatsApp Number",
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
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Password",
                        ),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        MyButton(
                          color: ColorConstant().appColor,
                          text: "Register",
                          onPressed: () {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                nameController.text.isEmpty ||
                                phoneController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: (emailController.text.isEmpty &&
                                        passwordController.text.isEmpty &&
                                        nameController.text.isEmpty &&
                                        phoneController.text.isEmpty)
                                    ? 'Please fill in all fields'
                                    : (emailController.text.isEmpty)
                                        ? 'Please enter your email'
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

                              AuthUtils().registerUser(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  nameController.text.trim(),
                                  phoneController.text.trim(),
                                  context);
                            }
                          },
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
                                  // Get.to(EmailAuthTabScreen());
                                  Get.to(ContinueUsingEmail());
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
            ),
          ),
        ),
      ),
    );
  }
}
