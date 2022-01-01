import 'package:flutter/material.dart';
import 'package:foody/constant/Common.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/screen/Cart/web/desktop/CartWebDesktop.dart';
import 'package:foody/screen/Cart/web/mobile/CartWebMobile.dart';
import 'package:foody/screen/Cart/web/tablet/CartWebTablet.dart';
import 'package:foody/screen/SecondaryScreens/MapViewScreen.dart';
import 'package:foody/screen/SecondaryScreens/NotFoundScreen.dart';
import 'package:foody/screen/SecondaryScreens/PdfPreviewScreen.dart';
import 'package:foody/screen/chart/web/desktop/ChartWebDesktop.dart';
import 'package:foody/screen/chart/web/mobile/ChartWebMobile.dart';
import 'package:foody/screen/chart/web/tablet/ChartWebTablet.dart';
import 'package:foody/screen/checkout/web/desktop/CheckoutWebDesktop.dart';
import 'package:foody/screen/checkout/web/mobile/CheckoutWebMobile.dart';
import 'package:foody/screen/checkout/web/tablet/CheckoutWebTablet.dart';
import 'package:foody/screen/foodDetails/web/desktop/FoodDetailWebDesktop.dart';
import 'package:foody/screen/foodDetails/web/mobile/FoodDetailWebMobile.dart';
import 'package:foody/screen/foodDetails/web/tablet/FoodDetailWebTablet.dart';
import 'package:foody/screen/foods/web/desktop/FoodWebDesktop.dart';
import 'package:foody/screen/foods/web/mobile/FoodWebMobile.dart';
import 'package:foody/screen/foods/web/tablet/FoodWebTablet.dart';
import 'package:foody/screen/home/android/mobile/HomeAndroidMobile.dart';
import 'package:foody/screen/home/android/tablet/HomeAndroidTablet.dart';
import 'package:foody/screen/home/web/desktop/HomeWebDesktop.dart';
import 'package:foody/screen/home/web/mobile/HomeWebMobile.dart';
import 'package:foody/screen/home/web/tablet/HomeWebTablet.dart';
import 'package:foody/screen/signIn/android/mobile/SignInAndroidMobile.dart';
import 'package:foody/screen/signIn/android/tablet/SignInAndroidTablet.dart';
import 'package:foody/screen/signIn/web/desktop/SignInWebDesktop.dart';
import 'package:foody/screen/signIn/web/mobile/SignInWebMobile.dart';
import 'package:foody/screen/signIn/web/tablet/SignInWebTablet.dart';
import 'package:foody/screen/signUp/android/mobile/SignUpAndroidMobile.dart';
import 'package:foody/screen/signUp/android/tablet/SignUpAndroidTablet.dart';
import 'package:foody/screen/signUp/web/desktop/SignUpWebDesktop.dart';
import 'package:foody/screen/signUp/web/mobile/SignUpWebMobile.dart';
import 'package:foody/screen/signUp/web/tablet/SignUpWebTablet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:velocity_x/velocity_x.dart';

class RouteGenerator {

  static VxNavigator generateWeb(BuildContext context) {

    return VxNavigator(

        notFoundPage: (_, __) =>
            VxRoutePage(
              child: ScreenTypeLayout(
                mobile:  NotFoundScreen(),
                desktop: NotFoundScreen(),
                tablet: NotFoundScreen(),
                watch: Container(), //Until now
              )
            ),

        routes: {

          Routers.homeRoute: (_, __) =>
              pageTransitionRoute(
                  Routers.homeRoute,
                  HomeWebMobile(),
                  HomeWebTablet(),
                  HomeWebDesktop(),
                  Container()),



          Routers.signInRoute: (_, __) =>
              pageTransitionRoute(
                  Routers.signInRoute,
                  SignInWebMobile(),
                  SignInWebTablet(),
                  SignInWebDesktop(),
                  Container()),



          Routers.signUpRoute: (_, __) =>
              pageTransitionRoute(
                  Routers.signUpRoute,
                  SignUpWebMobile(),
                  SignUpWebTablet(),
                  SignUpWebDesktop(),
                  Container()),



          Routers.foodsRoute: (_, __) =>
              pageTransitionRoute(
                  Routers.foodsRoute,
                  FoodWebMobile(),
                  FoodWebTablet(),
                  FoodWebDesktop(),
                  Container()),



          Routers.foodDetailRoute: (uri, params) =>
              pageTransitionRoute(
                  Routers.foodDetailRoute,
                  FoodDetailWebMobile(params),
                  FoodDetailWebTablet(params),
                  FoodDetailWebDesktop(params),
                  Container()),



          Routers.cartRoute: (uri, params) =>
              pageTransitionRoute(
                  Routers.cartRoute,
                  CartWebMobile(),
                  CartWebTablet(),
                  CartWebDesktop(),
                  Container()),



          Routers.checkoutRoute: (uri, params) =>
              pageTransitionRoute(
                  Routers.checkoutRoute,
                  CheckoutWebMobile(params),
                  CheckoutWebTablet(params),
                  CheckoutWebDesktop(params),
                  Container()),



          Routers.pdfRoute: (uri, params) =>
              pageTransitionRoute(
                  Routers.pdfRoute,
                  PdfPreviewScreen(params),
                  PdfPreviewScreen(params),
                  PdfPreviewScreen(params),
                  Container()),



          Routers.mapRoute: (uri, params) =>
              pageTransitionRoute(
                  Routers.mapRoute,
                  MapViewScreen(),
                  MapViewScreen(),
                  MapViewScreen(),
                  Container()),



          Routers.chartRoute: (uri, params) =>
              pageTransitionRoute(
                  Routers.chartRoute,
                  ChartWebMobile(),
                  ChartWebTablet(),
                  ChartWebDesktop(),
                  Container()),




          //Profile   (Future)
          //Favorites  (Future)


        });
  }



