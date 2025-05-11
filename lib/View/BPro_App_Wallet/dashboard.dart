import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:betapp/View/BPro_App_Wallet/allTransactions.dart';
import 'package:betapp/View/BPro_App_Wallet/bpro.dart';
import 'package:betapp/View/BPro_App_Wallet/deposit.dart';
import 'package:betapp/View/BPro_App_Wallet/profile.dart';
import 'package:betapp/View/BPro_App_Wallet/withdraw.dart';
import 'package:betapp/constant/customdialog.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/utills/constants.dart';
import 'package:betapp/utills/loadingbar.dart';
import 'package:betapp/widgets/mytext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var myStatus = "";

  String? userPhoneNumber;

  var balance;

  @override
  void initState() {
    firebaseFirestore
        .collection("socialInfo")
        .doc("dzwAYcmZTRizAd0fkERh")
        .get()
        .then((value) {
      userPhoneNumber = value.get("whatsAppNumber");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Image.asset(
          "assets/images/whatsapp.png",
          scale: 18,
        ),
        onPressed: () async {
          await launch('http://Wa.me/${userPhoneNumber}');
        },
      ),
      backgroundColor: Color.fromARGB(255, 72, 10, 83),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: appSize.height * 0.05, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Batproexch App',
                      style: TextStyle(
                        fontSize: 22,
                        color: ColorConstant().whiteColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit',
                      )),
                  InkWell(
                    onTap: () {
                      Get.to(Profile());
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorConstant().whiteColor,
                        ),
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: ColorConstant().whiteColor,
                          backgroundImage: AssetImage(
                            // "assets/images/dp.png",
                            "assets/images/logo2.jpeg",
                          ),
                        )),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.to(Profile());
                  //   },
                  //   child: Container(
                  //     height: 50,
                  //     width: 50,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(50),
                  //       color: ColorConstant().whiteColor,
                  //     ),
                  //     child: Image.asset("assets/images/logo2.jpeg"),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: appSize.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: appSize.height * 0.02, left: 8, right: 8),
              height: appSize.height * 0.78,
              width: appSize.width,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 72, 10, 83),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: firebaseFirestore
                            .collection("users")
                            .doc(firebaseAuth.currentUser!.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            var ds = snapshot.data!;
                            balance = ds.get("balance");
                            var status = ds.get("userStatus");

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BPro(
                                                  username:
                                                      ds.get("betProname"),
                                                  password:
                                                      ds.get("betPropassword"),
                                                )));
                                  },
                                  child: Container(
                                    // width: appSize.width * 0.53,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          255, 255, 88, 144),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: appSize.width * 0.02),
                                          child: Row(
                                            children: [
                                              MyText(
                                                text: "Rs.",
                                                fontWeight: FontWeight.w700,
                                                fontSize: appSize.width * 0.042,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              LoadingDots()
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: appSize.width * 0.02),
                                          child: MyText(
                                              text: "Current Balance",
                                              fontWeight: FontWeight.w400,
                                              fontSize: appSize.width * 0.03,
                                              textcolor: Colors.white),
                                        ),
                                        Divider(
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: appSize.width * 0.02),
                                          child: MyText(
                                            text: "BetPro Username",
                                            fontWeight: FontWeight.bold,
                                            fontSize: appSize.width * 0.033,
                                            textcolor: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: appSize.width * 0.02),
                                          child: Row(
                                            children: [
                                              MyText(
                                                  text: ds.get("betProname"),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      appSize.width * 0.03,
                                                  textcolor: Colors.white),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: ds.get(
                                                                "betProname")));
                                                    Fluttertoast.showToast(
                                                      msg: 'Username Copied',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Color(0xff293850)
                                                              .withOpacity(0.5),
                                                      textColor: Colors.white,
                                                      fontSize: 16.0,
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.copy,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: appSize.width * 0.02),
                                          child: MyText(
                                            text: "BetPro Password",
                                            fontWeight: FontWeight.bold,
                                            fontSize: appSize.width * 0.033,
                                            textcolor: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: appSize.width * 0.02),
                                          child: Row(
                                            children: [
                                              MyText(
                                                  text:
                                                      ds.get("betPropassword"),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      appSize.width * 0.03,
                                                  textcolor: Colors.white),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    Clipboard.setData(ClipboardData(
                                                        text: ds.get(
                                                            "betPropassword")));
                                                    Fluttertoast.showToast(
                                                      msg: 'Password Copied',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Color(0xff293850)
                                                              .withOpacity(0.5),
                                                      textColor: Colors.white,
                                                      fontSize: 16.0,
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.copy,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: appSize.height * 0.01,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: appSize.width * 0.02,
                                              right: appSize.width * 0.02),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BPro(
                                                            username: ds.get(
                                                                "betProname"),
                                                            password: ds.get(
                                                                "betPropassword"),
                                                          )));
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                MyText(
                                                  text: "Click to open Bpro"
                                                      .toString()
                                                      .toUpperCase(),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      appSize.width * 0.028,
                                                  textcolor:
                                                      ColorConstant().appColor,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      color: ColorConstant()
                                                          .appColor,
                                                      size: 15,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      color: ColorConstant()
                                                          .appColor,
                                                      size: 15,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      color: ColorConstant()
                                                          .appColor,
                                                      size: 15,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: appSize.height * 0.04,
                                          width: appSize.width,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: status == "pending"
                                                  ? Color.fromARGB(
                                                      255, 255, 88, 144)
                                                  : Color.fromARGB(
                                                      255, 255, 88, 144),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10))),
                                          child: MyText(
                                            text: status == "pending"
                                                ? "BPro InActive"
                                                : "BPro Activated",
                                            fontWeight: FontWeight.w400,
                                            fontSize: appSize.width * 0.032,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => BPro(
                                    //                   username:
                                    //                       ds.get("betProname"),
                                    //                   password:
                                    //                       ds.get("betPropassword"),
                                    //                 )));
                                    //   },
                                    //   child: Container(
                                    //     width: appSize.width * 0.53,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(10),
                                    //         color: ColorConstant().appColor),
                                    //     child: Column(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceBetween,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         SizedBox(
                                    //           height: 6,
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(
                                    //               left: appSize.width * 0.02),
                                    //           child: Row(
                                    //             children: [
                                    //               MyText(
                                    //                 text: "Rs.",
                                    //                 fontWeight: FontWeight.w700,
                                    //                 fontSize: appSize.width * 0.042,
                                    //               ),
                                    //               SizedBox(
                                    //                 width: 4,
                                    //               ),
                                    //               LoadingDots()
                                    //             ],
                                    //           ),
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(
                                    //               left: appSize.width * 0.02),
                                    //           child: MyText(
                                    //               text: "Current Balance",
                                    //               fontWeight: FontWeight.w400,
                                    //               fontSize: appSize.width * 0.03,
                                    //               textcolor: Colors.white),
                                    //         ),
                                    //         Divider(
                                    //           color: Colors.white,
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(
                                    //               left: appSize.width * 0.02),
                                    //           child: MyText(
                                    //             text: "BetPro Username",
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: appSize.width * 0.033,
                                    //             textcolor: Colors.white,
                                    //           ),
                                    //         ),
                                    //         SizedBox(
                                    //           height: 3,
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(
                                    //               left: appSize.width * 0.02),
                                    //           child: Row(
                                    //             children: [
                                    //               MyText(
                                    //                   text: ds.get("betProname"),
                                    //                   fontWeight: FontWeight.w500,
                                    //                   fontSize:
                                    //                       appSize.width * 0.03,
                                    //                   textcolor: Colors.white),
                                    //               SizedBox(
                                    //                 width: 15,
                                    //               ),
                                    //               InkWell(
                                    //                   onTap: () {
                                    //                     Clipboard.setData(
                                    //                         ClipboardData(
                                    //                             text: ds.get(
                                    //                                 "betProname")));
                                    //                     Fluttertoast.showToast(
                                    //                       msg: 'Username Copied',
                                    //                       toastLength:
                                    //                           Toast.LENGTH_SHORT,
                                    //                       gravity:
                                    //                           ToastGravity.BOTTOM,
                                    //                       timeInSecForIosWeb: 1,
                                    //                       backgroundColor:
                                    //                           Color(0xff293850)
                                    //                               .withOpacity(0.5),
                                    //                       textColor: Colors.white,
                                    //                       fontSize: 16.0,
                                    //                     );
                                    //                   },
                                    //                   child: Icon(
                                    //                     Icons.copy,
                                    //                     color: Colors.white,
                                    //                     size: 20,
                                    //                   ))
                                    //             ],
                                    //           ),
                                    //         ),
                                    //         SizedBox(
                                    //           height: 5,
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(
                                    //               left: appSize.width * 0.02),
                                    //           child: MyText(
                                    //             text: "BetPro Password",
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: appSize.width * 0.033,
                                    //             textcolor: Colors.white,
                                    //           ),
                                    //         ),
                                    //         SizedBox(
                                    //           height: 3,
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(
                                    //               left: appSize.width * 0.02),
                                    //           child: Row(
                                    //             children: [
                                    //               MyText(
                                    //                   text:
                                    //                       ds.get("betPropassword"),
                                    //                   fontWeight: FontWeight.w500,
                                    //                   fontSize:
                                    //                       appSize.width * 0.03,
                                    //                   textcolor: Colors.white),
                                    //               SizedBox(
                                    //                 width: 15,
                                    //               ),
                                    //               InkWell(
                                    //                   onTap: () {
                                    //                     Clipboard.setData(ClipboardData(
                                    //                         text: ds.get(
                                    //                             "betPropassword")));
                                    //                     Fluttertoast.showToast(
                                    //                       msg: 'Password Copied',
                                    //                       toastLength:
                                    //                           Toast.LENGTH_SHORT,
                                    //                       gravity:
                                    //                           ToastGravity.BOTTOM,
                                    //                       timeInSecForIosWeb: 1,
                                    //                       backgroundColor:
                                    //                           Color(0xff293850)
                                    //                               .withOpacity(0.5),
                                    //                       textColor: Colors.white,
                                    //                       fontSize: 16.0,
                                    //                     );
                                    //                   },
                                    //                   child: Icon(
                                    //                     Icons.copy,
                                    //                     color: Colors.white,
                                    //                     size: 20,
                                    //                   ))
                                    //             ],
                                    //           ),
                                    //         ),
                                    //         SizedBox(
                                    //           height: appSize.height * 0.01,
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(
                                    //               left: appSize.width * 0.02,
                                    //               right: appSize.width * 0.02),
                                    //           child: GestureDetector(
                                    //             onTap: () {
                                    //               Navigator.push(
                                    //                   context,
                                    //                   MaterialPageRoute(
                                    //                       builder: (context) =>
                                    //                           BPro(
                                    //                             username: ds.get(
                                    //                                 "betProname"),
                                    //                             password: ds.get(
                                    //                                 "betPropassword"),
                                    //                           )));
                                    //             },
                                    //             child: Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment
                                    //                       .spaceBetween,
                                    //               children: [
                                    //                 MyText(
                                    //                   text: "Click to open Bpro"
                                    //                       .toString()
                                    //                       .toUpperCase(),
                                    //                   fontWeight: FontWeight.w700,
                                    //                   fontSize:
                                    //                       appSize.width * 0.028,
                                    //                   textcolor:
                                    //                       ColorConstant().appColor,
                                    //                 ),
                                    //                 Row(
                                    //                   children: [
                                    //                     Icon(
                                    //                       Icons
                                    //                           .arrow_forward_ios_outlined,
                                    //                       color: ColorConstant()
                                    //                           .appColor,
                                    //                       size: 15,
                                    //                     ),
                                    //                     Icon(
                                    //                       Icons
                                    //                           .arrow_forward_ios_outlined,
                                    //                       color: ColorConstant()
                                    //                           .appColor,
                                    //                       size: 15,
                                    //                     ),
                                    //                     Icon(
                                    //                       Icons
                                    //                           .arrow_forward_ios_outlined,
                                    //                       color: ColorConstant()
                                    //                           .appColor,
                                    //                       size: 15,
                                    //                     )
                                    //                   ],
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         Container(
                                    //           height: appSize.height * 0.04,
                                    //           width: appSize.width,
                                    //           alignment: Alignment.center,
                                    //           decoration: BoxDecoration(
                                    //               color: status == "pending"
                                    //                   ? Colors.red
                                    //                   : Colors.green,
                                    //               borderRadius: BorderRadius.only(
                                    //                   bottomLeft:
                                    //                       Radius.circular(10),
                                    //                   bottomRight:
                                    //                       Radius.circular(10))),
                                    //           child: MyText(
                                    //             text: status == "pending"
                                    //                 ? "BPro InActive"
                                    //                 : "BPro Activated",
                                    //             fontWeight: FontWeight.w400,
                                    //             fontSize: appSize.width * 0.032,
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        StreamBuilder(
                                            stream: firebaseFirestore
                                                .collection("paymentRecord")
                                                .where("senderId",
                                                    isEqualTo: firebaseAuth
                                                        .currentUser!.uid)
                                                .where("paymentType",
                                                    isEqualTo: "deposit")
                                                .where("status",
                                                    isEqualTo: "pending")
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                var data = snapshot.data?.docs;
                                                var length = data?.length;
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (length == 0) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Deposit()));
                                                    } else {
                                                      Customdialog().showInSnackBar(
                                                          "You can't deposit because ur deposit is already in pending",
                                                          context);
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10)
                                                            .copyWith(left: 8),
                                                        height: appSize.height *
                                                            0.13,
                                                        width: appSize.width *
                                                            0.38,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    187,
                                                                    153,
                                                                    231)
                                                                .withValues(
                                                                    alpha:
                                                                        0.5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: appSize
                                                                        .height *
                                                                    0.015,
                                                              ),
                                                              MyText(
                                                                text: "Deposit",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: appSize
                                                                        .width *
                                                                    0.04,
                                                                textcolor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              SizedBox(
                                                                height: appSize
                                                                        .height *
                                                                    0.004,
                                                              ),
                                                              MyText(
                                                                text: length
                                                                    .toString(),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: appSize
                                                                        .width *
                                                                    0.035,
                                                                textcolor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                    ],
                                                  ),
                                                );
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                    child: const Icon(
                                                        Icons.error_outline));
                                              } else {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                            }),
                                        StreamBuilder(
                                            stream: firebaseFirestore
                                                .collection("paymentRecord")
                                                .where("senderId",
                                                    isEqualTo: firebaseAuth
                                                        .currentUser!.uid)
                                                .where("paymentType",
                                                    isEqualTo: "withdraw")
                                                .where("status",
                                                    isEqualTo: "pending")
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                var data = snapshot.data?.docs;
                                                var length = data?.length;
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Withdraw()));
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      height:
                                                          appSize.height * 0.13,
                                                      width:
                                                          appSize.width * 0.38,
                                                      // width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Color.fromARGB(
                                                            255, 130, 238, 190),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: appSize
                                                                      .height *
                                                                  0.015,
                                                            ),
                                                            MyText(
                                                                text:
                                                                    "Withdraw",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: appSize
                                                                        .width *
                                                                    0.04,
                                                                textcolor:
                                                                    Colors
                                                                        .white),
                                                            SizedBox(
                                                              height: appSize
                                                                      .height *
                                                                  0.004,
                                                            ),
                                                            MyText(
                                                                text: length
                                                                    .toString(),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: appSize
                                                                        .width *
                                                                    0.035,
                                                                textcolor:
                                                                    Colors
                                                                        .white),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                    child: const Icon(
                                                        Icons.error_outline));
                                              } else {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: const Icon(Icons.error_outline));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                    SizedBox(
                      height: appSize.height * 0.02,
                    ),
                    const SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transaction History',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Kanit',
                              ),
                            ),
                          ],
                        )),
                    StreamBuilder(
                      stream: firebaseFirestore
                          .collection("paymentRecord")
                          .where("senderId",
                              isEqualTo: firebaseAuth.currentUser!.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!;

                          // Filter out transactions where paymentType is "withdraw" and status is "pending"
                          List<DocumentSnapshot> filteredDocs =
                              data.docs.where((doc) {
                            return !(doc.get("paymentType") == "withdraw" &&
                                doc.get("status") == "pending");
                          }).toList();

                          return filteredDocs.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: appSize.height * 0.04),
                                  child: Image.asset(
                                    "assets/images/no-data.gif",
                                    scale: 2,
                                  ),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height: appSize.height * 0.39,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: filteredDocs.length > 2
                                                  ? 2
                                                  : filteredDocs.length,
                                              padding: EdgeInsets.zero,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                List<DocumentSnapshot> docs =
                                                    filteredDocs;
                                                // Sort the documents based on the 'time' field
                                                docs.sort((a, b) {
                                                  Timestamp timeA =
                                                      a.get("time");
                                                  Timestamp timeB =
                                                      b.get("time");
                                                  DateTime dateTimeA =
                                                      timeA.toDate();
                                                  DateTime dateTimeB =
                                                      timeB.toDate();
                                                  return dateTimeB
                                                      .compareTo(dateTimeA);
                                                });

                                                var ds = docs[index];
                                                var time =
                                                    ds.get("time").toDate();
                                                String formattedTime =
                                                    DateFormat('hh:mm a')
                                                        .format(time);
                                                var paymentType =
                                                    ds.get("paymentType");
                                                var userAmount =
                                                    ds.get("amount");

                                                return Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                                  116, 98, 142)
                                                              .withValues(
                                                                  alpha: 0.5),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 2,
                                                              blurRadius: 2,
                                                              offset:
                                                                  Offset(0, 2),
                                                            ),
                                                          ],
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {},
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: 5),
                                                                  ds.get("paymentType").toString() ==
                                                                          "deposit"
                                                                      ? CircleAvatar(
                                                                          radius:
                                                                              18,
                                                                          backgroundColor:
                                                                              ColorConstant().appColor,
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/elements.png",
                                                                            scale:
                                                                                2.2,
                                                                          ),
                                                                        )
                                                                      : CircleAvatar(
                                                                          radius:
                                                                              18,
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                          child:
                                                                              Transform.rotate(
                                                                            angle:
                                                                                13 / 4, // Rotate by 45 degrees (π/4 radians)
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/images/elements.png",
                                                                              scale: 2.2,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                  SizedBox(
                                                                      width: Get
                                                                              .width *
                                                                          0.03),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${ds.get("paymentType").toString().capitalize}",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontFamily:
                                                                                'Kanit',
                                                                            fontSize:
                                                                                Get.width * 0.045),
                                                                      ),
                                                                      Text(
                                                                        "To ${ds.get("accountTitle").toString().capitalize}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Kanit',
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: Get.width *
                                                                            0.787,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              "${ds.get("bankType").toString().capitalizeFirst} ${ds.get("accountNo").toString().capitalize}",
                                                                              style: TextStyle(
                                                                                fontFamily: 'Kanit',
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              "Rs. ${ds.get("amount").toString()}",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 15,
                                                                                fontFamily: 'Kanit',
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Payment",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontFamily:
                                                                                'Kanit',
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          " ${ds.get("status").toString().capitalize}",
                                                                          style:
                                                                              TextStyle(
                                                                            color: ds.get("status") == "approved"
                                                                                ? Colors.green
                                                                                : Colors.red,
                                                                            fontFamily:
                                                                                'Kanit',
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      "$formattedTime / ${ds.get("date").toString().capitalize}",
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontFamily:
                                                                              'Kanit',
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          if (filteredDocs.length > 2)
                                            TextButton(
                                              onPressed: () {
                                                Get.to(AllTransactionScreen());
                                              },
                                              child: Text(
                                                "See More",
                                                style: TextStyle(
                                                    color: ColorConstant()
                                                        .appColor),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                        } else if (snapshot.hasError) {
                          return Center(child: const Icon(Icons.error_outline));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedText(String text) => Marquee(
        text: text,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        blankSpace: 20,
      );
}
