import 'package:betapp/utills/colors.dart';
import 'package:betapp/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class AllTransactionScreen extends StatefulWidget {
  const AllTransactionScreen({super.key});

  @override
  State<AllTransactionScreen> createState() => _AllTransactionScreenState();
}

class _AllTransactionScreenState extends State<AllTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Transaction History',
                    style: TextStyle(
                      fontSize: 22,
                      color: ColorConstant().appColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                    )),
              ),

              StreamBuilder(
                stream: firebaseFirestore
                    .collection("paymentRecord")
                    .where("senderId", isEqualTo: firebaseAuth.currentUser!.uid)
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
                      padding:
                      EdgeInsets.only(top: Get.height * 0.04),
                      child: Image.asset(
                        "assets/images/no-data.gif",
                        scale: 2,
                      ),
                    )
                        : Container(
                          height: Get.height * 0.85,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:  filteredDocs.length,
                            padding: EdgeInsets.all(6),
                            itemBuilder: (BuildContext context, int index) {
                              List<DocumentSnapshot> docs = filteredDocs;
          
                              // Sort the documents based on the 'time' field
                              docs.sort((a, b) {
                                Timestamp timeA = a.get("time");
                                Timestamp timeB = b.get("time");
                                DateTime dateTimeA = timeA.toDate();
                                DateTime dateTimeB = timeB.toDate();
                                return dateTimeB.compareTo(dateTimeA);
                              });
          
                              var ds = docs[index];
                              var time = ds.get("time").toDate();
                              String formattedTime = DateFormat('hh:mm a').format(time);
                              var paymentType = ds.get("paymentType");
                              var userAmount = ds.get("amount");
          
                              return Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  children: [

                                    Container(
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
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(width: 5),
                                                Image.asset("assets/images/arrow.png", scale: 15),
                                                SizedBox(width: Get.width * 0.03),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${ds.get("paymentType").toString().capitalize}",
                                                      style: TextStyle(
                                                          color: ColorConstant().appColor,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Kanit',
                                                          fontSize: Get.width * 0.045),
                                                    ),
                                                    Text(
                                                      "To ${ds.get("accountTitle").toString().capitalize}",
                                                      style: TextStyle(
                                                        fontFamily: 'Kanit',
                                                        color: Colors.grey.withOpacity(.70),
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: Get.width * 0.787,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${ds.get("bankType").toString().capitalizeFirst} ${ds.get("accountNo").toString().capitalize}",
                                                            style: TextStyle(
                                                              fontFamily: 'Kanit',
                                                              color: Colors.grey.withOpacity(.70),
                                                            ),
                                                          ),
                                                          Text(
                                                            "Rs. ${ds.get("amount").toString()}",
                                                            style: TextStyle(
                                                              color: ColorConstant().appColor,
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
                                              padding: EdgeInsets.only(left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Payment",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Kanit',
                                                        ),
                                                      ),
                                                      Text(
                                                        " ${ds.get("status").toString().capitalize}",
                                                        style: TextStyle(
                                                          color: ds.get("status") == "approved"
                                                              ? Colors.green
                                                              : Colors.red,
                                                          fontFamily: 'Kanit',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "$formattedTime / ${ds.get("date").toString().capitalize}",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'Kanit',
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                  } else if (snapshot.hasError) {
                    return Center(child: const Icon(Icons.error_outline));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
