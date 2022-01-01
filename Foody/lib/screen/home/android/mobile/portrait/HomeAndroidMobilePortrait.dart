import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blobs/blobs.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/processor/HomeProcessor.dart';
import 'package:foody/widget/Clippers/home_clipper.dart';
import 'package:foody/widget/CrossAnimationButton.dart';
import 'package:gooey_carousel/gooey_carrousel.dart';
import 'package:kenburns/kenburns.dart';
import 'package:octo_image/octo_image.dart';

class HomeAndroidMobilePortrait extends StatelessWidget {


  late HomeProcessor processor;


  HomeAndroidMobilePortrait(){
    processor = HomeProcessor();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GooeyCarousel(
            onIndexUpdate: (int index){
              print('navigate to $index');
            },
            children: [

              //////////////////////// * Presentation * ////////////////////////
              PresentationMobile(),

              //////////////////////// * Delicious * ////////////////////////
              DeliciousMobile(),

              //////////////////////// * Fast * ////////////////////////
              FastMobile(),

              //////////////////////// * Offers * ////////////////////////
              OfferMobile(processor)

            ],
          ),
        ),
      ),
    );
  }


}



class OfferMobile extends StatelessWidget{

  HomeProcessor processor;


  OfferMobile(this.processor);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //////////////////////// * Image * ////////////////////////
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                      child: Center(
                        child: SvgPicture.asset(
                          'images/homeMobile/offers.svg',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width - 100,
                          height: MediaQuery.of(context).size.width - 100,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),


                    //////////////////////// * title * ////////////////////////
                    Center(
                      child: Container(
                        height: 50,
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Theme.of(context).textTheme.headline5!.color as Color,
                                  offset: Offset(0, 0),
                                ),
                              ]),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              FlickerAnimatedText(AppLocalizations.of(context)!.translate('home_card_offers_monthly_title')),
                            ],
                            onTap: () {
                              print("tap delicious foods title");
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),


                    //////////////////////// * Subtitle * ////////////////////////
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        AppLocalizations.of(context)!.translate('home_card_offers_monthly_subtitle'),
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyText2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10,),




                  ],
                ),
              ),

              /////Sign in Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: CrossAnimationButton(50 , 180, 1.2, Curves.easeInOut, 400, Theme.of(context).textTheme.headline3!.color, Theme.of(context).textTheme.headline3!.color, Theme.of(context).cardColor, Theme.of(context).textTheme.headline3!.color , Theme.of(context).textTheme.headline3!.color, Theme.of(context).cardColor, AppLocalizations.of(context)!.translate('home_let_start') ,
                          () {
                        //Navigate to sign in
                        processor.navigateToSignIn(context);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


class FastMobile extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //////////////////////// * Image * ////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  child: Center(
                    child: SvgPicture.asset(
                      'images/homeMobile/speed.svg',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width - 100,
                      height: MediaQuery.of(context).size.width - 100,
                    ),
                  ),
                ),
                SizedBox(height: 20,),


                //////////////////////// * title * ////////////////////////
                Center(
                  child: Container(
                    height: 50,
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Theme.of(context).textTheme.headline5!.color as Color,
                              offset: Offset(0, 0),
                            ),
                          ]),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          FlickerAnimatedText(AppLocalizations.of(context)!.translate('home_card_fast_response_title')),
                        ],
                        onTap: () {
                          print("tap delicious foods title");
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),


                //////////////////////// * Subtitle * ////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AppLocalizations.of(context)!.translate('home_card_fast_response_subtitle'),
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10,),




              ],
            ),
          ),
        ),
      ),
    );
  }

}


class DeliciousMobile extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //////////////////////// * Image * ////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  child: Center(
                    child: SvgPicture.asset(
                      'images/homeMobile/delicious.svg',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width - 100,
                      height: MediaQuery.of(context).size.width - 100,
                    ),
                  ),
                ),
                SizedBox(height: 20,),


                //////////////////////// * title * ////////////////////////
                Center(
                  child: Container(
                    height: 50,
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Theme.of(context).textTheme.headline5!.color as Color,
                              offset: Offset(0, 0),
                            ),
                          ]),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          FlickerAnimatedText(AppLocalizations.of(context)!.translate('home_card_delicious_foods_title')),
                        ],
                        onTap: () {
                          print("tap delicious foods title");
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),


                //////////////////////// * Subtitle * ////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AppLocalizations.of(context)!.translate('home_card_delicious_foods_subtitle'),
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10,),




              ],
            ),
          ),
        ),
      ),
    );
  }

}


