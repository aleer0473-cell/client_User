import 'package:betapp/View/BPro_App_Wallet/annocement_screen.dart';
import 'package:betapp/View/BPro_App_Wallet/dashboard.dart';
import 'package:betapp/utills/colors.dart';
import 'package:flutter/material.dart';

class BProWalletMain extends StatefulWidget {
  @override
  _BProWalletMainState createState() => _BProWalletMainState();
}

class _BProWalletMainState extends State<BProWalletMain> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Dashboard(),
    AnnoucementScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          // backgroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 109, 79, 114),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 15,
          unselectedFontSize: 15,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: const IconThemeData(
            size: 30,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 30,
          ),
          selectedLabelStyle: TextStyle(
            color: ColorConstant().appColor,
            fontFamily: 'Kanit',
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Kanit',
          ),
          items: [
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 192, 255, 194),
              icon: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.asset(
                    "assets/images/home.png",
                    color: _currentIndex == 0
                        ? ColorConstant().appColor
                        : Colors.grey,
                    scale: 15,
                  )),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              // backgroundColor: Color.fromARGB(255, 192, 255, 194),
              backgroundColor: Color.fromARGB(255, 72, 10, 83),
              icon: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.asset(
                    "assets/images/annoucement.png",
                    color: _currentIndex == 1
                        ? ColorConstant().appColor
                        : Colors.grey,
                  )),
              label: 'Updates',
            ),
          ],
        ));
  }
}



//Color.fromARGB(255, 192, 255, 194)
//Color.fromARGB(255, 255, 188, 188)
//Color.fromARGB(255, 232, 207, 255)