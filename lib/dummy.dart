import 'package:betapp/View/onboarding/content_model.dart';
import 'package:betapp/utills/colors.dart';
import 'package:betapp/widgets/mybutton.dart';
import 'package:betapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnbordingScreen extends StatefulWidget {
  @override
  _OnbordingScreenState createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }
  int selected=0;
  void clickfunction(int i){
    if(i==0){

      setState(() {
        selected==1?selected=0:selected=1;
      });
    }

  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffedf2fc),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height*0.865,
              child: PageView.builder(
                controller: _controller,
                itemCount: contents2.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return SingleChildScrollView(
                    child: Column(
                    
                      children: [
                      Container(
                            
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage(contents2[i].image,),fit: BoxFit.cover
                            )
                          ),
                          height: Get.height*0.55,
                          width: Get.width
                      ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.1), // Inner shadow color
                                Colors.transparent, // Fade to transparent
                              ],
                            ),
                          ),
                          child: Column(
                    
                            children: [
                              SizedBox(height: 10),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    contents2.length,
                                        (index) => buildDot(index, context),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                contents2[i].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff395886),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding:  EdgeInsets.only(left: 15,right: 15),
                                child: Text(
                                  contents2[i].discription,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.5,
                    
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              currentIndex == contents2.length - 1? Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            clickfunction(0);
                                          },
                                          child: Container(
                                            height: 21,
                                            width: 21,
                    
                    
                    
                                            decoration: BoxDecoration(
                                                color: selected==0?Colors.white:ColorConstant().appColor,
                                                borderRadius: BorderRadius.circular(4),
                    
                                                border: Border.all(
                    
                                                    color: selected==0?ColorConstant().greyColor2:ColorConstant().appColor,
                    
                                                    width: 1.5)
                    
                                            ),
                                            child: Icon(Icons.check,color: Colors.white,size: 18,),
                                          ),
                                        ),
                                        SizedBox(width: Get.width*0.015,),
                                        MyText(text: "Accetto Termini e condizioni",textcolor: ColorConstant().blackColor,fontSize: Get.width*0.037,),
                    
                                      ],
                                    ),
                    
                    
                    
                                  ],
                                ),
                              ):SizedBox(),
                              currentIndex == contents2.length - 1?
                              Padding(
                                padding:  EdgeInsets.only(left: 15,right: 15,top: 10),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: MyText(text: "Clicca qui per visualizzare termini e...",textcolor: ColorConstant().blackColor,fontSize: Get.width*0.037,)),
                              )
                                :SizedBox(),
                    
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
        
            Padding(
              padding: EdgeInsets.only(bottom: 5,left: 15,right: 15),
              child: MyButton(
                color: Color(0xff395886),
                text: currentIndex == contents2.length - 1? "Entra":"Continua",
                onPressed: () {

                  _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
        
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index?Color(0xff395886):Color(0xff395886).withOpacity(.50),
      ),
    );
  }
}
