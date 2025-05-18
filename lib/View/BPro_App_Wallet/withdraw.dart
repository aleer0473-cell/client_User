import 'dart:convert';
import 'dart:developer';
import 'package:betapp/constant/customdialog.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/utills/constants.dart';
import 'package:betapp/widgets/mybutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Withdraw extends StatefulWidget {
  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  int? _radioValue = 0;
  List<Widget> widgets = [];
  bool widgetNotAdded = true;
  TextEditingController amountController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController accountTitleController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  void bankNameTextField() {
    if (widgetNotAdded && _radioValue == 3) {
      setState(() {
        widgets.add(TextField(
          controller: bankNameController,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: Colors.black, fontFamily: 'Kanit'),
          decoration: InputDecoration(
            labelText: 'Enter Bank Name',
            hintText: 'Bank Name',
            labelStyle: TextStyle(color: Colors.black, fontFamily: 'Kanit'),
            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Kanit'),
            suffixStyle: TextStyle(color: ColorConstant().appColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstant().appColor),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ));
      });
      widgetNotAdded = false;
    } else if (_radioValue != 3 && !widgetNotAdded) {
      setState(() {
        widgets.clear();
        widgetNotAdded = true;
      });
    }
  }

  var time;

  var balance;

  @override
  void initState() {
    firebaseFirestore
        .collection("socialInfo")
        .doc("dzwAYcmZTRizAd0fkERh")
        .get()
        .then((value) {
      time = value.get("withdrawTime");
    });

    super.initState();
  }

  var cancelId;
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 176, 130),
      body: StreamBuilder(
          stream: firebaseFirestore
              .collection("users")
              .doc(firebaseAuth.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              var ds = snapshot.data!;
              var username = ds.get("UserName");
              var balance = ds.get("balance");
              var status = ds.get("userStatus");
              var bproName = ds.get("betProname");
              var id = ds.id;
              return Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 25,
                          )),
                      StreamBuilder(
                          stream: firebaseFirestore
                              .collection("paymentRecord")
                              .where("senderId",
                                  isEqualTo: firebaseAuth.currentUser!.uid)
                              .where("paymentType", isEqualTo: "withdraw")
                              .where("status", isEqualTo: "pending")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data?.docs;
                              var length = data?.length;
                              return length == 0 || length == null
                                  ? Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          child: const Text(
                                            'Transfer History',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Kanit',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        TextField(
                                          controller: amountController,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Kanit'),
                                          decoration: InputDecoration(
                                            labelText: 'Enter Amount',
                                            hintText: '1000',
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Kanit'),
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: 'Kanit'),
                                            suffixText: 'MAX',
                                            suffixStyle: TextStyle(
                                                color:
                                                    ColorConstant().appColor),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      ColorConstant().appColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: const Text(
                                            'Account Details',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    ColorConstant().appColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          child: Column(children: [
                                            Container(
                                                width: double.infinity,
                                                child: const Text(
                                                    'Choose Payment Method',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Kanit',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))),
                                            const SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorConstant()
                                                        .appColor),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _radioValue = 1;
                                                    bankNameTextField();
                                                  });
                                                },
                                                child: ListTile(
                                                  title: const Text(
                                                    'EasyPaisa',
                                                    style: TextStyle(
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                  leading: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Radio<int>(
                                                        value: 1,
                                                        activeColor:
                                                            // Color(0xff1a444f),
                                                            Colors.white,
                                                        groupValue: _radioValue,
                                                        onChanged:
                                                            (int? value) {
                                                          setState(() {
                                                            _radioValue = value;
                                                            bankNameTextField();
                                                          });
                                                        },
                                                      ),
                                                      Image.asset(
                                                          'assets/images/easypaisa.png',
                                                          width: 40,
                                                          height: 40),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorConstant()
                                                        .appColor),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _radioValue = 2;
                                                    bankNameTextField();
                                                  });
                                                },
                                                child: ListTile(
                                                  title: const Text(
                                                    'JazzCash',
                                                    style: TextStyle(
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                  leading: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Radio<int>(
                                                        value: 2,
                                                        activeColor:
                                                            // Color(0xff1a444f),
                                                            Colors.white,
                                                        groupValue: _radioValue,
                                                        onChanged:
                                                            (int? value) {
                                                          setState(() {
                                                            _radioValue = value;
                                                            bankNameTextField();
                                                          });
                                                        },
                                                      ),
                                                      Image.asset(
                                                          'assets/images/jazzcash.jpg',
                                                          width: 40,
                                                          height: 40),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorConstant()
                                                        .appColor),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _radioValue = 3;
                                                    bankNameTextField();
                                                  });
                                                },
                                                child: ListTile(
                                                  title: const Text(
                                                    'Bank',
                                                    style: TextStyle(
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                  leading: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Radio<int>(
                                                        value: 3,
                                                        activeColor:
                                                            // Color(0xff1a444f),
                                                            Colors.white,
                                                        groupValue: _radioValue,
                                                        onChanged:
                                                            (int? value) {
                                                          setState(() {
                                                            _radioValue = value;
                                                            bankNameTextField();
                                                          });
                                                        },
                                                      ),
                                                      const Icon(
                                                        Icons.account_balance,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: widgets.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return widgets[index];
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            TextField(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Kanit'),
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: accountNoController,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Enter Account Number',
                                                hintText: 'Account Number',
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Kanit'),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'Kanit'),
                                                suffixStyle: TextStyle(
                                                    color: ColorConstant()
                                                        .appColor),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorConstant()
                                                          .appColor),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            TextField(
                                              controller:
                                                  accountTitleController,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Kanit'),
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Enter Account Title',
                                                hintText: 'Account Title',
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Kanit'),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'Kanit'),
                                                suffixStyle: TextStyle(
                                                    color: ColorConstant()
                                                        .appColor),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorConstant()
                                                          .appColor),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          width: 250,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(10),
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  // Color(0xff1a444f),
                                                  Colors.white
                                                      .withValues(alpha: 0.2),
                                            ),
                                            onPressed: () {
                                              if (amountController
                                                      .text.isEmpty ||
                                                  accountNoController
                                                      .text.isEmpty ||
                                                  accountTitleController
                                                      .text.isEmpty) {
                                                Customdialog().showInSnackBar(
                                                    "Please enter the required fields",
                                                    context);
                                                return;
                                              } else {
                                                if (status
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "pending") {
                                                  Customdialog().showInSnackBar(
                                                      "Please activate your BPro account from admin",
                                                      context);
                                                  return;
                                                } else {
                                                  String currentDate =
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(
                                                              DateTime.now());
                                                  Customdialog.showDialogBox(
                                                      context);

                                                  DateTime currentTime =
                                                      DateTime.now();
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          "paymentRecord")
                                                      .add({
                                                    "imageLink": "",
                                                    "paymentType": "withdraw",
                                                    "bankType": _radioValue == 1
                                                        ? "easypaisa"
                                                        : _radioValue == 2
                                                            ? "jazzcash"
                                                            : bankNameController
                                                                .text
                                                                .trim(),
                                                    "amount": amountController
                                                        .text
                                                        .trim(),
                                                    "senderId": firebaseAuth
                                                        .currentUser!.uid,
                                                    "date": currentDate,
                                                    "accountNo":
                                                        accountNoController.text
                                                            .trim(),
                                                    "status": "pending",
                                                    "bproName":
                                                        bproName.toString(),
                                                    "accountTitle":
                                                        accountTitleController
                                                            .text
                                                            .trim(),
                                                    "currentDate":
                                                        DateTime.now(),
                                                    "time": DateTime.now(),
                                                  }).then((value) async => {
                                                            await firebaseFirestore
                                                                .collection(
                                                                    "users")
                                                                .doc(id)
                                                                .update({
                                                              "balance": 0,
                                                            }),
                                                            Navigator.pop(
                                                                context),
                                                            sendPushMessage(
                                                              title:
                                                                  "Withdraw Request",
                                                              body:
                                                                  "Dear Admin You have new deposit of ${amountController.text} from $username",
                                                            ),
                                                            amountController
                                                                .clear(),
                                                            accountTitleController
                                                                .clear(),
                                                            accountNoController
                                                                .clear(),
                                                          });
                                                }
                                              }
                                            },
                                            child: const Text('Submit',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Kanit',
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2)),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                            color: Color(0xff1a444f)
                                                .withOpacity(0.4),
                                            child: Text(
                                                "You will receive the payment within ${time}.",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontFamily: 'Kanit',
                                                  fontWeight: FontWeight.bold,
                                                ))),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          height: 259,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data?.docs.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              List<DocumentSnapshot> docs =
                                                  snapshot.data!.docs;

                                              // Sort the documents based on the 'time' field
                                              docs.sort((a, b) {
                                                // Get the 'time' field as a Timestamp
                                                Timestamp timeA = a.get("time");
                                                Timestamp timeB = b.get("time");

                                                // Convert Timestamp to DateTime
                                                DateTime dateTimeA =
                                                    timeA.toDate();
                                                DateTime dateTimeB =
                                                    timeB.toDate();

                                                // Sort in descending order (latest time first)
                                                return dateTimeB
                                                    .compareTo(dateTimeA);
                                              });

                                              var ds1 = docs[index];
                                              cancelId = ds1.id;
                                              var time =
                                                  ds1.get("time").toDate();
                                              String formattedTime =
                                                  DateFormat('hh:mm a')
                                                      .format(time);
                                              var paymentType =
                                                  ds1.get("paymentType");

                                              var userAmount =
                                                  ds1.get("amount");
                                              return Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ColorConstant()
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
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            ds1.get("status") ==
                                                                        "pending" &&
                                                                    paymentType ==
                                                                        "withdraw"
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      // GestureDetector(
                                                                      //     onTap: (){
                                                                      //       Navigator.push(context,
                                                                      //           MaterialPageRoute(builder: (context) => TransactionUpdateScreen(id: ds.id, amount: ds.get("amount"))));
                                                                      //     },
                                                                      //     child: Icon(Icons.edit,color: Colors.black,)),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),

                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  )
                                                                : SizedBox(),
                                                            Container(
                                                              child: ListTile(
                                                                title: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "${ds1.get("paymentType").toString().capitalize}",
                                                                      style: TextStyle(
                                                                          color: ColorConstant()
                                                                              .appColor,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              'Kanit'),
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
                                                                        "${ds1.get("accountTitle").toString().capitalize}", // Dummy value
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Kanit'),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Text(
                                                                        "${ds1.get("accountNo").toString().capitalize}", // Dummy value
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Kanit'),
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
                                                                            'Savings', // Dummy value
                                                                            style:
                                                                                TextStyle(fontFamily: 'Kanit'),
                                                                          ),
                                                                          Text(
                                                                            ds1.get("bankType").toString().toUpperCase(), // Dummy value
                                                                            style:
                                                                                TextStyle(fontFamily: 'Kanit'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                trailing: Text(
                                                                  "${ds1.get("amount").toString()} Rs", // Dummy value
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
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "${ds1.get("status").toString().capitalize}", // Dummy value
                                                                    style: TextStyle(
                                                                        color: ds1.get("status") ==
                                                                                "approved"
                                                                            ? ColorConstant()
                                                                                .appColor
                                                                            : Colors
                                                                                .red,
                                                                        fontFamily:
                                                                            'Kanit'),
                                                                  ),
                                                                  Text(
                                                                    "$formattedTime / ${ds1.get("date").toString().capitalize}", // Dummy value
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
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
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: appSize.height * 0.15),
                                          padding: EdgeInsets.all(8),
                                          width: appSize.width * 0.9,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: Color(0xff1a444f)
                                                  .withOpacity(.50)),
                                          child: Text(
                                            "YOU WILL RECEIVE PAYMENT WITHIN $time.",
                                            style: TextStyle(
                                                fontSize:
                                                    appSize.width * 0.035),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 16, top: 10),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Note:",
                                              style: TextStyle(
                                                  fontSize:
                                                      appSize.width * 0.037,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 15, top: 3),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "1-Ye Withdraw request ap cancel bhi kar sakte hain.",
                                              style: TextStyle(
                                                  fontSize:
                                                      appSize.width * 0.033,
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 15, top: 3),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "2-Apke paise wapis apke Batproexch App account me add hojainge",
                                              style: TextStyle(
                                                  fontSize:
                                                      appSize.width * 0.033,
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: appSize.height * 0.19,
                                        ),
                                        MyButton(
                                          onPressed: () async {
                                            print(cancelId);
                                            // double
                                            //     enteredAmount =
                                            //     double.parse(userAmount);
                                            // double
                                            //     walletAmount =
                                            //     double.parse(balance);
                                            // var newAmount =
                                            //     walletAmount + enteredAmount;
                                            await firebaseFirestore
                                                .collection("paymentRecord")
                                                .doc(cancelId)
                                                .update({
                                              "status": "cancelled",
                                            });
                                            // await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).update({
                                            //   "balance": newAmount.toString(),
                                            // });
                                          },
                                          color: Colors.red,
                                          text: "Cancel Withdraw",
                                        )
                                      ],
                                    );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: const Icon(Icons.error_outline));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: const Icon(Icons.error_outline));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
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
              "key=AAAAsmsxB4E:APA91bFZyx397fcBhq4zoEF5s-dkMnmerylcn0CfYeVIUs7uRXMEgkF5ezw-PFLS0kpwQoN9hPrx1fikqKKGbK7lBX3A85W8Z9F44jvxgYCLtiRUmegh7D5ainm2bTHdMa7jFGphodoX",
        },
        body: constructFCMPayload(body: body, title: title),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request submitted successfully')));
      print('FCM request for device sent!');
    } catch (e) {
      print("dhdddddddddddddd");
      print(e);
      print("dhdddddddddddddd");
    }
  }
}

