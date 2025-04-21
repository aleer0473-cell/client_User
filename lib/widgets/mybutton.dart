// import 'package:flutter/material.dart';
// import 'mytext.dart';

// class MyButton extends StatelessWidget {
//   String? text;
//   VoidCallback onPressed;
//   Color? color;
//   MyButton({Key? key, this.text, required this.onPressed, this.color})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var Size = MediaQuery.of(context).size;
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         height: Size.height * 0.067,
//         padding: EdgeInsets.all(10),
//         alignment: Alignment.center,
//         decoration:
//             BoxDecoration(color: color, borderRadius: BorderRadius.circular(7)),
//         child: MyText(
//           text: text ?? "",
//           fontSize: Size.height * 0.022,
//           textcolor: Colors.white,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'mytext.dart';

class MyButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color? color; // optional: you can remove this if using only gradient

  const MyButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onPressed,
      child: Container(
        height: size.height * 0.067,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: const LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: MyText(
          text: text ?? "",
          fontSize: size.height * 0.022,
          textcolor: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
