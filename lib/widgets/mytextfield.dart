
import 'package:betapp/utills/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class MyTextField extends StatefulWidget {
  String? hintText;
  bool? eye;
  int? maxLines;
  bool show;
  Icon? icon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  MyTextField(
      {Key? key,
        required this.show,
        this.maxLines,
        this.hintText,
        this.eye,
        this.controller,
        this.validator,
        required TextInputType keyboardType,
        this.icon})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;

    return SizedBox(
      height: Get.height*0.07,
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.show,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintStyle:  TextStyle(color: Colors.black.withOpacity(.58),fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color:ColorConstant().greyColor2.withOpacity(.40), width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConstant().greyColor2.withOpacity(.40), width: 1.5),
                borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstant().appColor.withOpacity(.40), width: 1.5),
                borderRadius: BorderRadius.circular(10.0)),
            hintText: widget.hintText ?? "",
            prefixIcon: widget.icon,
            suffixIcon: widget.eye == null
                ? null
                : IconButton(
                onPressed: () {
                  setState(() {
                    widget.show = !widget.show;
                  });
                },
                icon: widget.show
                    ? Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    "assets/images/hide.svg",
                    height: 15,
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    "assets/images/show.svg",
                    height: 15,
                  ),
                ))),
      ),
    );
  }
}
