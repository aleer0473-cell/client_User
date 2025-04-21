import 'package:betapp/utills/colors.dart';
import 'package:flutter/material.dart';


class UpdateWithDraw extends StatefulWidget {
  const UpdateWithDraw({super.key});

  @override
  State<UpdateWithDraw> createState() => _UpdateWithDrawState();
}

class _UpdateWithDrawState extends State<UpdateWithDraw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: ColorConstant().appColor,
        title: const Text(
          'Update Withdraw',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            buildDetailRow('ID: ', '1234567890'),
            buildDetailRow('User ID: ', '12131415'),
            buildDetailRow('Account Title: ', 'Dummy Account Title'),
            buildDetailRow('Account Number: ', '1234567890'),
            buildDetailRow('Amount: ', '52000'),
            buildDetailRow('Account Type: ', 'Savings'),
            buildDetailRow('Status: ', 'Pending'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: ColorConstant().appColor,
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Kanit',
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}