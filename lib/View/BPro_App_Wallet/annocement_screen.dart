import 'package:betapp/utills/colors.dart';
import 'package:betapp/utills/constants.dart';
import 'package:betapp/widgets/mybutton.dart';
import 'package:betapp/widgets/mytext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnoucementScreen extends StatefulWidget {
  @override
  State<AnnoucementScreen> createState() => _AnnoucementScreenState();
}

class _AnnoucementScreenState extends State<AnnoucementScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            top: screenHeight * 0.08
          ),
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: firebaseFirestore.collection("socialInfo").snapshots(),

              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var ds=snapshot.data?.docs.last;
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(.80),
                            child: Icon(Icons.person,color: Colors.white,size: 29,),
                            radius: 19,
                          ),
                          SizedBox(width: 15,),
                          FutureBuilder(
                              future: firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).get(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  var ds= snapshot.data!;
                                  return     MyText(text: ds.get("UserName"),
                                    fontWeight: FontWeight.w600,
                                    fontSize: Get.width*0.04,
                                    textcolor: Colors.black,

                                  );
                                } else if (snapshot.hasError) {
                                  return Center(child: const Icon(Icons.error_outline));
                                } else {
                                  return Center(child: CircularProgressIndicator());
                                }
                              }),

                        ],
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(.80),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      // Announcements Section
                      _buildInfoRow(
                        icon: Icons.speaker,
                        title: "Annoucement",
                        subtitle: ds?.get("annoucement"),
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      // Deposit Time Section
                      _buildInfoRow(
                        icon: Icons.access_time,
                        title: "Deposit Time",
                        subtitle: ds?.get("depositTime"),
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      // Withdraw Time Section
                      _buildInfoRow(
                        icon: Icons.access_time,
                        title: "Withdraw Time",
                        subtitle: ds?.get("withdrawTime"),
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      // Download App Section
                      InkWell(
                        onTap: (){
                          Share.share(
                              "${ds?.get("shareText")}",

                              subject: 'Batproexch App Admin Note');
                        },
                        child: _buildInfoRow(
                          icon: Icons.share,
                          title: "Share",
                          subtitle: ds?.get("shareText"),
                          screenWidth: screenWidth,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      // WhatsApp No Section
                      GestureDetector(
                        onTap: () async{


                            await launch('http://Wa.me/${ds?.get("whatsAppNumber")}');

                        },
                        child: _buildInfoRow(
                          icon: Icons.phone,
                          title: "WhatsApp No",
                          subtitle: ds?.get("whatsAppNumber"),
                          screenWidth: screenWidth,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      _buildInfoRow(
                        icon: Icons.download,
                        title: "Download App from",
                        subtitle: ds?.get("appLink"),
                        screenWidth: screenWidth,
                      ),
                      // WhatsApp No Section

                      SizedBox(height: screenHeight * 0.05),
                      // Update App Now Button
                      MyButton(onPressed: (){

                      },
                        text: "Update App Now",
                        color: ColorConstant().appColor,

                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Icon(Icons.error_outline));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  // Reusable widget for info rows
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required double screenWidth,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: ColorConstant().appColor, size: screenWidth * 0.07),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.black54,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
        Divider(color: Colors.grey.withOpacity(.80),)
      ],
    );
  }
}