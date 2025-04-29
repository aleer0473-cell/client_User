import 'package:betapp/View/BPro_App_Wallet/payment_proof.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

// class SelectAccountToTransfer extends StatefulWidget {
//   final String amount;
//   SelectAccountToTransfer({required this.amount});

//   @override
//   State<SelectAccountToTransfer> createState() =>
//       _SelectAccountToTransferState();
// }

// class _SelectAccountToTransferState extends State<SelectAccountToTransfer> {
//   int? _selectedAccount;
//   var _selectedName;
//   var _selectNumber;
//   var _selectedTitle;

//   @override
//   Widget build(BuildContext context) {
//     var appSize = MediaQuery.of(context).size;
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
//                     color: Colors.grey,
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               const Text('Select Account to Transfer',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontFamily: 'Kanit')),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 'Transfer funds to the selected account and click the transfer button',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 11,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 60,
//               ),
//               StreamBuilder(
//                   stream: firebaseFirestore
//                       .collection("paymentMethod")
//                       .where("status", isEqualTo: "active")
//                       .snapshots(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     var data = snapshot.data?.docs;

//                     return snapshot.data?.size == 0
//                         ? Center(child: Text("No Payment Method "))
//                         : Column(
//                             children: [
//                               Container(
//                                 height: appSize.height * 0.4,
//                                 width: appSize.width,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 2,
//                                       blurRadius: 2,
//                                       offset: Offset(0, 2),
//                                     ),
//                                   ],
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10)),
//                                 ),
//                                 padding: EdgeInsets.all(10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('Select Service',
//                                         style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                             fontFamily: 'Kanit')),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Divider(),
//                                     SizedBox(
//                                       height: 13,
//                                     ),
//                                     SizedBox(
//                                       height: appSize.height * 0.27,
//                                       child: ListView.builder(
//                                           itemCount: data?.length,
//                                           itemBuilder: (BuildContext context,
//                                               int index) {
//                                             var ds = snapshot.data?.docs[index];
//                                             var name = ds?.get("name");
//                                             var numbr =
//                                                 ds?.get("accountHolderNumber");
//                                             var title =
//                                                 ds?.get("accountHolderName");

