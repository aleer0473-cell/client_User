import 'dart:convert';
import 'dart:developer';
import 'package:betapp/View/BPro_App_Wallet/bpro_app_wallet_main.dart';
import 'package:betapp/constant/customdialog.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/utills/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class PaymentProof extends StatefulWidget {
  final String accountTile;
  final String amount;
  var number;
  var title;

  PaymentProof(
      {required this.accountTile,
      required this.amount,
      required this.number,
      required this.title});

  @override
  _PaymentProofState createState() => _PaymentProofState();
}

class _PaymentProofState extends State<PaymentProof> {
  bool chk = true;

  String? userName;
  String? userPhoneNumber;
  String? bproName;

  @override
  void initState() {
    super.initState();
    firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      userName = value.get("UserName");
      userPhoneNumber = value.get("phoneNumber");
      bproName = value.get("betProname");
    });
  }

  File? imageUrl;
  String? imageLink;
  final ImagePicker _picker = ImagePicker();

  void getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }

  // State to track upload progress

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 176, 130),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: ColorConstant().whiteColor,
            size: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 2.3,
                    width: 30,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    height: 2.3,
                    width: 30,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    height: 2.3,
                    width: 30,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: const Text('Send Payment Now',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Kanit')),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Transfer Rs. ${widget.amount} to the following account, attach the payment proof and click on submit.',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Kanit'),
              ),
              const SizedBox(height: 20),
              Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 244, 176, 130)),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.accountTile,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Kanit')),
                        Row(
                          children: [
                            Text('Account Title :  ',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontFamily: 'Kanit')),
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Account Number :  ',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontFamily: 'Kanit')),
                            Row(
                              children: [
                                Text(
                                  widget.number,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                InkWell(
                                    onTap: () {
                                      Clipboard.setData(
                                          ClipboardData(text: widget.number));
                                      Fluttertoast.showToast(
                                        msg: 'Account Number Copied',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            Color(0xff293850).withOpacity(0.5),
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    },
                                    child: Icon(
                                      Icons.copy,
                                      color: Colors.grey,
                                      size: 19,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: const Text('Submit Screenshot Here',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit')),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: getImage,
                child: Container(
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.40),
                      borderRadius: BorderRadius.circular(10)),
                  child: imageUrl == null
                      ? Icon(
                          Icons.photo_camera_back_outlined,
                          color: Colors.white,
                          size: 40,
                        )
                      : Image.file(imageUrl!),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  width: double.infinity,
                  child: const Text(
                    'Instructions',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: 'Kanit'),
                  )),
              Container(
                  width: double.infinity,
                  child: const Text(
                    '1. Send payment on above account',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Kanit',
                        fontSize: 12),
                  )),
              Container(
                  width: double.infinity,
                  child: const Text(
                    '2. Upload payment proof and submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Kanit',
                        fontSize: 12),
                  )),
              Container(
                  width: double.infinity,
                  child: const Text(
                    '3. Payment will be approved within 30 minutes',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Kanit',
                        fontSize: 12),
                  )),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: Container(
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white),
                    onPressed: () async {
                      Customdialog.showDialogBox(context);
                      await uploadImageToFirebase().then((value) async {
                        String currentDate =
                            DateFormat('dd-MM-yyyy').format(DateTime.now());

                        firebaseFirestore.collection("paymentRecord").add({
                          "paymentType": "deposit",
                          "bankType": widget.accountTile.toString(),
                          "amount": widget.amount.toString(),
                          "senderId": firebaseAuth.currentUser!.uid,
                          "date": currentDate,
                          "accountNo": widget.number,
                          "status": "pending",
                          "accountTitle": widget.title,
                          "bproName": bproName.toString(),
                          "currentDate": DateTime.now(),
                          "time": DateTime.now(),
                          "imageLink": imageLink
                        });
                      }).then((value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => BProWalletMain()),
                          (route) => false,
                        );
                      });
                    },
                    child: Text('SUBMIT',
                        style: TextStyle(
                            color: Color.fromARGB(255, 244, 176, 130),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            fontFamily: 'Kanit',
                            height: 1.5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future uploadImageToFirebase() async {
    File fileName = imageUrl!;
    var uuid = Uuid();
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('upload_category/images+${uuid.v4()}');
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(fileName);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() async {
      print(fileName);
      String img = await uploadTask.snapshot.ref.getDownloadURL();

      setState(() {
        imageLink = img;
      });
    });
  }
}

