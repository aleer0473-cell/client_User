import 'dart:io';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TransactionUpdateScreen extends StatefulWidget {
  String amount;
  String id;

  TransactionUpdateScreen({Key? key, required this.id, required this.amount})
      : super(key: key);

  @override
  State<TransactionUpdateScreen> createState() =>
      _TransactionUpdateScreenState();
}

class _TransactionUpdateScreenState extends State<TransactionUpdateScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  File? imageUrl;
  String? imageLink;

  final ImagePicker _picker = ImagePicker();
  void addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    amountController = widget.amount != null && widget.amount.isNotEmpty
        ? TextEditingController(text: widget.amount)
        : TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstant().appColor.withOpacity(0.8),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: Text(
          "Transaction Update",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: appSize.height * 0.06),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstant().appColor.withOpacity(0.8),
                        width: 1.5),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant().appColor.withOpacity(0.8),
                          width: 1.5),
                      borderRadius: BorderRadius.circular(15.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant().appColor.withOpacity(0.8),
                          width: 1.5),
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
              SizedBox(height: appSize.height * 0.06),
              InkWell(
                onTap: () async {
                  await firebaseFirestore
                      .collection("paymentRecord")
                      .doc(widget.id)
                      .update({
                    "amount": amountController.text,
                  }).then((value) => {
                            Navigator.pop(context),
                          });
                },
                child: Container(
                  margin: EdgeInsets.only(top: appSize.height * 0.04),
                  height: appSize.height * 0.07,
                  width: appSize.width * 0.92,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorConstant().appColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: appSize.width * 0.045),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