//                                             return GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _selectedAccount = index;
//                                                   _selectedName = name;
//                                                   _selectedTitle = title;
//                                                 });
//                                               },
//                                               child: Column(
//                                                 children: [
//                                                   CustomTile(
//                                                       index,
//                                                       name
//                                                                   .toString()
//                                                                   .toLowerCase() ==
//                                                               "jazzcash"
//                                                           ? 'assets/images/jazzcash.jpg'
//                                                           : name
//                                                                       .toString()
//                                                                       .toLowerCase() ==
//                                                                   "easypaisa"
//                                                               ? 'assets/images/easypaisa.png'
//                                                               : 'assets/images/bank.png',
//                                                       ds?.get(
//                                                           "accountHolderName"),
//                                                       ds?.get(
//                                                           "accountHolderNumber"),
//                                                       name
//                                                           .toString()
//                                                           .toUpperCase()),
//                                                   SizedBox(
//                                                     height:
//                                                         appSize.height * 0.025,
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           }),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: appSize.height * 0.16,
//                               ),
//                               _selectedAccount == null
//                                   ? SizedBox()
//                                   : Container(
//                                       width: 250,
//                                       child: ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           padding: const EdgeInsets.all(10),
//                                           foregroundColor: Colors.white,
//                                           backgroundColor: Colors.white,
//                                         ),
//                                         onPressed: (_selectedAccount == null)
//                                             ? null
//                                             : () {
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         PaymentProof(
//                                                             accountTile:
//                                                                 "$_selectedName",
//                                                             amount:
//                                                                 widget.amount,
//                                                             number:
//                                                                 "$_selectNumber",
//                                                             title:
//                                                                 "$_selectedTitle"),
//                                                   ),
//                                                 );
//                                               },
//                                         child: const Text('Transfer',
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 letterSpacing: 4,
//                                                 color: Color.fromARGB(
//                                                     255, 244, 176, 130),
//                                                 height: 1.5,
//                                                 fontFamily: 'Kanit')),
//                                       ),
//                                     ),
//                             ],
//                           );
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget CustomTile(
//       int value, String url, String title, String subtitle, String bankName) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedAccount = value;
//           _selectedName = bankName;
//           _selectNumber = subtitle;
//           _selectedTitle = title;
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 2,
//               offset: Offset(0, 2),
//             ),
//           ],
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//         ),
//         child: ListTile(
//           leading: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 bankName,
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xff293850).withOpacity(0.8),
//                     fontFamily: 'Kanit'),
//               ),
//               CircleAvatar(
//                 backgroundImage: AssetImage(url),
//                 radius: 18,
//               ),
//             ],
//           ),
//           title: Text(title,
//               style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Kanit')),
//           subtitle: Text(subtitle,
//               style: TextStyle(
//                   fontSize: 12,
//                   color: Color(0xff293850).withOpacity(0.6),
//                   fontFamily: 'Kanit')),
//           trailing: Radio<int>(
//             value: value,
//             activeColor: Color.fromARGB(255, 244, 176, 130),
//             groupValue: _selectedAccount,
//             onChanged: (int? newValue) {
//               setState(() {
//                 _selectedAccount = value;
//                 _selectedName = bankName;
//                 _selectNumber = subtitle;
//                 _selectedTitle = title;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget CustomTileReturn(
//       int value, String url, String title, String subtitle, String bankName) {
//     return Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: ColorConstant().appColor.withOpacity(0.5)),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: ListTile(
//             leading: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   bankName,
//                   style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xffff4f51),
//                       fontFamily: 'Kanit'),
//                 ),
//                 CircleAvatar(
//                   backgroundImage: AssetImage(url),
//                   radius: 20,
//                 ),
//               ],
//             ),
//             title: Text(title,
//                 style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Kanit')),
//             subtitle: Text(subtitle,
//                 style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xffff4f51),
//                     fontFamily: 'Kanit')),
//             trailing: IconButton(
//               icon: const Icon(Icons.copy),
//               onPressed: () {
//                 Clipboard.setData(ClipboardData(text: subtitle));
//                 Fluttertoast.showToast(
//                   msg: 'Account Number Copied to Clipboard',
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                   timeInSecForIosWeb: 1,
//                   backgroundColor: Color(0xff293850).withOpacity(0.5),
//                   textColor: Colors.white,
//                   fontSize: 16.0,
//                 );
//               },
//             )));
//   }
// }






class SelectAccountToTransfer extends StatefulWidget {
  final String amount;
  SelectAccountToTransfer({required this.amount});

  @override
  State<SelectAccountToTransfer> createState() =>
      _SelectAccountToTransferState();
}

class _SelectAccountToTransferState extends State<SelectAccountToTransfer> {
  int? _selectedAccount;
  var _selectedName;
  var _selectNumber;
  var _selectedTitle;

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
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
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('Select Account to Transfer',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Kanit')),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Transfer funds to the selected account and click the transfer button',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 60,
              ),
              StreamBuilder(
                  stream: firebaseFirestore
                      .collection("paymentMethod")
                      .where("status", isEqualTo: "active")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    var data = snapshot.data?.docs;

                    return snapshot.data?.size == 0
                        ? Center(child: Text("No Payment Method "))
                        : Column(
                            children: [
                              Container(
                                height: appSize.height * 0.4,
                                width: appSize.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Select Service',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'Kanit')),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 13,
                                    ),
                                    SizedBox(
                                      height: appSize.height * 0.27,
                                      child: ListView.builder(
                                          itemCount: data?.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var ds = snapshot.data?.docs[index];
                                            var name = ds?.get("name");
                                            var numbr =
                                                ds?.get("accountHolderNumber");
                                            var title =
                                                ds?.get("accountHolderName");

                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedAccount = index;
                                                  _selectedName = name;
                                                  _selectedTitle = title;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  CustomTile(
                                                      index,
                                                      name
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              "jazzcash"
                                                          ? 'assets/images/jazzcash.jpg'
                                                          : name
                                                                      .toString()
                                                                      .toLowerCase() ==
                                                                  "easypaisa"
                                                              ? 'assets/images/easypaisa.png'
                                                              : 'assets/images/bank.png',
                                                      ds?.get(
                                                          "accountHolderName"),
                                                      ds?.get(
                                                          "accountHolderNumber"),
                                                      name
                                                          .toString()
                                                          .toUpperCase()),
                                                  SizedBox(
                                                    height:
                                                        appSize.height * 0.025,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: appSize.height * 0.16,
                              ),
                              _selectedAccount == null
                                  ? SizedBox()
                                  : Container(
                                      width: 250,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(10),
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.white,
                                        ),
                                        onPressed: (_selectedAccount == null)
                                            ? null
                                            : () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentProof(
                                                            accountTile:
                                                                "$_selectedName",
                                                            amount:
                                                                widget.amount,
                                                            number:
                                                                "$_selectNumber",
                                                            title:
                                                                "$_selectedTitle"),
                                                  ),
                                                );
                                              },
                                        child: const Text('Transfer',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 4,
                                                color: Color.fromARGB(
                                                    255, 244, 176, 130),
                                                height: 1.5,
                                                fontFamily: 'Kanit')),
                                      ),
                                    ),
                            ],
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomTile(
      int value, String url, String title, String subtitle, String bankName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAccount = value;
          _selectedName = bankName;
          _selectNumber = subtitle;
          _selectedTitle = title;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                bankName,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff293850).withOpacity(0.8),
                    fontFamily: 'Kanit'),
              ),
              CircleAvatar(
                backgroundImage: AssetImage(url),
                radius: 18,
              ),
            ],
          ),
          title: Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit')),
          subtitle: Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff293850).withOpacity(0.6),
                  fontFamily: 'Kanit')),
          trailing: Radio<int>(
            value: value,
            activeColor: Color.fromARGB(255, 244, 176, 130),
            groupValue: _selectedAccount,
            onChanged: (int? newValue) {
              setState(() {
                _selectedAccount = value;
                _selectedName = bankName;
                _selectNumber = subtitle;
                _selectedTitle = title;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget CustomTileReturn(
      int value, String url, String title, String subtitle, String bankName) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstant().appColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bankName,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffff4f51),
                      fontFamily: 'Kanit'),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(url),
                  radius: 20,
                ),
              ],
            ),
            title: Text(title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit')),
            subtitle: Text(subtitle,
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xffff4f51),
                    fontFamily: 'Kanit')),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: subtitle));
                Fluttertoast.showToast(
                  msg: 'Account Number Copied to Clipboard',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color(0xff293850).withOpacity(0.5),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
            )));
  }
}