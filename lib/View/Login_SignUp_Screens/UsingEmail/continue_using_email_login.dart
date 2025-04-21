import 'package:betapp/View/Login_SignUp_Screens/UsingEmail/create_an_account_email.dart';
import 'package:betapp/constant/customdialog.dart';
import 'package:betapp/utills/authutils.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/widgets/mybutton.dart';
import 'package:betapp/widgets/mytext.dart';
import 'package:betapp/widgets/mytextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// class ContinueUsingEmail extends StatefulWidget {
//   const ContinueUsingEmail({Key? key}) : super(key: key);

//   @override
//   _ContinueUsingEmailState createState() => _ContinueUsingEmailState();
// }

// class _ContinueUsingEmailState extends State<ContinueUsingEmail> {
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   int selected = 0;
//   void clickfunction(int i) {
//     if (i == 0) {
//       setState(() {
//         selected == 1 ? selected = 0 : selected = 1;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
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
//                           text: "Email",
//                           textcolor: ColorConstant().blackColor,
//                           fontSize: Get.width * 0.037,
//                           fontWeight: FontWeight.w400,
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.005,
//                         ),
//                         MyTextField(
//                           controller: emailController,
//                           show: false,
//                           keyboardType: TextInputType.phone,
//                           hintText: "Enter Email",
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
//                             if (emailController.text.isEmpty ||
//                                 passwordController.text.isEmpty) {
//                               Fluttertoast.showToast(
//                                 msg: (emailController.text.isEmpty &&
//                                         passwordController.text.isEmpty)
//                                     ? 'Please fill in all fields'
//                                     : (emailController.text.isEmpty)
//                                         ? 'Please enter your email'
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

//                               AuthUtils().loginUser(emailController.text.trim(),
//                                   passwordController.text.trim(), context);
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
//                               onTap: () {
//                                 Get.to(CreateAnAccountEmailScreen());
//                               },
//                               child: MyText(
//                                 text: "SignUp",
//                                 textcolor: Colors.black,
//                                 fontSize: Get.width * 0.04,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ]),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ContinueUsingEmail extends StatefulWidget {
  const ContinueUsingEmail({Key? key}) : super(key: key);

  @override
  State<ContinueUsingEmail> createState() => _ContinueUsingEmailState();
}

class _ContinueUsingEmailState extends State<ContinueUsingEmail> {
  int selectedTab = 0;
  late PageController _pageController;

  // Login Controllers
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  int loginRemember = 0;

  // Signup Controllers
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
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
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedTab);
  }

  void toggleRemember(int i) {
    setState(() {
      loginRemember = loginRemember == 0 ? 1 : 0;
    });
  }

  void onTabChange(int index) {
    setState(() {
      selectedTab = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 23, 81, 169),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10)
                .copyWith(top: 100, bottom: 50),
            child: Container(
              margin: const EdgeInsets.all(16).copyWith(bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    selectedTab == 0 ? "Login Form" : "Signup Form",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTabSelector(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                      children: [
                        _buildLoginForm(),
                        _buildSignupForm(),
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

  Widget _buildTabSelector() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: [
          _tabButton("Login", 0),
          _tabButton("Signup", 1),
        ],
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChange(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: isSelected
                ? LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                  )
                : null,
            color: isSelected ? null : Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
          vertical: Get.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: "Email",
              textcolor: ColorConstant().blackColor,
              fontSize: Get.width * 0.037,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: Get.height * 0.005),
            MyTextField(
              controller: emailController,
              show: false,
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter Email",
            ),
            SizedBox(height: Get.height * 0.025),
            MyText(
              text: "Password",
              textcolor: ColorConstant().blackColor,
              fontSize: Get.width * 0.037,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: Get.height * 0.005),
            MyTextField(
              controller: passwordController,
              eye: true,
              show: true,
              keyboardType: TextInputType.visiblePassword,
              hintText: "Password",
            ),
            SizedBox(height: Get.height * 0.017),
            MyButton(
              color: ColorConstant().appColor,
              text: "LOGIN",
              onPressed: () {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: (emailController.text.isEmpty &&
                            passwordController.text.isEmpty)
                        ? 'Please fill in all fields'
                        : (emailController.text.isEmpty)
                            ? 'Please enter your email'
                            : 'Please enter your password',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  Customdialog.showDialogBox(context);
                  AuthUtils().loginUser(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                    context,
                  );
                  Customdialog.closeDialog(context);
                }
              },
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: "Don't have an account?",
                  textcolor: Colors.black,
                  fontSize: Get.width * 0.037,
                ),
                SizedBox(width: Get.width * 0.02),
                GestureDetector(
                  onTap: () {
                    Get.to(CreateAnAccountEmailScreen());
                  },
                  child: MyText(
                    text: "Sign Up",
                    textcolor: Colors.black,
                    fontSize: Get.width * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.03),
              _buildLabel("Name"),
              MyTextField(
                controller: nameController,
                show: false,
                keyboardType: TextInputType.name,
                hintText: "Enter Your Name",
              ),
              SizedBox(height: Get.height * 0.025),
              _buildLabel("Email"),
              MyTextField(
                controller: emailController,
                show: false,
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter Email",
              ),
              SizedBox(height: Get.height * 0.025),
              _buildLabel("WhatsApp Number"),
              MyTextField(
                controller: phoneController,
                show: false,
                keyboardType: TextInputType.phone,
                hintText: "Enter WhatsApp Number",
              ),
              SizedBox(height: Get.height * 0.025),
              _buildLabel("Password"),
              MyTextField(
                controller: passwordController,
                eye: true,
                show: true,
                keyboardType: TextInputType.visiblePassword,
                hintText: "Password",
              ),
              SizedBox(height: Get.height * 0.06),
              MyButton(
                color: ColorConstant().appColor,
                text: "Register",
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Please fill in all fields',
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
                      context,
                    );
                  }
                },
              ),
              SizedBox(height: Get.height * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "Already have an account?",
                    textcolor: Colors.black,
                    fontSize: Get.width * 0.037,
                  ),
                  SizedBox(width: Get.width * 0.02),
                  GestureDetector(
                    onTap: () {
                      Get.to(ContinueUsingEmail());
                    },
                    child: MyText(
                      text: "Login",
                      textcolor: Colors.black,
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: label,
          textcolor: ColorConstant().blackColor,
          fontSize: Get.width * 0.037,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: Get.height * 0.005),
      ],
    );
  }
}
