import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody/bloc/blocUnit/AnimatedButtonBloc.dart';
import 'package:foody/bloc/state/AnimatedButtonState.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/model/modelFake/HomeBestMealsModel.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/viewModel/HomeViewModel.dart';
import 'package:foody/widget/Clippers/home_clipper.dart';
import 'package:foody/widget/CrossAnimationButton.dart';
import 'package:blobs/blobs.dart';
import 'package:hive/hive.dart';
import 'package:kenburns/kenburns.dart';
import 'package:octo_image/octo_image.dart';
import 'package:url_launcher/link.dart';
import 'package:velocity_x/velocity_x.dart';


class HomeWebDesktop extends StatelessWidget {

  //ViewModel
  late HomeViewModel viewModel;

  //Init controllers
  late ScrollController scrollController;
  late CarouselController carouselController;

  //Vars
  var darkMode;
  late CarouselOptions carouselOptions;
  late GlobalKey<ScaffoldState> _scaffoldState;

  //Carousel Data
  List<HomeBestMealsModel> bestMeals = [];


  HomeWebDesktop(){

    scrollController = ScrollController();
    carouselController = CarouselController();

    carouselOptions = CarouselOptions(
      height: 350,
      // aspectRatio: 16/9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 2),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      onPageChanged: _onPageChangedCarouselSlider,
      scrollDirection: Axis.horizontal,
    );

    viewModel = HomeViewModel();

    bestMeals = viewModel.bestMealsData();


  }