// import 'dart:convert';
// import 'dart:developer';
// import 'package:betapp/View/BPro_App_Wallet/bpro_app_wallet_main.dart';
// import 'package:betapp/constant/customdialog.dart';
// import 'package:betapp/utills/colors.dart';
// import 'package:betapp/utills/constants.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'package:image/image.dart' as img;

// class PaymentProof extends StatefulWidget {
//   final String accountTile;
//   final String amount;
//   var number;
//   var title;

//   PaymentProof(
//       {required this.accountTile,
//       required this.amount,
//       required this.number,
//       required this.title});

//   @override
//   _PaymentProofState createState() => _PaymentProofState();
// }

// class _PaymentProofState extends State<PaymentProof> {
//   bool chk = true;

//   String? userName;
//   String? userPhoneNumber;
//   String? bproName;

//   @override
//   void initState() {
//     super.initState();
//     firebaseFirestore
//         .collection("users")
//         .doc(firebaseAuth.currentUser!.uid)
//         .get()
//         .then((value) {
//       userName = value.get("UserName");
//       userPhoneNumber = value.get("phoneNumber");
//       bproName = value.get("betProname");
//     });
//   }

//   File? imageUrl;
//   String? imageLink;
//   final ImagePicker _picker = ImagePicker();

//   void getImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       imageUrl = File(image!.path);
//     });
//   }