  static Route<dynamic> generateMobileRouter(RouteSettings settings){

    switch(settings.name){

      case Routers.homeRoute :{
        return PageTransition(
          settings: settings,
          child: ScreenTypeLayout(
            mobile: HomeAndroidMobile(),
            tablet: HomeAndroidTablet(),
            desktop: Container(),
            watch: Container(),
          ),
          type: PageTransitionType.fade,
        );
      }


      case Routers.signInRoute :{
        return PageTransition(
          settings: settings,
          child: ScreenTypeLayout(
            mobile: SignInAndroidMobile(),
            tablet: SignInAndroidTablet(),
            desktop: Container(),
            watch: Container(),
          ),
          type: PageTransitionType.fade,
        );
      }


      case Routers.signUpRoute :{
        return PageTransition(
          settings: settings,
          child: ScreenTypeLayout(
            mobile: SignUpAndroidMobile(),
            tablet: SignUpAndroidTablet(),
            desktop: Container(),
            watch: Container(),
          ),
          type: PageTransitionType.fade,
        );
      }


      default :{
        return PageTransition(
          child: ScreenTypeLayout(
            mobile: HomeAndroidMobile(),
            tablet: HomeAndroidTablet(),
            desktop: Container(),
            watch: Container(),
          ),
          type: PageTransitionType.fade,
        );
      }
    }
  }



  // static Route? generatePlatforms(RouteSettings settings) {
  //   switch (settings.name) {
  //     // case Routers.splashScreenRoute:
  //     //   {
  //     //     return PageTransition(
  //     //       settings: settings,
  //     //       child: Container(
  //     //         color: Colors.red,
  //     //       ),
  //     //       type: PageTransitionType.fade,
  //     //     );
  //     //   }
  //     case Routers.homeRoute:
  //       {
  //         return PageTransition(
  //           settings: settings,
  //           child: Container(
  //             color: Colors.green,
  //           ),
  //           type: PageTransitionType.fade,
  //         );
  //       }
  //     case Routers.signInRoute:
  //       {
  //         return PageTransition(
  //           settings: settings,
  //           child: Container(
  //             color: Colors.yellowAccent,
  //           ),
  //           type: PageTransitionType.fade,
  //         );
  //       }
  //     case Routers.signUpRoute:
  //       {
  //         return PageTransition(
  //           settings: settings,
  //           child: Container(
  //             color: Colors.black26,
  //           ),
  //           type: PageTransitionType.fade,
  //         );
  //       }
  //     case Routers.foodsRoute:
  //       {
  //         return PageTransition(
  //           settings: settings,
  //           child: Container(
  //             color: Colors.white38,
  //           ),
  //           type: PageTransitionType.fade,
  //         );
  //       }
  //     case Routers.foodDetailRoute:
  //       {
  //         return PageTransition(
  //           settings: settings,
  //           child: Container(
  //             color: Colors.deepPurpleAccent,
  //           ),
  //           type: PageTransitionType.fade,
  //         );
  //       }
  //     case Routers.chartRoute:
  //       {
  //         return PageTransition(
  //           settings: settings,
  //           child: Container(
  //             color: Colors.indigoAccent,
  //           ),
  //           type: PageTransitionType.fade,
  //         );
  //       }
  //     case Routers.checkoutRoute:
  //       {
  //         return PageTransition(
  //           settings: settings,
  //           child: Container(
  //             color: Colors.tealAccent,
  //           ),
  //           type: PageTransitionType.fade,
  //         );
  //       }
  //     case Routers.payRoute:
  //       {
  //         return PageTransition(
  //           settings: settings,
  //           child: Container(
  //             color: Colors.deepPurple,
  //           ),
  //           type: PageTransitionType.fade,
  //         );
  //       }
  //     case Routers.profileRoute:
  //       {
  //         return PageTransition(
  //           settings: settings,
  //           child: Container(
  //             color: Colors.deepOrangeAccent,
  //           ),
  //           type: PageTransitionType.fade,
  //         );
  //       }
  //   }
  // }

  static VxRoutePage pageTransitionRoute(String pageName, Widget mobile , Widget tablet , Widget desktop , Widget watch){
    return VxRoutePage(
        pageName: pageName,
        // transition: (animation, widget) {
        //   const begin = Offset(0.0, 1.0);
        //   const end = Offset.zero;
        //   const curve = Curves.easeOut;
        //
        //   var tween = Tween(begin: begin, end: end)
        //       .chain(CurveTween(curve: curve));
        //
        //   return SlideTransition(
        //     position: animation.drive(tween),
        //     child: widget,
        //   );
        // },
        child: ScreenTypeLayout(
          mobile:  mobile,
          desktop: desktop,
          tablet: tablet,
          watch: watch, //Until now
        ));
  }
}