  @override
  Widget build(BuildContext context) {

    //Scaffold Key
    _scaffoldState = GlobalKey<ScaffoldState>();


    var box = Hive.box('foody');
    darkMode = box.get('darkMode', defaultValue: false);
    var arabicMode = box.get('arabicMode', defaultValue: false);



    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [

                //////////////////////// * Display kenburns image * ////////////////////////
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    child: Stack(
                      children: [

                        //////////////////////// * kenburns * ////////////////////////
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          child: KenBurns.multiple(
                            maxScale: 1,
                            maxAnimationDuration: Duration(milliseconds: 20000),
                            minAnimationDuration: Duration(milliseconds: 1000),
                            childrenFadeDuration: Duration(milliseconds: 2000),
                            childLoop: 4,  //Four images
                            children: [
                              kenburnImage(context , '...............................' , 'L9HT{j~B00%LMxtl?afzF|?ZOYJA'),
                              kenburnImage(context , '...............................' , 'L9G@-]010n\$KL}IuPV?H1N~W4TEQ'),
                              kenburnImage(context , '...............................' , 'LUGI4R%MI:%2~VMxRiWBbwM{aeWX'),
                              kenburnImage(context , '...............................' , 'L7I4^Z4:wa.78w_1.T~BvzM{~WwH'),
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
                        ),  //Add New Font////////////////////////////////////////////////////////////


                        //////////////////////// * Sign in button * ////////////////////////
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Link(
                              uri: Uri.parse(Routers.signInRoute),
                              target: LinkTarget.self,
                              builder: (context,followLink){
                                return CrossAnimationButton(50 , 160, 1.2, Curves.easeInOut, 400, Theme.of(context).textTheme.headline3!.color, Theme.of(context).textTheme.headline3!.color, Theme.of(context).cardColor, Theme.of(context).textTheme.headline3!.color , Theme.of(context).textTheme.headline3!.color, Theme.of(context).cardColor, AppLocalizations.of(context)!.translate('signIn_title') ,
                                        () {
                                      //Navigate to sign in
                                      VxNavigator.of(context).push(
                                          Uri(path: Routers.signInRoute));
                                    });
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),



                //////////////////////// * SubTitle * ////////////////////////
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 20),
                    child: Container(
                      width: (MediaQuery.of(context).size.width/2) + 200,
                      height: 100,
                      child: Center(
                          child: DefaultTextStyle(
                            style: Theme.of(context).textTheme.headline5!.copyWith(
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    color: Theme.of(context).textTheme.headline4!.color as Color,  ///////////////
                                    offset: Offset(0, 0),
                                  ),
                                ]),
                            textAlign: TextAlign.center,
                            maxLines: 5,
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
                          horizontal: 16, vertical: 0),
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
                  height: 40,
                ),



                //////////////////////// * Card delicious foods * ////////////////////////
                ClipPath(
                  clipper: CardDeliciousFoodsClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    child: Stack(
                      children: [

                        //Image Layer
                        OctoImage(
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          // alignment: ,///////////////////////////////////////////////////may use it
                          image: CachedNetworkImageProvider(
                              '..............................................'),
                          placeholderBuilder: OctoPlaceholder.blurHash(
                            'LBCsN#?G9Z%1*J%#RPbHM~s:%MSh',
                          ),
                          errorBuilder: OctoError.icon(color: Colors.red),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          fadeInCurve: Curves.easeIn,
                          fadeOutCurve: Curves.easeOut,
                          fadeInDuration: Duration(milliseconds: 300),
                          fadeOutDuration: Duration(milliseconds: 300),
                          placeholderFadeInDuration: Duration(milliseconds: 300),
                        ),

                        //Shadow Layer
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: FractionalOffset.centerLeft,
                                  end:  FractionalOffset.centerRight,
                                  colors: [
                                    Theme.of(context).cardColor,
                                    Colors.transparent
                                  ],
                                  // stops: [
                                  //   0.0,
                                  //   0.25
                                  // ]

                                )
                            ),
                          ),
                        ),

                        //Texts Layer
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 4) + 30,
                            height: 450,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  //Title Text
                                  Center(
                                    child: Container(
                                      height: 50,
                                      child: DefaultTextStyle(
                                        style: Theme.of(context).textTheme.headline5!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 10,
                                                color: Theme.of(context).textTheme.headline5!.color as Color,  ///////////////
                                                offset: Offset(0, 0),
                                              ),
                                            ]),
                                        maxLines: 1,
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

                                  //Title Subtitle
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: TextSelectionTheme(
                                      data: TextSelectionThemeData(
                                        cursorColor: Theme.of(context).primaryColor,
                                        selectionColor: Colors.red.withOpacity(0.5),
                                        selectionHandleColor: Colors.red.withOpacity(0.5),
                                      ),
                                      child: SelectableText(
                                        AppLocalizations.of(context)!.translate('home_card_delicious_foods_subtitle'),
                                        // softWrap: true,
                                        style: Theme.of(context).textTheme.bodyText1,
                                        // overflow: TextOverflow.ellipsis,
                                        maxLines: 8,
                                        cursorWidth: 3,
                                        cursorRadius: Radius.circular(20),
                                        enableInteractiveSelection: true,
                                        toolbarOptions: ToolbarOptions(
                                            copy: true,
                                            selectAll: true
                                        ),
                                        onSelectionChanged: (selection , cause){

                                        },
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),




                //////////////////////// * Card fast response * ////////////////////////
                ClipPath(
                  clipper: CardFastResponseClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    child: Stack(
                      children: [

                        //Image Layer
                        OctoImage(
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          // alignment: ,///////////////////////////////////////////////////may use it
                          image: CachedNetworkImageProvider(
                              '.............................................................'),
                          placeholderBuilder: OctoPlaceholder.blurHash(
                            'L7E39#M{IpI9k6%2009Et:xWIWRi',
                          ),
                          errorBuilder: OctoError.icon(color: Colors.red),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          fadeInCurve: Curves.easeIn,
                          fadeOutCurve: Curves.easeOut,
                          fadeInDuration: Duration(milliseconds: 300),
                          fadeOutDuration: Duration(milliseconds: 300),
                          placeholderFadeInDuration: Duration(milliseconds: 300),
                        ),

                        //Shadow Layer
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: FractionalOffset.centerRight,
                                  end:  FractionalOffset.centerLeft,
                                  colors: [
                                    Theme.of(context).cardColor,
                                    Colors.transparent
                                  ],
                                  // stops: [
                                  //   0.0,
                                  //   0.25
                                  // ]

                                )
                            ),
                          ),
                        ),

                        //Texts Layer
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: (MediaQuery.of(context).size.width/4) + 20,
                            height: 450,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                //Title Text
                                Center(
                                  child: Container(
                                    height: 50,
                                    child: DefaultTextStyle(
                                      style: Theme.of(context).textTheme.headline5!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 10,
                                              color: Theme.of(context).textTheme.headline5!.color as Color,  ///////////////
                                              offset: Offset(0, 0),
                                            ),
                                          ]),
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      child: AnimatedTextKit(
                                        repeatForever: true,
                                        animatedTexts: [
                                          FlickerAnimatedText(AppLocalizations.of(context)!.translate('home_card_fast_response_title')),
                                        ],
                                        onTap: () {
                                          print("tap fast response title");
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10,),

                                //Title Subtitle
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: TextSelectionTheme(
                                    data: TextSelectionThemeData(
                                      cursorColor: Theme.of(context).primaryColor,
                                      selectionColor: Colors.red.withOpacity(0.5),
                                      selectionHandleColor: Colors.red.withOpacity(0.5),
                                    ),
                                    child: SelectableText(
                                      AppLocalizations.of(context)!.translate('home_card_fast_response_subtitle'),
                                      // softWrap: true,
                                      style: Theme.of(context).textTheme.bodyText2,
                                      // overflow: TextOverflow.ellipsis,
                                      maxLines: 8,
                                      cursorWidth: 3,
                                      cursorRadius: Radius.circular(20),
                                      enableInteractiveSelection: true,
                                      toolbarOptions: ToolbarOptions(
                                          copy: true,
                                          selectAll: true
                                      ),
                                      onSelectionChanged: (selection , cause){

                                      },
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),




                //////////////////////// * Card offers monthly * ////////////////////////
                ClipPath(
                  clipper: CardOffersMonthlyClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    child: Stack(
                      children: [

                        //Image Layer
                        OctoImage(
                          width: MediaQuery.of(context).size.width,
                          height: 500,
                          // alignment: ,///////////////////////////////////////////////////may use it
                          image: CachedNetworkImageProvider(
                              '....................................................'),
                          placeholderBuilder: OctoPlaceholder.blurHash(
                            'L79jN6Ri0pNG02s9~At7^boI9Fae',
                          ),
                          errorBuilder: OctoError.icon(color: Colors.red),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          fadeInCurve: Curves.easeIn,
                          fadeOutCurve: Curves.easeOut,
                          fadeInDuration: Duration(milliseconds: 300),
                          fadeOutDuration: Duration(milliseconds: 300),
                          placeholderFadeInDuration: Duration(milliseconds: 300),
                        ),

                        //Shadow Layer
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 500,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: FractionalOffset.bottomCenter,
                                  end:  FractionalOffset.topCenter,
                                  colors: [
                                    Theme.of(context).cardColor,
                                    Colors.transparent
                                  ],
                                  // stops: [
                                  //   0.0,
                                  //   0.25
                                  // ]

                                )
                            ),
                          ),
                        ),

                        //Texts Layer
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 500,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              //Title Text
                              Center(
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Center(
                                    child: DefaultTextStyle(
                                      style: Theme.of(context).textTheme.headline5!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 10,
                                              color: Theme.of(context).textTheme.headline5!.color as Color,  ///////////////
                                              offset: Offset(0, 0),
                                            ),
                                          ]),
                                      maxLines: 1,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      child: AnimatedTextKit(
                                        repeatForever: true,
                                        animatedTexts: [
                                          FlickerAnimatedText(AppLocalizations.of(context)!.translate('home_card_offers_monthly_title')),
                                        ],
                                        onTap: () {
                                          print("tap fast response title");
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10,),

                              //Title Subtitle
                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Center(
                                    child: TextSelectionTheme(
                                      data: TextSelectionThemeData(
                                        cursorColor: Theme.of(context).primaryColor,
                                        selectionColor: Colors.red.withOpacity(0.5),
                                        selectionHandleColor: Colors.red.withOpacity(0.5),
                                      ),
                                      child: SelectableText(
                                        AppLocalizations.of(context)!.translate('home_card_offers_monthly_subtitle'),
                                        // softWrap: true,
                                        style: Theme.of(context).textTheme.bodyText2,
                                        // overflow: TextOverflow.ellipsis,
                                        maxLines: 8,
                                        cursorWidth: 3,
                                        textAlign: TextAlign.center,
                                        cursorRadius: Radius.circular(20),
                                        enableInteractiveSelection: true,
                                        toolbarOptions: ToolbarOptions(
                                            copy: true,
                                            selectAll: true
                                        ),
                                        onSelectionChanged: (selection , cause){

                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 65,
                ),






                //////////////////////// * Card best meals * ////////////////////////
                //Title best meal
                Center(
                  child: Container(
                    width: (MediaQuery.of(context).size.width/2) + 150,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        //////////////////////// * Divider * ////////////////////////
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                            child: Center(child: Divider(thickness: 1.2 , color: Theme.of(context).dividerColor,)),
                          ),
                        ),


                        //////////////////////// * Star Icon * ////////////////////////
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: GlowIcon(
                              Icons.star_rate_outlined ,
                              color: Theme.of(context).accentColor ,
                              size: 15,
                              blurRadius: 10,
                              glowColor: Theme.of(context).accentColor,
                            ),
                          ),
                        ),


                        //////////////////////// * best meals text * ////////////////////////
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)!.translate('home_card_popular_foods_title'),
                            softWrap: true,
                            style: Theme.of(context).textTheme.headline5!.copyWith(
                                color: Theme.of(context).primaryColor,
                                shadows: [
                                  Shadow(
                                      offset: Offset(0,0),
                                      color: Theme.of(context).primaryColor,
                                      blurRadius: 10
                                  )
                                ]
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            // textAlign: ,
                          ),
                        ),


                        //////////////////////// * Star Icon * ////////////////////////
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: GlowIcon(
                              Icons.star_rate_outlined ,
                              color: Theme.of(context).accentColor ,
                              size: 15,
                              blurRadius: 10,
                              glowColor: Theme.of(context).accentColor,
                            ),
                          ),
                        ),


                        //////////////////////// * Divider * ////////////////////////
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                            child: Center(child: Divider(thickness: 1.2 , color: Theme.of(context).dividerColor,)),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                //Best meals Items
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    child: CarouselSlider.builder(
                      carouselController: carouselController,
                      options: carouselOptions,
                      itemCount: bestMeals.length,
                      itemBuilder: (context , index , realIndex){
                        return buildBestMealItem(context , index , realIndex , bestMeals[index]);
                      },


                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),







                //////////////////////// * Satisfied Clients * ////////////////////////

                //////////////////////// * Title Satisfied Clients * ////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                  child: Row(
                    children: [
                      AutoSizeText(
                          AppLocalizations.of(context)!.translate('home_card_satisfied_clients_title'),
                          style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                          minFontSize: 12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                //////////////////////// * Subtitle Satisfied Clients * ////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: AutoSizeText(
                            AppLocalizations.of(context)!
                                .translate('home_card_satisfied_clients_subtitle'),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith( color: Theme.of(context).dividerColor),
                            minFontSize: 12,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                //////////////////////// * Cards Satisfied Clients * ////////////////////////
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCardSatisfiedClient(
                          context ,
                          '..................................................' ,
                          'LVKBH@?a~qM{?HMxM{ayo}ofxakB',
                          'we always satisfied for working with this restaurant',
                          'Lionardo Suggry'
                      ),
                      buildCardSatisfiedClient(
                          context,
                          '...............................................',
                          'L4F~BR0000?F00H@?wyX01~X=E0K',
                          'We are so happy to have this business with this restaurant',
                          'Emilia Clock'
                      ),
                      buildCardSatisfiedClient(
                          context,
                          '..................................................',
                          'LNHU,=003E-:~VWCENt7NaoLVtWX',
                          'We have a lot of business and profits from this restaurant',
                          'Gorge clown'
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 65,
                ),





                //////////////////////// * Ready title * ////////////////////////
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 110,
                      child: arabicMode ?
                      Text(
                        AppLocalizations.of(context)!.translate('home_ready_title'),
                        style: Theme.of(context).textTheme.headline4!.copyWith(),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ) :
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.headline4!.copyWith(),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText(AppLocalizations.of(context)!.translate('home_ready_title')),
                            WavyAnimatedText(AppLocalizations.of(context)!.translate('home_ready_title')),
                            WavyAnimatedText(AppLocalizations.of(context)!.translate('home_ready_title')),
                          ],
                          isRepeatingAnimation: true,
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                ),





                //////////////////////// * Sign in button * ////////////////////////
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Link(
                      uri: Uri.parse(Routers.signInRoute),
                      target: LinkTarget.self,
                      builder: (context,followLink){
                        return CrossAnimationButton(50 , 160, 1.2, Curves.easeInOut, 400, Theme.of(context).textTheme.headline3!.color, Theme.of(context).textTheme.headline3!.color, Theme.of(context).cardColor, Theme.of(context).textTheme.headline3!.color , Theme.of(context).textTheme.headline3!.color, Theme.of(context).cardColor, AppLocalizations.of(context)!.translate('signIn_title') ,
                                () {
                              //Navigate to sign in
                              VxNavigator.of(context).push(
                                  Uri(path: Routers.signInRoute));
                            });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 60,),



                //////////////////////// * Card footer * ////////////////////////
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: MediaQuery.of(context).size.width,
                  // height: ,
                  padding: const EdgeInsets.only(top: 15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    child: Column(
                      children: [

                        //Footer items
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            //////////////////////// * social media section * ////////////////////////
                            Column(
                              children: [

                                //Title social media
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    TextSelectionTheme(
                                      data: TextSelectionThemeData(
                                        cursorColor: Theme.of(context).primaryColor,
                                        selectionColor: Colors.red.withOpacity(0.5),
                                        selectionHandleColor: Colors.red.withOpacity(0.5),
                                      ),
                                      child: SelectableText(
                                        AppLocalizations.of(context)!.translate('home_footer_socialMedia_title'),
                                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                                        // textAlign: ,
                                        maxLines: 2,
                                        // showCursor: true,
                                        cursorWidth: 3,
                                        cursorRadius: Radius.circular(20),
                                        enableInteractiveSelection: true,
                                        toolbarOptions: ToolbarOptions(
                                            copy: true,
                                            selectAll: true
                                        ),
                                        onSelectionChanged: (selection , cause){

                                        },
                                        // showCursor: true,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 4,),

                                //Icons social media
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    //Note: you can use followLink.call() to launch url and go to website

                                    //Whatsapp
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: BlocProvider<AnimatedButtonBloc>(
                                        create: (context) => AnimatedButtonBloc(),
                                        child: BlocBuilder<AnimatedButtonBloc,AnimatedButtonState>(
                                          buildWhen: (oldState,newState) => oldState != newState,
                                          builder: (context,state){

                                            return MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              onEnter: (val) {
                                                context.read<AnimatedButtonBloc>().update(true);
                                              },
                                              onExit: (val) {
                                                context.read<AnimatedButtonBloc>().update(false);
                                              },
                                              child: GestureDetector(
                                                onTap: (){
                                                  //Go to whatsapp account and display data by url launcher
                                                },
                                                child: Link(
                                                  uri: Uri.parse('www.whatsapp.com/foodyAccount'),  //show whatsapp link here
                                                  target: LinkTarget.blank,    //Open in other tab in web , mobile open in browser
                                                  builder: (context , followLink){
                                                    return FaIcon(
                                                        FontAwesomeIcons.whatsapp,
                                                        color: state.touched ? Color(0xFF2FAA32) : Theme.of(context).dividerColor,
                                                        size: 18);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    //Reddit
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: BlocProvider<AnimatedButtonBloc>(
                                        create: (context) => AnimatedButtonBloc(),
                                        child: BlocBuilder<AnimatedButtonBloc,AnimatedButtonState>(
                                          buildWhen: (oldState,newState) => oldState != newState,
                                          builder: (context,state){

                                            return MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              onEnter: (val) {
                                                context.read<AnimatedButtonBloc>().update(true);
                                              },
                                              onExit: (val) {
                                                context.read<AnimatedButtonBloc>().update(false);
                                              },
                                              child: GestureDetector(
                                                onTap: (){
                                                  //Go to reddit account and display data by url launcher
                                                },
                                                child: Link(
                                                  uri: Uri.parse('www.reddit.com/foodyAccount'),  //show reddit link here
                                                  target: LinkTarget.blank,    //Open in other tab in web , mobile open in browser
                                                  builder: (context , followLink){
                                                    return FaIcon(
                                                        FontAwesomeIcons.reddit,
                                                        color: state.touched ? Color(0xFFFF5700) : Theme.of(context).dividerColor,
                                                        size: 18);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    //twitter
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: BlocProvider<AnimatedButtonBloc>(
                                        create: (context) => AnimatedButtonBloc(),
                                        child: BlocBuilder<AnimatedButtonBloc,AnimatedButtonState>(
                                          buildWhen: (oldState,newState) => oldState != newState,
                                          builder: (context,state){

                                            return MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              onEnter: (val) {
                                                context.read<AnimatedButtonBloc>().update(true);
                                              },
                                              onExit: (val) {
                                                context.read<AnimatedButtonBloc>().update(false);
                                              },
                                              child: GestureDetector(
                                                onTap: (){
                                                  //Go to twitter account and display data by url launcher
                                                },
                                                child: Link(
                                                  uri: Uri.parse('www.twitter.com/foodyAccount'),  //show twitter link here
                                                  target: LinkTarget.blank,    //Open in other tab in web , mobile open in browser
                                                  builder: (context , followLink){
                                                    return FaIcon(
                                                        FontAwesomeIcons.twitter,
                                                        color: state.touched ? Color(0xFF1da1f2) : Theme.of(context).dividerColor,
                                                        size: 18);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    //facebook
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: BlocProvider<AnimatedButtonBloc>(
                                        create: (context) => AnimatedButtonBloc(),
                                        child: BlocBuilder<AnimatedButtonBloc,AnimatedButtonState>(
                                          buildWhen: (oldState,newState) => oldState != newState,
                                          builder: (context,state){

                                            return MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              onEnter: (val) {
                                                context.read<AnimatedButtonBloc>().update(true);
                                              },
                                              onExit: (val) {
                                                context.read<AnimatedButtonBloc>().update(false);
                                              },
                                              child: GestureDetector(
                                                onTap: (){
                                                  //Go to facebook account and display data by url launcher
                                                },
                                                child: Link(
                                                  uri: Uri.parse('www.facebook.com/foodyAccount'),  //show facebook link here
                                                  target: LinkTarget.blank,    //Open in other tab in web , mobile open in browser
                                                  builder: (context , followLink){
                                                    return FaIcon(
                                                        FontAwesomeIcons.facebook,
                                                        color: state.touched ? Color(0xFF0075fc) : Theme.of(context).dividerColor,
                                                        size: 18);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    //youtube
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: BlocProvider<AnimatedButtonBloc>(
                                        create: (context) => AnimatedButtonBloc(),
                                        child: BlocBuilder<AnimatedButtonBloc,AnimatedButtonState>(
                                          buildWhen: (oldState,newState) => oldState != newState,
                                          builder: (context,state){

                                            return MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              onEnter: (val) {
                                                context.read<AnimatedButtonBloc>().update(true);
                                              },
                                              onExit: (val) {
                                                context.read<AnimatedButtonBloc>().update(false);
                                              },
                                              child: GestureDetector(
                                                onTap: (){
                                                  //Go to youtube account and display data by url launcher
                                                },
                                                child: Link(
                                                  uri: Uri.parse('www.youtube.com/foodyAccount'),  //show youtube link here
                                                  target: LinkTarget.blank,    //Open in other tab in web , mobile open in browser
                                                  builder: (context , followLink){
                                                    return FaIcon(
                                                        FontAwesomeIcons.youtube,
                                                        color: state.touched ? Colors.red : Theme.of(context).dividerColor,
                                                        size: 18);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                  ],
                                )

                              ],
                            ),


                            //////////////////////// * Join The Team section * ////////////////////////
                            Column(
                              children: [

                                //Title Join The Team
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    TextSelectionTheme(
                                      data: TextSelectionThemeData(
                                        cursorColor: Theme.of(context).primaryColor,
                                        selectionColor: Colors.red.withOpacity(0.5),
                                        selectionHandleColor: Colors.red.withOpacity(0.5),
                                      ),
                                      child: SelectableText(
                                        AppLocalizations.of(context)!.translate('home_footer_join_the_team_title'),
                                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                                        // textAlign: ,
                                        maxLines: 2,
                                        // showCursor: true,
                                        cursorWidth: 3,
                                        cursorRadius: Radius.circular(20),
                                        enableInteractiveSelection: true,
                                        toolbarOptions: ToolbarOptions(
                                            copy: true,
                                            selectAll: true
                                        ),
                                        onSelectionChanged: (selection , cause){

                                        },
                                        // showCursor: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4,),

                                //Subtitle Career Opportunities
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('/career_opportunities'),
                                        builder: (context,followLink){
                                          return Text(
                                            AppLocalizations.of(context)!.translate('home_footer_join_the_team_career_opportunities_subtitle'),
                                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          );
                                        },
                                      ),
                                    )

                                  ],
                                ),
                                SizedBox(height: 8,),

                                //Subtitle Franchise Information
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('/franchise_information'),
                                        builder: (context,followLink){
                                          return Text(
                                            AppLocalizations.of(context)!.translate('home_footer_join_the_team_franchise_information_subtitle'),
                                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          );
                                        },
                                      ),
                                    )

                                  ],
                                ),
                                SizedBox(height: 2,),

                              ],
                            ),


                            //////////////////////// * Company Info section * ////////////////////////
                            Column(
                              children: [

                                //Title Company Info
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    TextSelectionTheme(
                                      data: TextSelectionThemeData(
                                        cursorColor: Theme.of(context).primaryColor,
                                        selectionColor: Colors.red.withOpacity(0.5),
                                        selectionHandleColor: Colors.red.withOpacity(0.5),
                                      ),
                                      child: SelectableText(
                                        AppLocalizations.of(context)!.translate('home_footer_company_info_title'),
                                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                                        // textAlign: ,
                                        maxLines: 2,
                                        // showCursor: true,
                                        cursorWidth: 3,
                                        cursorRadius: Radius.circular(20),
                                        enableInteractiveSelection: true,
                                        toolbarOptions: ToolbarOptions(
                                            copy: true,
                                            selectAll: true
                                        ),
                                        onSelectionChanged: (selection , cause){

                                        },
                                        // showCursor: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4,),

                                //Subtitle Our Story
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('/our_story'),
                                        builder: (context,followLink){
                                          return Text(
                                            AppLocalizations.of(context)!.translate('home_footer_company_info_our_story_subtitle'),
                                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          );
                                        },
                                      ),
                                    )

                                  ],
                                ),
                                SizedBox(height: 8,),

                                //Subtitle International
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('/international'),
                                        builder: (context,followLink){
                                          return Text(
                                            AppLocalizations.of(context)!.translate('home_footer_company_info_international_subtitle'),
                                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          );
                                        },
                                      ),
                                    )

                                  ],
                                ),
                                SizedBox(height: 8,),

                                //Subtitle FAQs
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('/FAQs'),
                                        builder: (context,followLink){
                                          return Text(
                                            AppLocalizations.of(context)!.translate('home_footer_company_info_FAQs_subtitle'),
                                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          );
                                        },
                                      ),
                                    )

                                  ],
                                ),
                                SizedBox(height: 8,),

                                //Subtitle Pressroom
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('/Pressroom'),
                                        builder: (context,followLink){
                                          return Text(
                                            AppLocalizations.of(context)!.translate('home_footer_company_info_Pressroom_subtitle'),
                                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          );
                                        },
                                      ),
                                    )

                                  ],
                                ),
                                SizedBox(height: 8,),

                                //Subtitle Sustainability
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('/Sustainability'),
                                        builder: (context,followLink){
                                          return Text(
                                            AppLocalizations.of(context)!.translate('home_footer_company_info_Sustainability_subtitle'),
                                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          );
                                        },
                                      ),
                                    )

                                  ],
                                ),
                                SizedBox(height: 8,),

                                //Subtitle Contact Us
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('/contact_us'),
                                        builder: (context,followLink){
                                          return Text(
                                            AppLocalizations.of(context)!.translate('home_footer_company_info_contact_us_subtitle'),
                                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          );
                                        },
                                      ),
                                    )

                                  ],
                                ),
                                SizedBox(height: 2,),


                              ],
                            ),


                            //////////////////////// * Foody section * ////////////////////////
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                //Image Element
                                Image.asset(
                                  "images/foody_logo.png" ,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover ,
                                  filterQuality: FilterQuality.high,
                                ),
                                SizedBox(height: 15,),

                                //Title Element
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    TextSelectionTheme(
                                      data: TextSelectionThemeData(
                                        cursorColor: Theme.of(context).primaryColor,
                                        selectionColor: Colors.red.withOpacity(0.5),
                                        selectionHandleColor: Colors.red.withOpacity(0.5),
                                      ),
                                      child: SelectableText(
                                        AppLocalizations.of(context)!.translate('home_title_header'),
                                        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                                        // textAlign: ,
                                        maxLines: 2,
                                        // showCursor: true,
                                        cursorWidth: 3,
                                        cursorRadius: Radius.circular(20),
                                        enableInteractiveSelection: true,
                                        toolbarOptions: ToolbarOptions(
                                            copy: true,
                                            selectAll: true
                                        ),
                                        onSelectionChanged: (selection , cause){

                                        },
                                        // showCursor: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25,),

                                //Android/IOS link on stores Element
                                Wrap(
                                  spacing: 2,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.translate('home_footer_android_ios_stores_text1'),
                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        //Url launcher to apple store app link or use followLink below
                                      },
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Link(
                                          target: LinkTarget.blank,
                                          uri: Uri.parse('https://play.google.com/foody_app'),
                                          builder: (context,followLink){
                                            return Text(
                                              AppLocalizations.of(context)!.translate('home_footer_android_ios_stores_text2'),
                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                  color: Theme.of(context).primaryColor ,
                                                  shadows: [
                                                    Shadow(
                                                        color: Theme.of(context).primaryColor,
                                                        blurRadius: 10,
                                                        offset: Offset(0,0)
                                                    )
                                                  ]),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.translate('home_footer_android_ios_stores_text3'),
                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        //Url launcher to google play app link  or use followLink below
                                      },
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Link(
                                          target: LinkTarget.blank,
                                          uri: Uri.parse('https://www.apple.com/store/foody_app'),
                                          builder: (context,followLink){
                                            return Text(
                                              AppLocalizations.of(context)!.translate('home_footer_android_ios_stores_text4'),
                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                  color: Theme.of(context).primaryColor ,
                                                  shadows: [
                                                    Shadow(
                                                        color: Theme.of(context).primaryColor,
                                                        blurRadius: 10,
                                                        offset: Offset(0,0)
                                                    )
                                                  ]),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8,),

                              ],
                            )

                          ],
                        ),
                        SizedBox(height: 40,),


                        //Footer licences
                        Wrap(
                          spacing: 5,
                          children: [

                            //Privacy Policy
                            GestureDetector(
                              onTap: (){
                                //Privacy Policy link launch by url launcher or followLink below
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Link(
                                  target: LinkTarget.blank,
                                  uri: Uri.parse('/privacy_policy'),
                                  builder: (context,followLink){
                                    return Text(
                                      AppLocalizations.of(context)!.translate('home_footer_privacy_policy'),
                                      style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    );
                                  },
                                ),
                              ),
                            ),
                            VerticalDivider(thickness: 2, color: Theme.of(context).dividerColor,),



                            //Conditions & Terms
                            GestureDetector(
                              onTap: (){
                                //Conditions & Terms link launch by url launcher or followLink below
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Link(
                                  target: LinkTarget.blank,
                                  uri: Uri.parse('/conditions_terms'),
                                  builder: (context,followLink){
                                    return Text(
                                      AppLocalizations.of(context)!.translate('home_footer_conditions_terms'),
                                      style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    );
                                  },
                                ),
                              ),
                            ),
                            VerticalDivider(thickness: 2, color: Theme.of(context).dividerColor,),



                            //Do Not Sell My Personal Info
                            GestureDetector(
                              onTap: (){
                                //Do Not Sell My Personal Info link launch by url launcher or followLink below
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Link(
                                  target: LinkTarget.blank,
                                  uri: Uri.parse('/do_not_sell_my_personal_info'),
                                  builder: (context,followLink){
                                    return Text(
                                      AppLocalizations.of(context)!.translate('home_footer_do_not_sell_my_personal_info'),
                                      style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    );
                                  },
                                ),
                              ),
                            ),
                            VerticalDivider(thickness: 2, color: Theme.of(context).dividerColor,),



                            //CA privacy
                            GestureDetector(
                              onTap: (){
                                //CA privacy link launch by url launcher or followLink below
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Link(
                                  target: LinkTarget.blank,
                                  uri: Uri.parse('/CA_privacy'),
                                  builder: (context,followLink){
                                    return Text(
                                      AppLocalizations.of(context)!.translate('home_footer_CA_privacy'),
                                      style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    );
                                  },
                                ),
                              ),
                            ),
                            VerticalDivider(thickness: 2, color: Theme.of(context).dividerColor,),



                            //Site Map
                            GestureDetector(
                              onTap: (){
                                //Site Map link launch by url launcher or followLink below
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Link(
                                  target: LinkTarget.blank,
                                  uri: Uri.parse('/site_map'),
                                  builder: (context,followLink){
                                    return Text(
                                      AppLocalizations.of(context)!.translate('home_footer_site_map'),
                                      style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    );
                                  },
                                ),
                              ),
                            ),
                            VerticalDivider(thickness: 2, color: Theme.of(context).dividerColor,),


                            //CA Transparency in Supply Chains Act
                            GestureDetector(
                              onTap: (){
                                //CA Transparency in Supply Chains Act link launch by url launcher or followLink below
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Link(
                                  target: LinkTarget.blank,
                                  uri: Uri.parse('/CA_transparency_in_supply_chains_act'),
                                  builder: (context,followLink){
                                    return Text(
                                      AppLocalizations.of(context)!.translate('home_footer_CA_transparency'),
                                      style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).dividerColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 60,),



                        //Footer Important Info
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextSelectionTheme(
                              data: TextSelectionThemeData(
                                cursorColor: Theme.of(context).primaryColor,
                                selectionColor: Colors.red.withOpacity(0.5),
                                selectionHandleColor: Colors.red.withOpacity(0.5),
                              ),
                              child: SelectableText(
                                AppLocalizations.of(context)!.translate('home_footer_important_info'),
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                // textAlign: ,
                                maxLines: 2,
                                // showCursor: true,
                                cursorWidth: 3,
                                cursorRadius: Radius.circular(20),
                                enableInteractiveSelection: true,
                                toolbarOptions: ToolbarOptions(
                                    copy: true,
                                    selectAll: true
                                ),
                                onSelectionChanged: (selection , cause){

                                },
                                // showCursor: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),



                        //Footer All Rights Reserved.
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextSelectionTheme(
                              data: TextSelectionThemeData(
                                cursorColor: Theme.of(context).primaryColor,
                                selectionColor: Colors.red.withOpacity(0.5),
                                selectionHandleColor: Colors.red.withOpacity(0.5),
                              ),
                              child: SelectableText(
                                AppLocalizations.of(context)!.translate('home_footer_Rights_Reserved'),
                                style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Theme.of(context).dividerColor),
                                // textAlign: ,
                                maxLines: 2,
                                // showCursor: true,
                                cursorWidth: 3,
                                cursorRadius: Radius.circular(20),
                                enableInteractiveSelection: true,
                                toolbarOptions: ToolbarOptions(
                                    copy: true,
                                    selectAll: true
                                ),
                                onSelectionChanged: (selection , cause){

                                },
                                // showCursor: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),

                      ],
                    ),
                  ),
                )


              ],
            ),
          ),
          ),
        ),
      );
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

  _onPageChangedCarouselSlider(int index, CarouselPageChangedReason reason) {
    // print('changed item in CarouselSlider $index');
  }

  Widget buildBestMealItem(BuildContext context, int index, int realIndex, HomeBestMealsModel bestMeal) {

    return Padding(
      padding: const EdgeInsets.all(12),
      child: ClipPath(
        clipper: BestMealsClipper(),
        child: Container(
          height: 350,
          width: MediaQuery.of(context).size.width/2,
          child: Stack(
            children: [

              //Image layer
              OctoImage(
                height: 350,
                width: MediaQuery.of(context).size.width/2,
                // alignment: ,///////////////////////////////////////////////////may use it
                image: CachedNetworkImageProvider(
                    bestMeal.urlImage),
                placeholderBuilder: OctoPlaceholder.blurHash(
                  bestMeal.urlBlurhash,
                ),
                errorBuilder: OctoError.icon(color: Colors.red),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                fadeInCurve: Curves.easeIn,
                fadeOutCurve: Curves.easeOut,
                fadeInDuration: Duration(milliseconds: 300),
                fadeOutDuration: Duration(milliseconds: 300),
                placeholderFadeInDuration: Duration(milliseconds: 300),
              ),

              //Shadow layer
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: 350,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: FractionalOffset.bottomCenter,
                          end:  FractionalOffset.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent
                          ],
                          // stops: [
                          //   0.0,
                          //   0.25
                          // ]

                      )
                  ),
                ),
              ),

              //Text layer
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    bestMeal.nameFood,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
                  ),
                ),
              )

            ],
          )
        ),
      ),
    );

  }

  buildCardSatisfiedClient(BuildContext context , String urlImage , String urlImageBlurhash , String text , String caption) {


    return Padding(
      padding: const EdgeInsets.all(25),
      child: BouncingWidget(
          child: BlocProvider<AnimatedButtonBloc>(
            create: (context) => AnimatedButtonBloc(),
            child: BlocBuilder<AnimatedButtonBloc, AnimatedButtonState>(
              buildWhen: (oldState, newState) => oldState != newState,
              builder: (context, state){

                return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (val) {
                      context.read<AnimatedButtonBloc>().update(true);
                    },
                    onExit: (val) {
                      context.read<AnimatedButtonBloc>().update(false);
                    },
                    //////////////////////// * Shadow Color * ////////////////////////
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            // BoxShadow(
                            //   color: state.touched ? Theme.of(context).primaryColor : Colors.black54,
                            //   offset: state.touched ? Offset(0.0, 3.0) : Offset(1.0, 6.0),
                            //   blurRadius: state.touched ? 4 : 10,
                            //   spreadRadius: 2.0,
                            // )
                          ]
                      ),
                      //////////////////////// * Clipping Item * ////////////////////////
                      child: ClipPath(
                        clipper: CardSatisfiedClientClipper(),
                        child: Container(
                          width: 250,
                          height: 400,
                          child: Stack(
                            children: [

                              //Image Layer
                              OctoImage(
                                width: 250,
                                height: 400,
                                // alignment: ,///////////////////////////////////////////////////may use it
                                image: CachedNetworkImageProvider(
                                    urlImage),
                                placeholderBuilder: OctoPlaceholder.blurHash(
                                  urlImageBlurhash,
                                ),
                                errorBuilder: OctoError.icon(color: Colors.red),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                fadeInCurve: Curves.easeIn,
                                fadeOutCurve: Curves.easeOut,
                                fadeInDuration: Duration(milliseconds: 300),
                                fadeOutDuration: Duration(milliseconds: 300),
                                placeholderFadeInDuration: Duration(milliseconds: 300),
                              ),

                              //Hover Effect Layer
                              AnimatedContainer(
                                width: 250,
                                height: state.touched ? 400 : 0,
                                duration: Duration(seconds: 1),
                                curve: Curves.easeInOut,
                                color: Colors.black.withOpacity(0.7),
                                child: Stack(
                                  children: [

                                    //Text layer
                                    AnimatedOpacity(
                                      duration: Duration(seconds: 1),
                                      opacity: state.touched ? 1 : 0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          text,
                                          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 6,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),

                                    //Caption layer
                                    AnimatedOpacity(
                                      duration: Duration(seconds: 1),
                                      opacity: state.touched ? 1 : 0,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                caption,
                                                style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.white),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                // textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                              )

                            ],
                          ),
                        ),
                      ),
                    )
                );
              },
            ),
          ),
          onPressed:
              () => print('client ${caption} is clicked !!!!')
      ),
      );

  }

}

