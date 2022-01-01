import 'package:flutter/material.dart';


class CardSatisfiedClientClipper extends  CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    Path path = Path();

    path.moveTo(size.width - 30, 0);

    path.lineTo(10, 130);  //40, 130
    path.quadraticBezierTo(1, 150, 0, 160); //X1 , Y1 are controller points , /X2 , Y2 are given points   //10, 135, 0, 150
    path.lineTo(0, size.height);  //0, size.height
    path.lineTo(size.width, size.height);  //size.width, size.height

    path.lineTo(size.width, 30);   //size.width, 30
    path.quadraticBezierTo(size.width - 10, 10, size.width - 35, 10);    //size.width - 10, 10, size.width - 35, 10

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class BestMealsClipper extends  CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    //This how much curve i need
    double radius = 40;

    Path path = Path();

    path.moveTo(radius, 0.0);
    path.arcToPoint(Offset(0.0, radius),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(0.0, size.height - radius);
    path.arcToPoint(Offset(radius, size.height),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(size.width - radius, size.height);
    path.arcToPoint(Offset(size.width, size.height - radius),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(size.width, radius);
    path.arcToPoint(Offset(size.width - radius, 0.0),
        clockwise: true, radius: Radius.circular(radius));


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CardOffersMonthlyClipper extends  CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    Path path = Path();

    path.lineTo(0, size.height);

    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 40;
    while (curXPos < size.width) {
      curXPos += increment;
      curYPos = curYPos == size.height ? size.height - 30 : size.height;
      path.lineTo(curXPos, curYPos);
    }

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}

class CardFastResponseClipper extends  CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    Path path = Path();

    path.moveTo(size.width, 0); //Start clip from right

    path.lineTo(0, 50);
    path.lineTo(0, size.height - 50);
    path.lineTo(size.width, size.height);


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;


}

class CardDeliciousFoodsClipper extends  CustomClipper<Path>{


  @override
  Path getClip(Size size) {

    Path path = Path();

    path.lineTo(size.width, 50);
    path.lineTo(size.width, size.height - 50);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HeaderClipper extends CustomClipper<Path> {


  @override
  Path getClip(Size size) {

    Path path = Path();

    path.lineTo(0, size.height - 150);
    // path.quadraticBezierTo(
    //     size.width / 2, size.height,
    //     size.width, size.height - 100);
    path.lineTo(size.width / 2, size.height);

    path.lineTo(size.width , size.height - 150);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}