// /////////////////////////////////////////////

// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

// class Withdraw extends StatefulWidget {
//   @override
//   _WithdrawState createState() => _WithdrawState();
// }

// class _WithdrawState extends State<Withdraw> {
//   int? _selectedMethod = 0;
//   bool showBankNameField = false;

//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController accountNoController = TextEditingController();
//   final TextEditingController accountTitleController = TextEditingController();
//   final TextEditingController bankNameController = TextEditingController();

//   String? withdrawTime;
//   String? userBalance;
//   String? userStatus;
//   String? bproName;
//   String? pendingWithdrawId;
//   String? selectedMethodName = "Select Payment Method";

//   @override
//   void initState() {
//     super.initState();
//     _fetchWithdrawTime();
//     _fetchUserData();
//   }

//   void _fetchWithdrawTime() async {
//     final doc = await FirebaseFirestore.instance
//         .collection("socialInfo")
//         .doc("dzwAYcmZTRizAd0fkERh")
//         .get();
//     setState(() {
//       withdrawTime = doc.get("withdrawTime");
//     });
//   }

//   void _fetchUserData() async {
//     final doc = await FirebaseFirestore.instance
//         .collection("users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     setState(() {
//       userBalance = doc.get("balance");
//       userStatus = doc.get("userStatus");
//       bproName = doc.get("betProname");
//     });
//   }