//   // State to track upload progress

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 244, 176, 130),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_ios_new,
//             color: ColorConstant().whiteColor,
//             size: 25,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 2.3,
//                     width: 30,
//                     color: Colors.white,
//                   ),
//                   SizedBox(
//                     width: 7,
//                   ),
//                   Container(
//                     height: 2.3,
//                     width: 30,
//                     color: Colors.white,
//                   ),
//                   SizedBox(
//                     width: 7,
//                   ),
//                   Container(
//                     height: 2.3,
//                     width: 30,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Center(
//                 child: const Text('Send Payment Now',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontFamily: 'Kanit')),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 'Transfer Rs. ${widget.amount} to the following account, attach the payment proof and click on submit.',
//                 style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                     fontFamily: 'Kanit'),
//               ),
//               const SizedBox(height: 20),
//               // Container(
//               //     width: Get.width,
//               //     decoration: BoxDecoration(
//               //         border: Border.all(color: Color.fromARGB(255, 244, 176, 130)),
//               //         borderRadius: BorderRadius.circular(10),
//               //         color: Colors.white),
//               //     child: Padding(
//               //       padding: const EdgeInsets.all(8.0),
//               //       child: Column(
//               //         crossAxisAlignment: CrossAxisAlignment.start,
//               //         children: [
//               //           Text(widget.accountTile,
//               //               style: TextStyle(
//               //                   fontSize: 14,
//               //                   fontWeight: FontWeight.bold,
//               //                   color: Colors.black,
//               //                   fontFamily: 'Kanit')),
//               //           Row(
//               //             children: [
//               //               Text('Account Title :  ',
//               //                   style: TextStyle(
//               //                       fontSize: 13,
//               //                       fontWeight: FontWeight.w700,
//               //                       color: Colors.black,
//               //                       fontFamily: 'Kanit')),
//               //               Text(
//               //                 widget.title,
//               //                 style: TextStyle(
//               //                   fontSize: 13,
//               //                   fontWeight: FontWeight.w400,
//               //                   color: Colors.black,
//               //                 ),
//               //               )
//               //             ],
//               //           ),
//               //           Row(
//               //             children: [
//               //               Text('Account Number :  ',
//               //                   style: TextStyle(
//               //                       fontSize: 13,
//               //                       fontWeight: FontWeight.w700,
//               //                       color: Colors.black,
//               //                       fontFamily: 'Kanit')),
//               //               Row(
//               //                 children: [
//               //                   Text(
//               //                     widget.number,
//               //                     style: TextStyle(
//               //                       fontSize: 13,
//               //                       fontWeight: FontWeight.w400,
//               //                       color: Colors.black,
//               //                     ),
//               //                   ),
//               //                   SizedBox(
//               //                     width: 7,
//               //                   ),
//               //                   InkWell(
//               //                       onTap: () {
//               //                         Clipboard.setData(
//               //                             ClipboardData(text: widget.number));
//               //                         Fluttertoast.showToast(
//               //                           msg: 'Account Number Copied',
//               //                           toastLength: Toast.LENGTH_SHORT,
//               //                           gravity: ToastGravity.BOTTOM,
//               //                           timeInSecForIosWeb: 1,
//               //                           backgroundColor:
//               //                               Color(0xff293850).withOpacity(0.5),
//               //                           textColor: Colors.white,
//               //                           fontSize: 16.0,
//               //                         );
//               //                       },
//               //                       child: Icon(
//               //                         Icons.copy,
//               //                         color: Colors.grey,
//               //                         size: 19,
//               //                       ))
//               //                 ],
//               //               )
//               //             ],
//               //           ),
//               //         ],
//               //       ),
//               //     )),
//               // const SizedBox(height: 20),
//               // Container(
//               //   width: double.infinity,
//               //   child: const Text('Submit Screenshot Here',
//               //       style: TextStyle(
//               //           fontSize: 15,
//               //           color: Colors.white,
//               //           fontWeight: FontWeight.bold,
//               //           fontFamily: 'Kanit')),
//               // ),
//               // const SizedBox(height: 10),
//               // GestureDetector(
//               //   onTap: getImage,
//               //   child: Container(
//               //     width: double.infinity,
//               //     height: 170,
//               //     decoration: BoxDecoration(
//               //         color: Colors.grey.withOpacity(.40),
//               //         borderRadius: BorderRadius.circular(10)),
//               //     child: imageUrl == null
//               //         ? Icon(
//               //             Icons.photo_camera_back_outlined,
//               //             color: Colors.white,
//               //             size: 40,
//               //           )
//               //         : Image.file(imageUrl!),
//               //   ),
//               // ),
//               // 🟢 ACCOUNT DETAILS CARD
//               Container(
//                 width: Get.width,
//                 padding: const EdgeInsets.all(16),
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 8,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                   border: Border.all(
//                       color: Color.fromARGB(255, 244, 176, 130), width: 1.5),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.accountTile,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Kanit',
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         const Text(
//                           'Account Title: ',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Kanit',
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             widget.title,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: 'Kanit',
//                               color: Colors.black87,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Text(
//                           'Account Number: ',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Kanit',
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Text(
//                           widget.number,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Kanit',
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         GestureDetector(
//                           onTap: () {
//                             Clipboard.setData(
//                                 ClipboardData(text: widget.number));
//                             Fluttertoast.showToast(
//                               msg: 'Account Number Copied',
//                               toastLength: Toast.LENGTH_SHORT,
//                               gravity: ToastGravity.BOTTOM,
//                               backgroundColor: Colors.black.withOpacity(0.6),
//                               textColor: Colors.white,
//                             );
//                           },
//                           child: const Icon(Icons.copy,
//                               color: Color.fromARGB(255, 244, 176, 130),
//                               size: 20),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 25),

// // 🖼️ UPLOAD SCREENSHOT SECTION
//               Text(
//                 'Submit Screenshot Here',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontFamily: 'Kanit',
//                 ),
//               ),

//               const SizedBox(height: 10),

//               GestureDetector(
//                 onTap: getImage,
//                 child: Container(
//                   width: double.infinity,
//                   height: 180,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.15),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                         color: Colors.white70,
//                         style: BorderStyle.solid,
//                         width: 1.2),
//                     image: imageUrl != null
//                         ? DecorationImage(
//                             image: FileImage(imageUrl!),
//                             fit: BoxFit.cover,
//                           )
//                         : null,
//                   ),
//                   child: imageUrl == null
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Icon(Icons.cloud_upload_outlined,
//                                 color: Colors.white70, size: 38),
//                             SizedBox(height: 8),
//                             Text(
//                               "Tap to upload screenshot",
//                               style: TextStyle(
//                                 color: Colors.white60,
//                                 fontFamily: 'Kanit',
//                                 fontSize: 14,
//                               ),
//                             )
//                           ],
//                         )
//                       : null,
//                 ),
//               ),

//               SizedBox(height: 10),
//               Container(
//                   width: double.infinity,
//                   child: const Text(
//                     'Instructions',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 13,
//                         fontFamily: 'Kanit'),
//                   )),
//               Container(
//                   width: double.infinity,
//                   child: const Text(
//                     '1. Send payment on above account',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Kanit',
//                         fontSize: 12),
//                   )),
//               Container(
//                   width: double.infinity,
//                   child: const Text(
//                     '2. Upload payment proof and submit',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Kanit',
//                         fontSize: 12),
//                   )),
//               Container(
//                   width: double.infinity,
//                   child: const Text(
//                     '3. Payment will be approved within 30 minutes',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Kanit',
//                         fontSize: 12),
//                   )),
//               const SizedBox(
//                 height: 10,
//               ),
//               // const SizedBox(
//               //   height: 60,
//               // ),
//               Center(
//                 child: Container(
//                   width: 250,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.all(10),
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.white),
//                     onPressed: () async {
//                       Customdialog.showDialogBox(context);
//                       await uploadImageToFirebase().then((value) async {
//                         String currentDate =
//                             DateFormat('dd-MM-yyyy').format(DateTime.now());

//                         firebaseFirestore.collection("paymentRecord").add({
//                           "paymentType": "deposit",
//                           "bankType": widget.accountTile.toString(),
//                           "amount": widget.amount.toString(),
//                           "senderId": firebaseAuth.currentUser!.uid,
//                           "date": currentDate,
//                           "accountNo": widget.number,
//                           "status": "pending",
//                           "accountTitle": widget.title,
//                           "bproName": bproName.toString(),
//                           "currentDate": DateTime.now(),
//                           "time": DateTime.now(),
//                           "imageLink": imageLink
//                         });
//                       }).then((value) {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(builder: (_) => BProWalletMain()),
//                           (route) => false,
//                         );
//                       });
//                     },
//                     child: Text('SUBMIT',
//                         style: TextStyle(
//                             color: Color.fromARGB(255, 244, 176, 130),
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 4,
//                             fontFamily: 'Kanit',
//                             height: 1.5)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future uploadImageToFirebase() async {
//     File fileName = imageUrl!;
//     var uuid = Uuid();
//     firebase_storage.Reference firebaseStorageRef = firebase_storage
//         .FirebaseStorage.instance
//         .ref()
//         .child('upload_category/images+${uuid.v4()}');
//     firebase_storage.UploadTask uploadTask =
//         firebaseStorageRef.putFile(fileName);
//     firebase_storage.TaskSnapshot taskSnapshot =
//         await uploadTask.whenComplete(() async {
//       print(fileName);
//       String img = await uploadTask.snapshot.ref.getDownloadURL();

//       setState(() {
//         imageLink = img;
//       });
//     });
//   }
// }
