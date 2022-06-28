import 'package:algorizainternship/Componets/ElevatedButton.dart';
import 'package:algorizainternship/Style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoardingModel{
  final String image;
  final String title;
  final String body;
  OnBoardingModel( {
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {

  const OnBoardingScreen({Key? key,}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _OnBoardingScreen();
  }
}

class _OnBoardingScreen extends State<OnBoardingScreen>{
  var boardController=PageController();
List<OnBoardingModel> boardList=[
  OnBoardingModel(
      image: 'assets/image/delivery 2.png',
      title: 'Get Food delivery to Your doorstep asap',
      body: 'we have young and professional delivery team that will bring your food as soon as possible to your doorstep '),
  OnBoardingModel(
      image: 'assets/image/delivery 4.png',
      title: 'Buy Any Food from your favourite restaurant',
      body: 'we are constantly adding your favourite restaurant throughout the territory and around your area carefully selected'),
  OnBoardingModel(
      image: 'assets/image/delivery 3.png',
      title: 'You Will Received Your Order in Short Time ',
      body: 'we are hiring a fast and experienced delivery guys so no more hungry'),
];
  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: mediaQuery.height/16,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: MyElevatedButton(
              mediaQuery.height/20,mediaQuery.width/5,(){},'Skip',Color(0xfffaf2e7),14,20,Colors.black
            )
          )
        ],
      ),
      extendBodyBehindAppBar: false,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0,right: 20,left: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('7',style: TextStyle(
                    color: Color(0xffe4ba76),fontSize: 32,fontWeight: FontWeight.bold
                ),),
                Text('Krave',style: TextStyle(
                    color: mainColor,fontSize: 32,fontWeight: FontWeight.bold
                ),),
              ],
            ),
            Expanded(child: PageView.builder(
              itemCount: boardList.length,
                controller:boardController ,
                onPageChanged: (int index){
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildOnBoardingItem(boardList[index])),),
            SmoothPageIndicator(
                controller: boardController,
                effect:  const ExpandingDotsEffect(
                  activeDotColor: Color(0xffe4ba76),
                   dotWidth: 20,
                  radius: 10,
                  dotHeight: 10
                ),
                count: boardList.length),
            Padding(
              padding: const EdgeInsets.only(top: 30.0,bottom: 10),
              child: MyElevatedButton(mediaQuery.height/15, double.infinity, () { }, 'Get Started',mainColor, 18,10,Colors.white),
            ) ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont Have an account?',style: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                ),),
                TextButton(onPressed: (){}, child: Text(
                  'Sign Up',style: TextStyle(
                  color: mainColor,fontSize: 16,fontWeight: FontWeight.bold
                ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildOnBoardingItem(OnBoardingModel model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  // mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Image(
      image: AssetImage(model.image),),
    Text(model.title,
        style: const TextStyle(
          fontSize: 28,fontWeight: FontWeight.bold,
        ),textAlign: TextAlign.center),
    const SizedBox(
      height: 10,
    ),
    Text(model.body,
        style: const TextStyle(
            fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey
        ),textAlign: TextAlign.center),
  ],
);