//   void _handleMethodSelection(int? value) {
//     setState(() {
//       _selectedMethod = value;
//       showBankNameField = value == 3;
//       if (!showBankNameField) {
//         bankNameController.clear();
//       }
//     });
//   }

//   Future<void> _submitWithdrawal() async {
//     if (amountController.text.isEmpty ||
//         accountNoController.text.isEmpty ||
//         accountTitleController.text.isEmpty ||
//         (_selectedMethod == 3 && bankNameController.text.isEmpty) ||
//         _selectedMethod == 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill all required fields')),
//       );
//       return;
//     }

//     if (userStatus?.toLowerCase() == "pending") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please activate your BPro account from admin')),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Center(child: CircularProgressIndicator()),
//     );

//     try {
//       final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

//       await FirebaseFirestore.instance.collection("paymentRecord").add({
//         "imageLink": "",
//         "paymentType": "withdraw",
//         "bankType": _selectedMethod == 1
//             ? "easypaisa"
//             : _selectedMethod == 2
//                 ? "jazzcash"
//                 : bankNameController.text.trim(),
//         "amount": amountController.text.trim(),
//         "senderId": FirebaseAuth.instance.currentUser!.uid,
//         "date": currentDate,
//         "accountNo": accountNoController.text.trim(),
//         "status": "pending",
//         "bproName": bproName,
//         "accountTitle": accountTitleController.text.trim(),
//         "currentDate": DateTime.now(),
//         "time": DateTime.now(),
//       });

