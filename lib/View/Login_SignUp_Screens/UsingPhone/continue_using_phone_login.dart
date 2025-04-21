// import 'package:betapp/View/Login_SignUp_Screens/UsingPhone/create_an_account_phone.dart';
// import 'package:betapp/View/Login_SignUp_Screens/login_mode.dart';
// import 'package:betapp/constant/customdialog.dart';
// import 'package:betapp/utills/authutils.dart';
// import 'package:betapp/utills/colors.dart';
// import 'package:betapp/widgets/mybutton.dart';
// import 'package:betapp/widgets/mytext.dart';
// import 'package:betapp/widgets/mytextfield.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';

// class ContinueUsingPhone extends StatefulWidget {
//   const ContinueUsingPhone({Key? key}) : super(key: key);

//   @override
//   _ContinueUsingPhoneState createState() => _ContinueUsingPhoneState();
// }

// class _ContinueUsingPhoneState extends State<ContinueUsingPhone> {
//   int selected = 0;
//   void clickfunction(int i) {
//     if (i == 0) {
//       setState(() {
//         selected == 1 ? selected = 0 : selected = 1;
//       });
//     }
//   }

//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
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
//                   top: Get.height * 0.02,
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
//                         GestureDetector(
//                             onTap: () {
//                               Get.to(LoginMode());
//                             },
//                             child: Icon(Icons.arrow_back)),
//                         SizedBox(
//                           height: Get.height * 0.08,
//                         ),
//                         Row(
//                           children: [
//                             MyText(
//                               text: "Hi,Welcome",
//                               textcolor: ColorConstant().blackColor,
//                               fontSize: Get.width * 0.07,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             SizedBox(
//                               width: 6,
//                             ),
//                             Image.asset("assets/images/slap.png")
//                           ],
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.04,
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
//                           keyboardType: TextInputType.emailAddress,
//                           hintText: "Password",
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.017,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     clickfunction(0);
//                                   },
//                                   child: Container(
//                                     height: 21,
//                                     width: 21,
//                                     decoration: BoxDecoration(
//                                         color: selected == 0
//                                             ? Colors.white
//                                             : ColorConstant().appColor,
//                                         borderRadius: BorderRadius.circular(4),
//                                         border: Border.all(
//                                             color: selected == 0
//                                                 ? ColorConstant().appColor
//                                                 : ColorConstant().appColor,
//                                             width: 1.5)),
//                                     child: Icon(
//                                       Icons.check,
//                                       color: Colors.white,
//                                       size: 18,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: Get.width * 0.015,
//                                 ),
//                                 MyText(
//                                   text: "Remember me",
//                                   textcolor: ColorConstant().blackColor,
//                                   fontSize: Get.width * 0.037,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.06,
//                         ),
//                         MyButton(
//                           color: ColorConstant().appColor,
//                           text: "LOGIN",
//                           onPressed: () {
//                             if (phoneController.text.isEmpty ||
//                                 passwordController.text.isEmpty) {
//                               Fluttertoast.showToast(
//                                 msg: (phoneController.text.isEmpty &&
//                                         passwordController.text.isEmpty)
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

//                               AuthUtils().loginUserWithPhoneNumber(
//                                   phoneController.text.trim(),
//                                   passwordController.text.trim(),
//                                   context);
//                               Customdialog.closeDialog(context);
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
//                               text: "Dont have not an account?",
//                               textcolor: Colors.black,
//                               fontSize: Get.width * 0.037,
//                             ),
//                             SizedBox(
//                               width: Get.width * 0.02,
//                             ),
//                             GestureDetector(
//                                 onTap: () {
//                                   Get.to(CreateAnAccountPhoneScreen());
//                                 },
//                                 child: MyText(
//                                   text: "SignUp",
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

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

import 'package:betapp/constant/customdialog.dart';
import 'package:betapp/utills/authutils.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/widgets/mybutton.dart';
import 'package:betapp/widgets/mytextfield.dart';

class AuthTabScreen extends StatefulWidget {
  const AuthTabScreen({super.key});

  @override
  State<AuthTabScreen> createState() => _AuthTabScreenState();
}

