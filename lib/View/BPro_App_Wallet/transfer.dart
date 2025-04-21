import 'dart:convert';
import 'dart:developer';

import 'package:betapp/constant/customdialog.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Transfer extends StatefulWidget {
  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  bool changeTransfer = false;
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void switchTransfer() {
      changeTransfer = !changeTransfer;
      print(changeTransfer);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant().appColor.withOpacity(0.8),
        automaticallyImplyLeading: false,
        title: const Text(
          'Transfer Balance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kanit',
          ),
        ),
        centerTitle: true,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor:
                ColorConstant().appColor, // Change global cursor color here
            selectionHandleColor:
                ColorConstant().appColor, // Change handle color here
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
              stream: firebaseFirestore
                  .collection("users")
                  .doc(firebaseAuth.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  var ds = snapshot.data!;
                  var username = ds.get("UserName");
                  var balance = ds.get("balance");
                  var status = ds.get("userStatus");
                  var id = ds.id;
                  var bProUser = ds.get("betProname");
                  var bProUserPassw = ds.get("betPropassword");
                  var boolUser = ds.get("boolPhone");

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: 'From ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Kanit',
                                              decoration: TextDecoration.none)),
                                      TextSpan(
                                        text: changeTransfer
                                            ? 'my BPro Account'
                                            : 'this wallet',
                                        style: TextStyle(
                                            color: ColorConstant().appColor,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'Kanit',
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_downward),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: 'To ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Kanit',
                                              decoration: TextDecoration.none)),
                                      TextSpan(
                                        text: changeTransfer
                                            ? 'this wallet'
                                            : 'my BPro Account',
                                        style: TextStyle(
                                            color: ColorConstant().appColor,
                                            fontFamily: 'Kanit',
                                            decoration: TextDecoration.none,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  switchTransfer();
                                });
                              },
                              icon: const Icon(Icons.swap_horiz),
                              iconSize: 30,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: amountController,
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Kanit'),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter Amount',
                            hintText: '0',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Kanit',
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Kanit',
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorConstant().appColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Available Balance',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                ds.get("balance"),
                                style: TextStyle(
                                  color: ColorConstant().appColor,
                                  fontSize: 12,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              foregroundColor: Colors.white,
                              backgroundColor: ColorConstant().appColor,
                            ),
                            onPressed: () {
                              double enteredAmount =
                                  double.parse(amountController.text);
                              double walletAmount = double.parse(balance!);
                              var checkData = changeTransfer == true
                                  ? 'my BPro Account'
                                  : 'this wallet';
                              print(checkData);

                              // Check if status is "pending"
                              if (status.toString().toLowerCase() ==
                                  "pending") {
                                Customdialog().showInSnackBar(
                                    "Please activate your BPro account from admin",
                                    context);
                                return;
                              }

                              // If checkData is "this wallet", proceed with balance check
                              if (checkData == 'this wallet') {
                                if (balance == null) {
                                  // Handle case when wallet value is not available
                                  print("Wallet value is not available");
                                  return;
                                }

                                if (amountController.text.isEmpty) {
                                  Customdialog().showInSnackBar(
                                      "Please enter an amount", context);
                                  return;
                                }

                                if (enteredAmount > walletAmount) {
                                  Customdialog.showBox(context,
                                      "Your Balance is low. Please recharge it first");
                                  return;
                                }
                              }

                              // Proceed with transfer logic if balance is sufficient or not checked
                              String currentDate = DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now());
                              Customdialog.showDialogBox(context);
                              var newAmount = walletAmount - enteredAmount;
                              DateTime currentTime = DateTime.now();
                              String formattedTime =
                                  DateFormat('hh:mm a').format(currentTime);

                              FirebaseFirestore.instance
                                  .collection("transfer")
                                  .add({
                                "imageLink": "",
                                "bankType": checkData,
                                "amount": amountController.text.trim(),
                                "senderId": firebaseAuth.currentUser!.uid,
                                "date": currentDate,
                                "accountName": bProUser,
                                "accountPassword": bProUserPassw,
                                "status": "pending",
                                "email": boolUser == false
                                    ? ds.get("Email")
                                    : ds.get("phoneNumber"),
                                "time": DateTime.now(),
                              }).then((value) async => {
                                        if (checkData == "this wallet")
                                          {
                                            await firebaseFirestore
                                                .collection("users")
                                                .doc(id)
                                                .update({
                                              "balance": newAmount.toString()
                                            }),
                                          },
                                        Navigator.pop(context),
                                        sendPushMessage(
                                          title: "Transfer Request",
                                          body:
                                              "Dear Admin, You have a new transfer of ${amountController.text} from $username",
                                        ),
                                        Customdialog.showBox(context,
                                            "Request submitted successfully"),
                                        amountController.clear(),
                                      });
                            },
                            child: const Text('Transfer',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: double.infinity,
                          child: const Text(
                            'Transfer History',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        StreamBuilder(
                            stream: firebaseFirestore
                                .collection("transfer")
                                .where("senderId",
                                    isEqualTo: firebaseAuth.currentUser!.uid)

                                // Then order by time (descending)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!;
                                return snapshot.data?.size == 0
                                    ? Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child:
                                            Center(child: Text("No History")),
                                      )
                                    : Column(
                                        children: [
                                          Container(
                                            height: 310,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data?.docs.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                List<DocumentSnapshot> docs =
                                                    snapshot.data!.docs;

                                                // Sort the documents based on the 'time' field
                                                docs.sort((a, b) {
                                                  // Get the 'time' field as a Timestamp
                                                  Timestamp timeA =
                                                      a.get("time");
                                                  Timestamp timeB =
                                                      b.get("time");

                                                  // Convert Timestamp to DateTime
                                                  DateTime dateTimeA =
                                                      timeA.toDate();
                                                  DateTime dateTimeB =
                                                      timeB.toDate();

                                                  // Sort in descending order (latest time first)
                                                  return dateTimeB
                                                      .compareTo(dateTimeA);
                                                });

                                                var ds = docs[index];
                                                var time =
                                                    ds.get("time").toDate();
                                                String formattedTime =
                                                    DateFormat('hh:mm a')
                                                        .format(time);
                                                var postStatus =
                                                    ds.get("status");

                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                ColorConstant()
                                                                    .appColor),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: GestureDetector(
                                                          onTap: () {},
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                child: ListTile(
                                                                  title: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "From:",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: 'Kanit'),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15,
                                                                          ),
                                                                          Text(
                                                                            "${ds.get("bankType").toString().capitalize}",
                                                                            style: TextStyle(
                                                                                color: ColorConstant().appColor,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: 'Kanit'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  subtitle:
                                                                      Column(
                                                                    children: [
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          "UserName:  ${ds.get("accountName").toString().capitalize}", // Dummy value
                                                                          style:
                                                                              TextStyle(fontFamily: 'Kanit'),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          "Password:  ${ds.get("accountPassword").toString().capitalize}", // Dummy value
                                                                          style:
                                                                              TextStyle(fontFamily: 'Kanit'),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              "Time: $formattedTime", // Dummy value
                                                                              style: TextStyle(fontFamily: 'Kanit'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  trailing:
                                                                      Text(
                                                                    "${ds.get("amount").toString()} Rs", // Dummy value
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontFamily:
                                                                            'Kanit'),
                                                                  ),
                                                                ),
                                                              ),
                                                              const Divider(),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "${ds.get("status").toString().capitalize}", // Dummy value
                                                                      style: TextStyle(
                                                                          color: ds.get("status") == "approved"
                                                                              ? ColorConstant().appColor
                                                                              : Colors.red,
                                                                          fontFamily: 'Kanit'),
                                                                    ),
                                                                    Text(
                                                                      "${ds.get("date").toString().capitalize}", // Dummy value
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              'Kanit'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: const Icon(Icons.error_outline));
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: const Icon(Icons.error_outline));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  String constructFCMPayload({String? title, String? body}) {
    // _messageCount++;
    log("Step 2 complete");

    return jsonEncode({
      'to': '/topics/all',
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        // 'count': _messageCount.toString(),
      },
      'notification': {
        'title': title,
        'body': body,
      },
      'android': {
        'notification': {},
      }
    });
  }

  Future<void> sendPushMessage({String? title, String? body}) async {
    // if (widget.receiverToken == null) {
    //   print('Unable to send FCM message, no token exists.');
    //   return;
    // }
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              "key=AAAAHHXDMfU:APA91bEXuOxQyRNyt6Hpu8JOiyt-d_eFMsHY48zig3DgLFrwimxoJisxHMmw7IZp0ccli0XJBuADhBQMeQHjpGI6Z0DWIct5ur5LXSbmioYXxUp39elS00Sh-1xWOzxZ9O0yOSUTBCvz",
        },
        body: constructFCMPayload(body: body, title: title),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('FCM request for device sent!')));
      print('FCM request for device sent!');
    } catch (e) {
      print("dhdddddddddddddd");
      print(e);
      print("dhdddddddddddddd");
    }
  }
}