//       // Reset form
//       amountController.clear();
//       accountTitleController.clear();
//       accountNoController.clear();
//       bankNameController.clear();
//       setState(() {
//         _selectedMethod = 0;
//         selectedMethodName = "Select Payment Method";
//       });

//       // Send notification
//       await _sendAdminNotification();

//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Withdrawal request submitted successfully')),
//       );
//     } catch (e) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error submitting withdrawal: $e')),
//       );
//     }
//   }

//   Future<void> _cancelWithdrawal() async {
//     if (pendingWithdrawId == null) return;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Center(child: CircularProgressIndicator()),
//     );

//     try {
//       await FirebaseFirestore.instance
//           .collection("paymentRecord")
//           .doc(pendingWithdrawId)
//           .update({"status": "cancelled"});

//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Withdrawal cancelled successfully')),
//       );
//     } catch (e) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error cancelling withdrawal: $e')),
//       );
//     }
//   }

//   Future<void> _sendAdminNotification() async {
//     try {
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization':
//               'key=AAAAsmsxB4E:APA91bFZyx397fcBhq4zoEF5s-dkMnmerylcn0CfYeVIUs7uRXMEgkF5ezw-PFLS0kpwQoN9hPrx1fikqKKGbK7lBX3A85W8Z9F44jvxgYCLtiRUmegh7D5ainm2bTHdMa7jFGphodoX',
//         },
//         body: jsonEncode({
//           'to': '/topics/admin',
//           'notification': {
//             'title': 'New Withdrawal Request',
//             'body': 'New withdrawal request of ${amountController.text}',
//           },
//         }),
//       );
//     } catch (e) {
//       print('Error sending notification: $e');
//     }
//   }