class _AuthTabScreenState extends State<AuthTabScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late TabController _tabController;

  String? generatedEmail;
  int rememberMe = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> generateEmail() async {
    String randomUsername = randomAlphaNumeric(8);
    generatedEmail = '$randomUsername@gmail.com';
    setState(() {});
  }

  void toggleRememberMe() {
    setState(() {
      rememberMe = rememberMe == 0 ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 23, 81, 169),
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text(
                  //   _tabController.index == 0 ? "Login Form" : "SignUp Form",
                  //   style: const TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      final isLogin = _tabController.index == 0;
                      final beginOffset =
                          isLogin ? const Offset(-1, 0) : const Offset(1, 0);
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: beginOffset,
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    child: Text(
                      _tabController.index == 0 ? "Login Form" : "SignUp Form",
                      key: ValueKey(_tabController.index),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// TAB BAR
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                        ),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(text: "Login"),
                        Tab(text: "Signup"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// TAB CONTENT
                  SizedBox(
                    height: Get.height * 0.35,
                    child: TabBarView(
                      controller: _tabController,
                      // physics: const NeverScrollableScrollPhysics(),
                      children: [
                        /// LOGIN FORM
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextField(
                              controller: loginPhoneController,
                              show: false,
                              keyboardType: TextInputType.phone,
                              hintText: "Email Address",
                            ),
                            const SizedBox(height: 12),
                            MyTextField(
                              controller: loginPasswordController,
                              show: true,
                              eye: true,
                              keyboardType: TextInputType.visiblePassword,
                              hintText: "Password",
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                            // const SizedBox(height: 8),
                            // Row(
                            //   children: [
                            //     GestureDetector(
                            //       onTap: toggleRememberMe,
                            //       child: Container(
                            //         height: 20,
                            //         width: 20,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(4),
                            //           border: Border.all(
                            //             color: ColorConstant().appColor,
                            //             width: 1.5,
                            //           ),
                            //           color: rememberMe == 1
                            //               ? ColorConstant().appColor
                            //               : Colors.white,
                            //         ),
                            //         child: Icon(
                            //           Icons.check,
                            //           size: 16,
                            //           color: rememberMe == 1
                            //               ? Colors.white
                            //               : Colors.transparent,
                            //         ),
                            //       ),
                            //     ),
                            //     const SizedBox(width: 8),
                            //     const Text("Remember me"),
                            //   ],
                            // ),
                            // const SizedBox(height: 20),
                            MyButton(
                              text: "Login",
                              onPressed: () {
                                if (loginPhoneController.text.isEmpty ||
                                    loginPasswordController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please fill in all fields");
                                } else {
                                  Customdialog.showDialogBox(context);
                                  AuthUtils().loginUserWithPhoneNumber(
                                    loginPhoneController.text.trim(),
                                    loginPasswordController.text.trim(),
                                    context,
                                  );
                                  Customdialog.closeDialog(context);
                                }
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Not a member? "),
                                Text(
                                  "Signup now",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        /// SIGNUP FORM
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextField(
                              controller: nameController,
                              show: false,
                              keyboardType: TextInputType.name,
                              hintText: "Name",
                            ),
                            const SizedBox(height: 12),
                            MyTextField(
                              controller: phoneController,
                              show: false,
                              keyboardType: TextInputType.phone,
                              hintText: "Phone Number",
                            ),
                            const SizedBox(height: 12),
                            MyTextField(
                              controller: passwordController,
                              show: true,
                              eye: true,
                              keyboardType: TextInputType.visiblePassword,
                              hintText: "Password",
                            ),
                            const SizedBox(height: 20),
                            MyButton(
                              text: "Signup",
                              color: ColorConstant().appColor,
                              onPressed: () async {
                                if (phoneController.text.isEmpty ||
                                    passwordController.text.isEmpty ||
                                    nameController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please fill in all fields");
                                } else {
                                  Customdialog.showDialogBox(context);
                                  await generateEmail();
                                  AuthUtils().registerUserWithNumber(
                                    generatedEmail!.toLowerCase(),
                                    passwordController.text.trim(),
                                    phoneController.text.trim(),
                                    nameController.text.trim(),
                                    context,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