class PresentationMobile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //////////////////////// * Image & Title * ////////////////////////
                    ClipPath(
                      clipper: HeaderClipper(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 350,  //450
                        child: Stack(
                          children: [

                            //////////////////////// * kenburns * ////////////////////////
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 350,  //450
                              child: KenBurns.multiple(
                                maxScale: 1,
                                maxAnimationDuration: Duration(milliseconds: 20000),
                                minAnimationDuration: Duration(milliseconds: 1000),
                                childrenFadeDuration: Duration(milliseconds: 2000),
                                childLoop: 4,  //Four images
                                children: [
                                  kenburnImage(context , 'https://drive.google.com/uc?id=1bzP99kxbI-UnrtzO6pgULMH9AyIczMJK' , 'L9HT{j~B00%LMxtl?afzF|?ZOYJA'),
                                  kenburnImage(context , 'https://drive.google.com/uc?id=1cMB8zdkPc3ZgOwAy_M39CgMew6kbORLt' , 'L9G@-]010n\$KL}IuPV?H1N~W4TEQ'),
                                  kenburnImage(context , 'https://drive.google.com/uc?id=1INfNy3FI6XBhxlDoLBWUpuDrASzgLVqC' , 'LUGI4R%MI:%2~VMxRiWBbwM{aeWX'),
                                  kenburnImage(context , 'https://drive.google.com/uc?id=1qaG_pr51hO2PbYNkZ3jcN9F0x6YJELVD' , 'L7I4^Z4:wa.78w_1.T~BvzM{~WwH'),
                                ],
                              ),
                            ),


                            //////////////////////// * Glow Text Title * ////////////////////////
                            Center(
                                child: Container(
                                    width: 250,
                                    height: 250,
                                    child: Stack(
                                      children: [

                                        //Blob Red
                                        Center(
                                          child: Blob.animatedRandom(
                                            size: 220,
                                            edgesCount: 7,
                                            minGrowth: 4,
                                            duration: Duration(milliseconds: 800),
                                            styles: BlobStyles(fillType: BlobFillType.stroke , color: Colors.red , strokeWidth: 2),
                                            loop:  true,
                                          ),
                                        ),


                                        //Blob Yellow
                                        Center(
                                          child: Blob.animatedRandom(
                                            size: 220,
                                            edgesCount: 7,
                                            minGrowth: 4,
                                            duration: Duration(milliseconds: 800),
                                            styles: BlobStyles(fillType: BlobFillType.stroke , color: Colors.yellow , strokeWidth: 2),
                                            loop:  true,
                                          ),
                                        ),


                                        //Bloc fill black
                                        Center(
                                          child: Blob.animatedRandom(
                                            size: 220,
                                            edgesCount: 7,
                                            minGrowth: 4,
                                            duration: Duration(milliseconds: 800),
                                            styles: BlobStyles(fillType: BlobFillType.fill , color: Colors.black.withOpacity(0.6)),
                                            loop:  true,
                                          ),
                                        ),

                                        //Foody Title
                                        Center(
                                          child: BorderedText(
                                            strokeWidth: 5,
                                            strokeColor: Colors.white,
                                            child: Text(
                                              AppLocalizations.of(context)!.translate('home_title_header'),
                                              style: Theme.of(context).textTheme.headline3!.copyWith(
                                                  color: Theme.of(context).primaryColor,
                                                  shadows: [
                                                    Shadow(
                                                        color: Theme.of(context).primaryColor,
                                                        offset: Offset(0,0),
                                                        blurRadius: 6
                                                    )
                                                  ]
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                )
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),


                    //////////////////////// * SubTitle * ////////////////////////
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Container(
                          width: (MediaQuery.of(context).size.width) - 100,
                          height: 120,
                          child: Center(
                              child: DefaultTextStyle(
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10,
                                        color: Theme.of(context).textTheme.headline4!.color as Color,  ///////////////
                                        offset: Offset(0, 0),
                                      ),
                                    ]),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    RotateAnimatedText(AppLocalizations.of(context)!.translate('home_subtitle1_header'),textAlign: TextAlign.center),
                                    RotateAnimatedText(AppLocalizations.of(context)!.translate('home_subtitle2_header'),textAlign: TextAlign.center),
                                    RotateAnimatedText(AppLocalizations.of(context)!.translate('home_subtitle3_header'),textAlign: TextAlign.center),
                                    RotateAnimatedText(AppLocalizations.of(context)!.translate('home_subtitle4_header'),textAlign: TextAlign.center),
                                    RotateAnimatedText(AppLocalizations.of(context)!.translate('home_subtitle5_header'),textAlign: TextAlign.center),
                                    RotateAnimatedText(AppLocalizations.of(context)!.translate('home_subtitle6_header'),textAlign: TextAlign.center),
                                  ],
                                  onTap: () {
                                    print("Tap Event");
                                  },
                                ),
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),


                    //////////////////////// * Image Subtitle * ////////////////////////
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Image.asset(
                            "images/foody_logo.png" ,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover ,
                            filterQuality: FilterQuality.high,
                          )
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),




                  ],
                ),
              ),

              //////////////////////// * Swipe Text * ////////////////////////
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  child: Container(
                    width: (MediaQuery.of(context).size.width) - 100,
                    height: 50,
                    child: Center(
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Theme.of(context).dividerColor,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Theme.of(context).textTheme.headline4!.color as Color,  ///////////////
                                  offset: Offset(0, 0),
                                ),
                              ]),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              FlickerAnimatedText(AppLocalizations.of(context)!.translate('home_text_swipe'),textAlign: TextAlign.center),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        )
                    ),
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


Widget kenburnImage(BuildContext context , String linkImage , String linkBlurhash) {

  return OctoImage(
    width: MediaQuery.of(context).size.width,
    height: 450,
    image: CachedNetworkImageProvider(
        linkImage),
    placeholderBuilder: OctoPlaceholder.blurHash(
      linkBlurhash,
    ),
    errorBuilder: OctoError.icon(color: Colors.red),
    fit: BoxFit.cover,
    filterQuality: FilterQuality.high,
    fadeInCurve: Curves.easeIn,
    fadeOutCurve: Curves.easeOut,
    fadeInDuration: Duration(milliseconds: 300),
    fadeOutDuration: Duration(milliseconds: 300),
    placeholderFadeInDuration: Duration(milliseconds: 300),
  );

}


