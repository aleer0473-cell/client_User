import 'package:betapp/View/Webview/webview.dart';
import 'package:betapp/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BPro extends StatefulWidget {
  var username;
  var password;
  BPro({Key? key,required this.username,required this.password});
  @override
  State<BPro> createState() => _BProState();
}

class _BProState extends State<BPro> {

  @override
  Widget build(BuildContext context) {

    return
      StreamBuilder(
          stream: firebaseFirestore
              .collection("socialInfo").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var ds= snapshot.data!.docs.first;
              return       StoreWebView(
                url:ds.get("webviewUrl"),
                done: true, username: widget.username, password: widget.password,
              );
            }
            else if (snapshot.hasError) {
              return Center(child: const Icon(Icons.error_outline));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
      
      
      

  }
}