//   void _showPaymentMethodBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           color: Colors.grey.withValues(alpha: 0.10),
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Choose Payment Method',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1A444F),
//                 ),
//               ),
//               SizedBox(height: 20),
//               _buildPaymentMethodTile(
//                 icon: Icons.phone_android,
//                 title: 'EasyPaisa',
//                 value: 1,
//               ),
//               Divider(height: 1),
//               _buildPaymentMethodTile(
//                 icon: Icons.phone_iphone,
//                 title: 'JazzCash',
//                 value: 2,
//               ),
//               Divider(height: 1),
//               _buildPaymentMethodTile(
//                 icon: Icons.account_balance,
//                 title: 'Bank Transfer',
//                 value: 3,
//               ),
//               SizedBox(height: 20),
//               Container(
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 25, 188, 213),
//                     borderRadius: BorderRadius.circular(100)),
//                 child: TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('     CLOSE     '),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPaymentMethodTile({
//     required IconData icon,
//     required String title,
//     required int value,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//           border: Border.all(
//             color: const Color.fromARGB(255, 25, 188, 213),
//             width: 2,
//           ),
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         children: [
//           ListTile(
//             leading: Icon(icon, color: Color(0xFF1A444F)),
//             title: Text(title),
//             trailing: Radio<int>(
//               value: value,
//               groupValue: _selectedMethod,
//               onChanged: (int? value) {
//                 setState(() {
//                   _selectedMethod = value;
//                   showBankNameField = value == 3;
//                   selectedMethodName = title;
//                   if (!showBankNameField) {
//                     bankNameController.clear();
//                   }
//                 });
//                 Navigator.pop(context);
//               },
//               activeColor: Color(0xFF1A444F),
//             ),
//             onTap: () {
//               setState(() {
//                 _selectedMethod = value;
//                 showBankNameField = value == 3;
//                 selectedMethodName = title;
//                 if (!showBankNameField) {
//                   bankNameController.clear();
//                 }
//               });
//               Navigator.pop(context);
//             },
//           ),
//           SizedBox(
//             width: 20,
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildBalanceCard(DocumentSnapshot userData) {
//     return Card(
//       elevation: 2,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text('Available Balance',
//                 style: TextStyle(color: Colors.grey, fontSize: 14)),
//             SizedBox(height: 8),
//             Text(
//               'PKR ${userData.get("balance")}',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1A444F),
//               ),
//             ),
//             SizedBox(height: 8),
//             Divider(height: 1, thickness: 1),
//             SizedBox(height: 8),
//             Text('Minimum Withdrawal: PKR 500',
//                 style: TextStyle(color: Colors.grey, fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPendingWithdrawalCard(DocumentSnapshot withdrawData) {
//     final time = withdrawData.get("time").toDate();
//     final formattedTime = DateFormat('hh:mm a').format(time);
//     final method = withdrawData.get("bankType").toString().toUpperCase();
//     final status = withdrawData.get("status").toString().toUpperCase();

//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('WITHDRAWAL REQUEST',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Color(0xFF1A444F),
//                     )),
//                 Chip(
//                   label: Text(status),
//                   backgroundColor: status == "PENDING"
//                       ? Colors.orange.withOpacity(0.2)
//                       : Colors.green.withOpacity(0.2),
//                   labelStyle: TextStyle(
//                     color: status == "PENDING" ? Colors.orange : Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             _buildDetailRow('Amount', 'PKR ${withdrawData.get("amount")}'),
//             _buildDetailRow('Method', method),
//             _buildDetailRow('Account', withdrawData.get("accountNo")),
//             _buildDetailRow('Title', withdrawData.get("accountTitle")),
//             Divider(height: 32),
//             _buildDetailRow('Date', withdrawData.get("date")),
//             _buildDetailRow('Time', formattedTime),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProcessingTimeInfo() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Color(0xFF1A444F).withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         'Processing Time: ${withdrawTime ?? '24-48 hours'}',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Color(0xFF1A444F),
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 25, 188, 213),
//       appBar: AppBar(
//         title: Text('Withdraw Funds', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color.fromARGB(255, 25, 188, 213),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection("users")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .snapshots(),
//         builder: (context, userSnapshot) {
//           if (!userSnapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           return StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection("paymentRecord")
//                 .where("senderId",
//                     isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//                 .where("paymentType", isEqualTo: "withdraw")
//                 .where("status", isEqualTo: "pending")
//                 .orderBy("time", descending: true)
//                 .snapshots(),
//             builder: (context, withdrawSnapshot) {
//               final hasPendingWithdrawal = withdrawSnapshot.hasData &&
//                   withdrawSnapshot.data!.docs.isNotEmpty;

//               if (hasPendingWithdrawal) {
//                 final pendingWithdraw = withdrawSnapshot.data!.docs.first;
//                 pendingWithdrawId = pendingWithdraw.id;
//               }

//               return SingleChildScrollView(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (!hasPendingWithdrawal) ...[
//                       _buildBalanceCard(userSnapshot.data!),
//                       SizedBox(height: 24),
//                       Text('Withdrawal Amount',
//                           style: theme.textTheme.titleMedium),
//                       SizedBox(height: 8),
//                       TextField(
//                         controller: amountController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           hintText: 'Enter amount',
//                           prefixText: 'PKR ',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       // Replace the TextField with this code:
//                       SizedBox(height: 24),
//                       Text('Payment Method',
//                           style: theme.textTheme.titleMedium),
//                       SizedBox(height: 8),
//                       InkWell(
//                         onTap: _showPaymentMethodBottomSheet,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 16),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 selectedMethodName!,
//                                 style: TextStyle(
//                                   color: _selectedMethod == 0
//                                       ? Colors.grey
//                                       : Colors.black,
//                                 ),
//                               ),
//                               Icon(Icons.arrow_drop_down, color: Colors.grey),
//                             ],
//                           ),
//                         ),
//                       ),
//                       if (showBankNameField) ...[
//                         SizedBox(height: 16),
//                         TextField(
//                           controller: bankNameController,
//                           decoration: InputDecoration(
//                             labelText: 'Bank Name',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ],
//                       SizedBox(height: 16),
//                       TextField(
//                         controller: accountNoController,
//                         decoration: InputDecoration(
//                           labelText: 'Account Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.number,
//                       ),
//                       SizedBox(height: 16),
//                       TextField(
//                         controller: accountTitleController,
//                         decoration: InputDecoration(
//                           labelText: 'Account Title',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 24),
//                       // SizedBox(
//                       //   width: double.infinity,
//                       //   child: ElevatedButton(
//                       //     style: ElevatedButton.styleFrom(
//                       //       padding: EdgeInsets.symmetric(vertical: 16),
//                       //       backgroundColor: Color(0xFF1A444F),
//                       //     ),
//                       //     onPressed: _submitWithdrawal,
//                       //     child: Text('SUBMIT REQUEST',
//                       //         style: TextStyle(color: Colors.white)),
//                       //   ),
//                       // ),
//                       Container(
//                         width: 250,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.all(10),
//                             foregroundColor: Colors.white,
//                             backgroundColor: Color(0xff1a444f),
//                           ),
//                           onPressed: () {
//                             if (amountController.text.isEmpty ||
//                                 accountNoController.text.isEmpty ||
//                                 accountTitleController.text.isEmpty) {
//                               Customdialog().showInSnackBar(
//                                   "Please enter the required fields", context);
//                               return;
//                             } else {
//                               if (status.toString().toLowerCase() ==
//                                   "pending") {
//                                 Customdialog().showInSnackBar(
//                                     "Please activate your BPro account from admin",
//                                     context);
//                                 return;
//                               } else {
//                                 String currentDate = DateFormat('dd-MM-yyyy')
//                                     .format(DateTime.now());
//                                 Customdialog.showDialogBox(context);

//                                 DateTime currentTime = DateTime.now();
//                                 FirebaseFirestore.instance
//                                     .collection("paymentRecord")
//                                     .add({
//                                   "imageLink": "",
//                                   "paymentType": "withdraw",
//                                   "bankType": _radioValue == 1
//                                       ? "easypaisa"
//                                       : _radioValue == 2
//                                           ? "jazzcash"
//                                           : bankNameController.text.trim(),
//                                   "amount": amountController.text.trim(),
//                                   "senderId": firebaseAuth.currentUser!.uid,
//                                   "date": currentDate,
//                                   "accountNo": accountNoController.text.trim(),
//                                   "status": "pending",
//                                   "bproName": bproName.toString(),
//                                   "accountTitle":
//                                       accountTitleController.text.trim(),
//                                   "currentDate": DateTime.now(),
//                                   "time": DateTime.now(),
//                                 }).then((value) async => {
//                                           await firebaseFirestore
//                                               .collection("users")
//                                               .doc(id)
//                                               .update({
//                                             "balance": 0,
//                                           }),
//                                           Navigator.pop(context),
//                                           sendPushMessage(
//                                             title: "Withdraw Request",
//                                             body:
//                                                 "Dear Admin You have new deposit of ${amountController.text} from $username",
//                                           ),
//                                           amountController.clear(),
//                                           accountTitleController.clear(),
//                                           accountNoController.clear(),
//                                         });
//                               }
//                             }
//                           },
//                           child: const Text('Submit',
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   fontFamily: 'Kanit',
//                                   fontWeight: FontWeight.bold,
//                                   letterSpacing: 2)),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       _buildProcessingTimeInfo(),
//                     ] else ...[
//                       _buildPendingWithdrawalCard(
//                           withdrawSnapshot.data!.docs.first),
//                       SizedBox(height: 24),
//                       _buildProcessingTimeInfo(),
//                       SizedBox(height: 16),
//                       Text('Note:',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           )),
//                       SizedBox(height: 8),
//                       Text('• You can cancel this withdrawal request'),
//                       SizedBox(height: 4),
//                       Text('• Funds will be returned to your wallet'),
//                       SizedBox(height: 24),
//                       SizedBox(
//                         width: double.infinity,
//                         child: OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                             side: BorderSide(color: Colors.red),
//                           ),
//                           onPressed: _cancelWithdrawal,
//                           child: Text('CANCEL REQUEST',
//                               style: TextStyle(color: Colors.red)),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// ////////////////////////////////////////////////
// import 'dart:convert';
// import 'dart:developer';
// import 'package:betapp/constant/customdialog.dart';
// import 'package:betapp/utills/colors.dart';
// import 'package:betapp/utills/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

// class Withdraw extends StatefulWidget {
//   @override
//   _WithdrawState createState() => _WithdrawState();
// }

// class _WithdrawState extends State<Withdraw> {
//   int? _selectedMethod = 0;
//   bool showBankNameField = false;

//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController accountNoController = TextEditingController();
//   final TextEditingController accountTitleController = TextEditingController();
//   final TextEditingController bankNameController = TextEditingController();

//   String? withdrawTime;
//   String? userBalance;
//   String? userStatus;
//   String? bproName;
//   String? pendingWithdrawId;
//   String? username;
//   String? userId;

//   @override
//   void initState() {
//     super.initState();
//     _fetchWithdrawTime();
//     _fetchUserData();
//   }

//   void _fetchWithdrawTime() async {
//     final doc = await FirebaseFirestore.instance
//         .collection("socialInfo")
//         .doc("dzwAYcmZTRizAd0fkERh")
//         .get();
//     setState(() {
//       withdrawTime = doc.get("withdrawTime");
//     });
//   }

//   void _fetchUserData() async {
//     final doc = await FirebaseFirestore.instance
//         .collection("users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     setState(() {
//       userBalance = doc.get("balance");
//       userStatus = doc.get("userStatus");
//       bproName = doc.get("betProname");
//       username = doc.get("UserName");
//       userId = doc.id;
//     });
//   }

//   void _handleMethodSelection(int? value) {
//     setState(() {
//       _selectedMethod = value;
//       showBankNameField = value == 3;
//     });
//   }

//   Future<void> _submitWithdrawal() async {
//     if (amountController.text.isEmpty ||
//         accountNoController.text.isEmpty ||
//         accountTitleController.text.isEmpty ||
//         (_selectedMethod == 3 && bankNameController.text.isEmpty)) {
//       Customdialog()
//           .showInSnackBar("Please enter the required fields", context);
//       return;
//     }

//     if (userStatus?.toLowerCase() == "pending") {
//       Customdialog().showInSnackBar(
//           "Please activate your BPro account from admin", context);
//       return;
//     }

//     Customdialog.showDialogBox(context);

//     try {
//       final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

//       await FirebaseFirestore.instance.collection("paymentRecord").add({
//         "imageLink": "",
//         "paymentType": "withdraw",
//         "bankType": _selectedMethod == 1
//             ? "easypaisa"
//             : _selectedMethod == 2
//                 ? "jazzcash"
//                 : bankNameController.text.trim(),
//         "amount": amountController.text.trim(),
//         "senderId": FirebaseAuth.instance.currentUser!.uid,
//         "date": currentDate,
//         "accountNo": accountNoController.text.trim(),
//         "status": "pending",
//         "bproName": bproName,
//         "accountTitle": accountTitleController.text.trim(),
//         "currentDate": DateTime.now(),
//         "time": DateTime.now(),
//       }).then((value) async {
//         await FirebaseFirestore.instance
//             .collection("users")
//             .doc(userId)
//             .update({
//           "balance": 0,
//         });

//         Navigator.pop(context);

//         await sendPushMessage(
//           title: "Withdraw Request",
//           body:
//               "Dear Admin You have new withdraw request of ${amountController.text} from $username",
//         );

//         amountController.clear();
//         accountTitleController.clear();
//         accountNoController.clear();
//         bankNameController.clear();
//         setState(() {
//           _selectedMethod = 0;
//           showBankNameField = false;
//         });
//       });
//     } catch (e) {
//       Navigator.pop(context);
//       Customdialog().showInSnackBar("Error submitting withdrawal: $e", context);
//     }
//   }

//   Future<void> _cancelWithdrawal() async {
//     if (pendingWithdrawId == null) return;

//     Customdialog.showDialogBox(context);

//     try {
//       await FirebaseFirestore.instance
//           .collection("paymentRecord")
//           .doc(pendingWithdrawId)
//           .update({"status": "cancelled"});

//       Navigator.pop(context);
//       Customdialog()
//           .showInSnackBar("Withdrawal cancelled successfully", context);
//     } catch (e) {
//       Navigator.pop(context);
//       Customdialog().showInSnackBar("Error cancelling withdrawal: $e", context);
//     }
//   }

//   String constructFCMPayload({String? title, String? body}) {
//     log("Step 2 complete");
//     return jsonEncode({
//       'to': '/topics/all',
//       'data': {
//         'via': 'FlutterFire Cloud Messaging!!!',
//       },
//       'notification': {
//         'title': title,
//         'body': body,
//       },
//       'android': {
//         'notification': {},
//       }
//     });
//   }

//   Future<void> sendPushMessage({String? title, String? body}) async {
//     try {
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization':
//               "key=AAAAsmsxB4E:APA91bFZyx397fcBhq4zoEF5s-dkMnmerylcn0CfYeVIUs7uRXMEgkF5ezw-PFLS0kpwQoN9hPrx1fikqKKGbK7lBX3A85W8Z9F44jvxgYCLtiRUmegh7D5ainm2bTHdMa7jFGphodoX",
//         },
//         body: constructFCMPayload(body: body, title: title),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Request submitted successfully')));
//       print('FCM request for device sent!');
//     } catch (e) {
//       print("Error sending notification");
//       print(e);
//     }
//   }

//   Widget _buildPaymentMethodTile({
//     required IconData icon,
//     required String title,
//     required int value,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorConstant().appColor,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.black),
//         title: Text(title, style: TextStyle(fontFamily: 'Kanit')),
//         trailing: Radio<int>(
//           value: value,
//           groupValue: _selectedMethod,
//           onChanged: _handleMethodSelection,
//           activeColor: ColorConstant().appColor,
//         ),
//         onTap: () => _handleMethodSelection(value),
//       ),
//     );
//   }

//   Widget _buildPendingWithdrawalCard(DocumentSnapshot withdrawData) {
//     final time = withdrawData.get("time").toDate();
//     final formattedTime = DateFormat('hh:mm a').format(time);
//     final method = withdrawData.get("bankType").toString().toUpperCase();
//     final status = withdrawData.get("status").toString().toUpperCase();

//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: ColorConstant().appColor),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(
//               "${withdrawData.get("paymentType").toString().capitalize}",
//               style: TextStyle(
//                   color: ColorConstant().appColor,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Kanit'),
//             ),
//             trailing: Text(
//               "${withdrawData.get("amount").toString()} Rs",
//               style: TextStyle(fontFamily: 'Kanit'),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("${withdrawData.get("accountTitle")}",
//                     style: TextStyle(fontFamily: 'Kanit')),
//                 Text("${withdrawData.get("accountNo")}",
//                     style: TextStyle(fontFamily: 'Kanit')),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Savings', style: TextStyle(fontFamily: 'Kanit')),
//                     Text(method, style: TextStyle(fontFamily: 'Kanit')),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Divider(),
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   status,
//                   style: TextStyle(
//                     color: status == "PENDING"
//                         ? Colors.red
//                         : ColorConstant().appColor,
//                     fontFamily: 'Kanit',
//                   ),
//                 ),
//                 Text(
//                   "$formattedTime / ${withdrawData.get("date")}",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection("users")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .snapshots(),
//         builder: (context, userSnapshot) {
//           if (!userSnapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           return StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection("paymentRecord")
//                 .where("senderId",
//                     isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//                 .where("paymentType", isEqualTo: "withdraw")
//                 .where("status", isEqualTo: "pending")
//                 .orderBy("time", descending: true)
//                 .snapshots(),
//             builder: (context, withdrawSnapshot) {
//               final hasPendingWithdrawal = withdrawSnapshot.hasData &&
//                   withdrawSnapshot.data!.docs.isNotEmpty;

//               if (hasPendingWithdrawal) {
//                 pendingWithdrawId = withdrawSnapshot.data!.docs.first.id;
//               }

//               return SingleChildScrollView(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 16),
//                     IconButton(
//                       icon: Icon(Icons.arrow_back, color: Colors.black),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     if (!hasPendingWithdrawal) ...[
//                       SizedBox(height: 16),
//                       Text('Transfer History',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontFamily: 'Kanit',
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           )),
//                       SizedBox(height: 16),
//                       TextField(
//                         controller: amountController,
//                         keyboardType: TextInputType.number,
//                         style:
//                             TextStyle(color: Colors.black, fontFamily: 'Kanit'),
//                         decoration: InputDecoration(
//                           labelText: 'Enter Amount',
//                           hintText: '1000',
//                           labelStyle: TextStyle(
//                               color: Colors.black, fontFamily: 'Kanit'),
//                           hintStyle: TextStyle(
//                               color: Colors.grey, fontFamily: 'Kanit'),
//                           suffixText: 'MAX',
//                           suffixStyle:
//                               TextStyle(color: ColorConstant().appColor),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: ColorConstant().appColor),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Text('Account Details',
//                           style: TextStyle(
//                             fontFamily: 'Kanit',
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           )),
//                       SizedBox(height: 8),
//                       Container(
//                         padding: EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: ColorConstant().appColor),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           children: [
//                             Text('Choose Payment Method',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontFamily: 'Kanit',
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                 )),
//                             SizedBox(height: 16),
//                             _buildPaymentMethodTile(
//                               icon: Icons.phone_android,
//                               title: 'EasyPaisa',
//                               value: 1,
//                             ),
//                             SizedBox(height: 8),
//                             _buildPaymentMethodTile(
//                               icon: Icons.phone_iphone,
//                               title: 'JazzCash',
//                               value: 2,
//                             ),
//                             SizedBox(height: 8),
//                             _buildPaymentMethodTile(
//                               icon: Icons.account_balance,
//                               title: 'Bank',
//                               value: 3,
//                             ),
//                             if (showBankNameField) ...[
//                               SizedBox(height: 16),
//                               TextField(
//                                 controller: bankNameController,
//                                 style: TextStyle(
//                                     color: Colors.black, fontFamily: 'Kanit'),
//                                 decoration: InputDecoration(
//                                   labelText: 'Bank Name',
//                                   labelStyle: TextStyle(
//                                       color: Colors.black, fontFamily: 'Kanit'),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: ColorConstant().appColor),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                             SizedBox(height: 16),
//                             TextField(
//                               controller: accountNoController,
//                               style: TextStyle(
//                                   color: Colors.black, fontFamily: 'Kanit'),
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 labelText: 'Account Number',
//                                 labelStyle: TextStyle(
//                                     color: Colors.black, fontFamily: 'Kanit'),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: ColorConstant().appColor),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             TextField(
//                               controller: accountTitleController,
//                               style: TextStyle(
//                                   color: Colors.black, fontFamily: 'Kanit'),
//                               decoration: InputDecoration(
//                                 labelText: 'Account Title',
//                                 labelStyle: TextStyle(
//                                     color: Colors.black, fontFamily: 'Kanit'),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: ColorConstant().appColor),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 24),
//                       Center(
//                         child: Container(
//                           width: 250,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               padding: EdgeInsets.all(16),
//                               backgroundColor: Color(0xff1a444f),
//                             ),
//                             onPressed: _submitWithdrawal,
//                             child: Text(
//                               'Submit',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: 'Kanit',
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 2,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Container(
//                         padding: EdgeInsets.all(16),
//                         color: Color(0xff1a444f).withOpacity(0.4),
//                         child: Text(
//                           "You will receive the payment within ${withdrawTime}.",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 13,
//                             fontFamily: 'Kanit',
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ] else ...[
//                       SizedBox(height: 16),
//                       Container(
//                         height: 259,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: withdrawSnapshot.data?.docs.length,
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 SizedBox(height: 16),
//                                 _buildPendingWithdrawalCard(
//                                     withdrawSnapshot.data!.docs[index]),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Container(
//                         padding: EdgeInsets.all(16),
//                         color: Color(0xff1a444f).withOpacity(0.4),
//                         child: Text(
//                           "YOU WILL RECEIVE PAYMENT WITHIN $withdrawTime.",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 13,
//                             fontFamily: 'Kanit',
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Padding(
//                         padding: EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Note:",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Kanit',
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               "1-You can cancel this withdrawal request",
//                               style: TextStyle(fontFamily: 'Kanit'),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               "2-Your money will be returned to your wallet",
//                               style: TextStyle(fontFamily: 'Kanit'),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 32),
//                       Center(
//                         child: Container(
//                           width: 250,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               padding: EdgeInsets.all(16),
//                               backgroundColor: Colors.red,
//                             ),
//                             onPressed: _cancelWithdrawal,
//                             child: Text(
//                               'Cancel Withdraw',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: 'Kanit',
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 2,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
