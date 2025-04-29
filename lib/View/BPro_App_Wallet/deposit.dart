// import 'package:betapp/View/BPro_App_Wallet/select_account_to_transfaer.dart';
// import 'package:betapp/utills/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Deposit extends StatefulWidget {
//   const Deposit({super.key});

//   @override
//   State<Deposit> createState() => _DepositState();
// }

// class _DepositState extends State<Deposit> {
//   late String amount;
//   final TextEditingController amountController = TextEditingController();

//   @override
//   void dispose() {
//     amountController.dispose();
//     super.dispose();
//   }

//   bool isAmountValid() {
//     final text = amountController.text;
//     if (text.isEmpty) {
//       return false;
//     }
//     final amount = int.tryParse(text);
//     return amount != null && amount >= 500;
//   }
//   void _onKeyTap(String value) {
//     setState(() {
//       if (value == '⌫') {
//         if (amountController.text.isNotEmpty) {
//           amountController.text = amountController.text.substring(0, amountController.text.length - 1);
//         }
//       } else {
//         amountController.text += value;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepOrangeAccent,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_ios_new,
//             color: Colors.white,
//             size: 25,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Theme(
//         data: Theme.of(context).copyWith(
//           textSelectionTheme: TextSelectionThemeData(
//             cursorColor:
//                 ColorConstant().appColor,
//             selectionHandleColor:
//                 ColorConstant().appColor,
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 2.3,
//                       width: 30,
//                       color: Colors.white,
//                     ),
//                     SizedBox(
//                       width: 7,
//                     ),
//                     Container(
//                       height: 2.3,
//                       width: 30,
//                       color: Colors.grey,
//                     ),
//                     SizedBox(
//                       width: 7,
//                     ),
//                     Container(
//                       height: 2.3,
//                       width: 30,
//                       color: Colors.grey,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: Get.height * 0.3,
//                 ),
//                 Text(
//                   'Enter Amount you want to deposit in Batme Wallet',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Kanit'),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: double.infinity,
//                   child: Text('Minimum deposit amount is Rs. 500',
//                       style: TextStyle(
//                           color: Colors.white54,
//                           fontSize: 12,
//                           fontFamily: 'Kanit')),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 TextField(
//                   style:
//                       const TextStyle(color: Colors.white, fontFamily: 'Kanit'),
//                   keyboardType: TextInputType.number,
//                   controller: amountController,
//                   decoration: InputDecoration(
//                     border: const OutlineInputBorder(),
//                     focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.white,
//                       ),
//                     ),
//                     hintText: 'Amount',
//                     labelText: 'Enter Amount',
//                     labelStyle: TextStyle(
//                         color: Colors.white, fontSize: 15, fontFamily: 'Kanit'),
//                     hintStyle: TextStyle(
//                         color: Colors.grey, fontSize: 15, fontFamily: 'Kanit'),
//                   ),
//                   onChanged: (value) {
//                     setState(() {});
//                   },
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 isAmountValid()
//                     ? Container(
//                         width: 210,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.all(12),
//                             foregroundColor: Colors.white,
//                             backgroundColor: Colors.white,
//                           ),
//                           onPressed: isAmountValid()
//                               ? () {
//                                   amount = amountController.text;
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           SelectAccountToTransfer(
//                                         amount: amount,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               : null,
//                           child: const Text('NEXT',
//                               style: TextStyle(
//                                   color: Colors.green,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                   letterSpacing: 4,
//                                   height: 1.5,
//                                   fontFamily: 'Kanit')),
//                         ),
//                       )
//                     : SizedBox(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:betapp/View/BPro_App_Wallet/select_account_to_transfaer.dart';
import 'package:betapp/utills/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Deposit extends StatefulWidget {
  const Deposit({super.key});

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  late String amount;
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  bool isAmountValid() {
    final text = amountController.text;
    if (text.isEmpty) {
      return false;
    }
    final amount = int.tryParse(text);
    return amount != null && amount >= 500;
  }

  void _onKeyTap(String value) {
    setState(() {
      if (value == '⌫') {
        if (amountController.text.isNotEmpty) {
          amountController.text = amountController.text
              .substring(0, amountController.text.length - 1);
        }
      } else {
        amountController.text += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 176, 130),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: ColorConstant().appColor,
              selectionHandleColor: ColorConstant().appColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 2.3, width: 30, color: Colors.white),
                    const SizedBox(width: 7),
                    Container(height: 2.3, width: 30, color: Colors.grey),
                    const SizedBox(width: 7),
                    Container(height: 2.3, width: 30, color: Colors.grey),
                  ],
                ),
                SizedBox(height: Get.height * 0.05),

                // Instructions
                const Text(
                  'Enter Amount you want to deposit in Batme Wallet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Minimum deposit amount is Rs. 500',
                  style: TextStyle(
                      color: Colors.white54, fontSize: 12, fontFamily: 'Kanit'),
                ),
                SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  child: Text(
                    amountController.text.isEmpty
                        ? 'Rs. 0'
                        : 'Rs. ${amountController.text}',
                    style: TextStyle(
                      color: amountController.text.isEmpty
                          ? Colors.white
                          : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                _buildNumberPad(),
                // isAmountValid()
                //     ? SizedBox(
                //         width: 210,
                //         child: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //             padding: const EdgeInsets.all(12),
                //             foregroundColor: Colors.white,
                //             backgroundColor: Colors.white,
                //           ),
                //           onPressed: () {
                //             amount = amountController.text;
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => SelectAccountToTransfer(
                //                   amount: amount,
                //                 ),
                //               ),
                //             );
                //           },
                //           child: const Text(
                //             'NEXT',
                //             style: TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 15,
                //                 fontWeight: FontWeight.bold,
                //                 letterSpacing: 4,
                //                 height: 1.5,
                //                 fontFamily: 'Kanit'),
                //           ),
                //         ),
                //       )
                //     : const SizedBox(),
                isAmountValid()
                    ? Container(
                        width: 210,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            foregroundColor:
                                Colors.grey.withValues(alpha: 0.10),
                            backgroundColor:
                                Colors.grey.withValues(alpha: 0.10),
                          ),
                          onPressed: isAmountValid()
                              ? () {
                                  amount = amountController.text;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SelectAccountToTransfer(
                                        amount: amount,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          child: const Text('NEXT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                  height: 1.5,
                                  fontFamily: 'Kanit')),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberPad() {
    final List<String> keys = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '0',
      '⌫'
    ];

    return SizedBox(
      height: 300,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: keys.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 0,
          crossAxisSpacing: 65,
        ),
        itemBuilder: (context, index) {
          final key = keys[index];
          return GestureDetector(
            onTap: key.isNotEmpty ? () => _onKeyTap(key) : null,
            child: Center(
              child: Text(
                key,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
