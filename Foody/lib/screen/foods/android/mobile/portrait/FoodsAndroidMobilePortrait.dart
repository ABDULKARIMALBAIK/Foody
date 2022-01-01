import 'dart:math';

import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_notifications/desktop_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:foody/bloc/blocUnit/AnimatedButtonBloc.dart';
import 'package:foody/bloc/blocUnit/Food/FoodBloc.dart';
import 'package:foody/bloc/state/AnimatedButtonState.dart';
import 'package:foody/bloc/state/Food/FoodState.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/model/modelNetwork/Bannerr.dart';
import 'package:foody/model/modelNetwork/Food.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/style/platformDetect/PlatformDetector.dart';
import 'package:foody/viewModel/FoodViewModel.dart';
import 'package:foody/widget/DataTemplate/DataTamplete.dart';
import 'package:foody/widget/DrawerApp.dart';
import 'package:foody/widget/SnakBarBuilder.dart';
import 'package:hive/hive.dart';
import 'package:octo_image/octo_image.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter_audio_desktop/flutter_audio_desktop.dart' as audioDesktop;
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:foody/bloc/state/AnimatedSearchState.dart';
import 'package:foody/bloc/blocUnit/AnimatedSearchBloc.dart';
import 'package:foody/constant/Common.dart';

class FoodsAndroidMobilePortrait extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FoodsAndroidMobilePortraitState();

}

class _FoodsAndroidMobilePortraitState extends State<FoodsAndroidMobilePortrait> with TickerProviderStateMixin{

  late ScrollController scrollController;
  late Duration listShowItemDuration;

  //Init ViewModel
  late FoodViewModel _viewModel;

  //First init
  bool isFirstTimeTabs = true;
  bool isFirstTimeBanner = true;
  bool isFirstTimeFoods = true;


  List<Tab> tabs = [];
  List<String> tabsIndex = [];
  List<Bannerr> banners = [];
  List<Food> foods = [];

  var foodsData;
  var bannerData;
  late FoodBloc _foodBloc;
  late GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();


  //Init vars
  var darkMode;
  var arabicMode;
  int selectedIndex = 0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('repeat food page');

    _viewModel = FoodViewModel();
    listShowItemDuration = Duration(milliseconds: 250);
    scrollController = ScrollController();

    //We load data from here because when resize the window or browser we load data many times
    foodsData = _viewModel.foods(int.parse(tabsIndex.length <= 0 ? "1" : tabsIndex[0].toString()));
    bannerData = _viewModel.bannerData();

    _foodBloc = FoodBloc(foodsData , "Burger");


    //init firebase messaging (init in main.dart , ask permission in home.dart , listen from foreground checkout.dart)
    //Check isFirstTimeFirebaseMessaging to improve performance
    if(Common.isFirstTimeFirebaseMessaging){

      requestPermissionFirebaseMessaging();
      requestPermissionShowNotification();
      startFirebaseMessagingBackgroundListing();
      startFirebaseMessagingForegroundListing();
      getFirebaseMessagingToken();


      Common.isFirstTimeFirebaseMessaging = false;
      print('isFirstTimeFirebaseMessaging : ${Common.isFirstTimeFirebaseMessaging}');
    }

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {


    final options = LiveOptions(
      // Start animation after (default zero)
      delay: Duration(seconds: 1),

      // Show each item through (default 250)
      showItemInterval: Duration(milliseconds: 500),

      // Animation duration (default 250)
      showItemDuration: Duration(seconds: 1),

      // Animations starts at 0.05 visible
      // item fraction in sight (default 0.025)
      visibleFraction: 0.05,

      // Repeat the animation of the appearance
      // when scrolling in the opposite direction (default false)
      // To get the effect as in a showcase for ListView, set true
      reAnimateOnVisibility: true,
    );


    //Init Hive
    var box = Hive.box('foody');
    darkMode = box.get('darkMode', defaultValue: false);
    arabicMode = box.get('arabicMode', defaultValue: false);
    print('isDark : ' + darkMode.toString());
    print('isEnglish : ' + arabicMode.toString());





    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // drawer: DrawerApp(0 , context , _scaffoldKey , true),
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).cardColor,
      //   centerTitle: true,
      //   title: AutoSizeText(
      //       AppLocalizations.of(context)!.translate('food_title'),
      //       style: Theme.of(context).textTheme.headline4!.copyWith(),
      //       minFontSize: 18,
      //       maxLines: 1,
      //       overflow: TextOverflow.ellipsis
      //   ),
      //   leading: IconButton(
      //     onPressed: (){
      //       print('drawer is : ${_scaffoldKey.currentState!.isDrawerOpen}');
      //       if(!_scaffoldKey.currentState!.isDrawerOpen)
      //         _scaffoldKey.currentState!.openDrawer();
      //       print('drawer is : ${_scaffoldKey.currentState!.isDrawerOpen}');
      //     },
      //     icon: Icon(Icons.menu),
      //     iconSize: 35,
      //   ),
      // ),
      floatingActionButton: ScrollingFabAnimated(
        icon: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
        text: Text(AppLocalizations.of(context)!.translate('cart_title'), style: TextStyle(color: Colors.white, fontSize: 16.0),),
        elevation: 6,
        color: Theme.of(context).primaryColor,
        onPress: (){
          //Nav2cart
          Navigator.of(context).pushNamed(Routers.cartRoute);
        },
        scrollController: scrollController,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [

              //////////////////////// * Foods * ////////////////////////
              Expanded(
                  flex: 1,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _viewModel.categories(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                        //There is an error
                        if (snapshot.hasError) {
                          print('there is a problem !!!   ${snapshot.hasError.toString()}    ${snapshot.error.toString()}');
                          return DataTemplate.error(context);
                        }

                        ////No Data
                        if (!snapshot.hasData) {
                          return DataTemplate.noData(context);
                        }

                        //Load data
                        if (snapshot.connectionState == ConnectionState.waiting){
                          print('load category Data');
                          return DataTemplate.load(context);
                        }

                        //No Internet
                        if (snapshot.connectionState == ConnectionState.none){
                          print('No Internet !!!');
                          return DataTemplate.noInternet(context);
                        }

                        //snapshot.connectionState == ConnectionState.active or snapshot.connectionState == ConnectionState.done (has data)

                        if(isFirstTimeTabs){
                          snapshot.data!.docs.forEach((DocumentSnapshot document){

                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                            tabs.add(Tab(text: data['name'].toString(),));
                            tabsIndex.add(document.id);

                          });
                          isFirstTimeTabs = false;
                        }

                        //Print size of tabs list
                        print('size of tabs is ${tabs.length}');

                        //Init TabController
                        final TabController _tabController = TabController(length: tabs.length , vsync: this);

                        return CustomScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          slivers: [
                            SliverList(
                                delegate: SliverChildListDelegate([

                                  // //////////////////////// * Title * ////////////////////////
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 16),
                                  //   child: Row(
                                  //     children: [
                                  //       Flexible(
                                  //         child: AutoSizeText(
                                  //             AppLocalizations.of(context)!
                                  //                 .translate('food_title'),
                                  //             style: Theme.of(context)
                                  //                 .textTheme
                                  //                 .headline3!
                                  //                 .copyWith(),
                                  //             minFontSize: 18,
                                  //             maxLines: 1,
                                  //             overflow: TextOverflow.ellipsis
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 1,
                                  // ),



                                  // //////////////////////// * Subtitle * ////////////////////////
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 16),
                                  //   child: Row(
                                  //     children: [
                                  //       Flexible(
                                  //         child: AutoSizeText(
                                  //             AppLocalizations.of(context)!
                                  //                 .translate('food_subtitle'),
                                  //             style: Theme.of(context)
                                  //                 .textTheme
                                  //                 .headline6!
                                  //                 .copyWith( color: Theme.of(context).dividerColor),
                                  //             minFontSize: 12,
                                  //             maxLines: 2,
                                  //             overflow: TextOverflow.ellipsis
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 14,
                                  // ),



                                  //////////////////////// * Banner  Title * ////////////////////////
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 16),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: AutoSizeText(
                                              AppLocalizations.of(context)!
                                                  .translate('food_banner_title'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(),
                                              minFontSize: 18,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),



                                  //////////////////////// * Banner  List * ////////////////////////
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2 , vertical: 12),
                                    child: Container(
                                      child: StreamBuilder<QuerySnapshot>(
                                          stream: bannerData,
                                          builder: (context , snapshotBanner){

                                            //There is an error
                                            if (snapshotBanner.hasError) {
                                              print('there is a problem !!!   ${snapshotBanner.hasError.toString()}    ${snapshotBanner.error.toString()}');
                                              return DataTemplate.error(context);
                                            }

                                            ////No Data
                                            if (!snapshotBanner.hasData) {
                                              if (snapshotBanner.connectionState ==  ConnectionState.done){
                                                return DataTemplate.noData(context);
                                              }

                                            }

                                            //Load data
                                            if (snapshotBanner.connectionState == ConnectionState.waiting){
                                              print('load category Data');
                                              return DataTemplate.load(context);
                                            }

                                            //No Internet
                                            if (snapshotBanner.connectionState == ConnectionState.none){
                                              print('No Internet !!!');
                                              return DataTemplate.noInternet(context);
                                            }

                                            //snapshot.connectionState == ConnectionState.active or snapshot.connectionState == ConnectionState.done (has data)
                                            //Init data banners

                                            if(isFirstTimeBanner){
                                              banners.clear();
                                              banners = [];
                                              snapshotBanner.data!.docs.forEach((DocumentSnapshot document){
                                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                                banners.add(Bannerr(data['food_id'].toString(), data['img'], data['name'] , data['blurhashImg']));
                                                print('add new banner ${document.id.toString()}');
                                              });
                                              isFirstTimeBanner = false;
                                            }


                                            //Print size of tabs list
                                            print('size of banners is ${banners.length}');

                                            return Container(
                                              height: 250,
                                              child: LiveList.options(
                                                scrollDirection: Axis.horizontal,
                                                // And attach root sliver scrollController to widgets
                                                // controller: scrollController,
                                                options: options,
                                                // showItemDuration: listShowItemDuration,
                                                itemCount: banners.length,
                                                itemBuilder: (context, index , animate) => buildBanner(context, banners[index] , animate),
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),



                                  //////////////////////// * Bloc to handle changing of tabBar * ////////////////////////
                                  BlocProvider<FoodBloc>.value(
                                      value: _foodBloc,
                                      child:

                                      //////////////////////// * BlocBuilder to handle changing on title and list of foods * ////////////////////////
                                      BlocBuilder<FoodBloc,FoodState>(
                                        buildWhen: (oldState,newState) => oldState != newState,
                                        builder: (contextChangingFood , stateChangingFood){
                                          print('build it again !!!!');
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [


                                              //////////////////////// * TabBar * ////////////////////////
                                              Padding(
                                                padding: EdgeInsets.zero,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.zero,
                                                      child: TabBar(
                                                        isScrollable: true,
                                                        unselectedLabelColor: Colors.grey,
                                                        labelColor: Colors.white,
                                                        indicatorSize: TabBarIndicatorSize.tab,
                                                        indicator: BubbleTabIndicator(
                                                          indicatorColor: Theme.of(context).primaryColor,
                                                          indicatorHeight: 25.0,
                                                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                                        ),
                                                        tabs: tabs,
                                                        controller: _tabController,
                                                        onTap: (index){

                                                          //print
                                                          print('index : ' + index.toString());
                                                          print('tabsIndex : ' + tabsIndex[index].toString());
                                                          print('tabs : ' + tabs[index].text.toString());

                                                          // Change Food list
                                                          // foodsData = [];
                                                          // foodsData = _viewModel.foods(int.parse(tabsIndex[index]));
                                                          contextChangingFood.read<FoodBloc>().load(_viewModel.foods(int.parse(tabsIndex[index])));
                                                          contextChangingFood.read<FoodBloc>().changeName(tabs[index].text.toString());
                                                          isFirstTimeFoods = true;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),



                                              //////////////////////// * SearchBar * ////////////////////////
                                              Directionality(
                                                textDirection: TextDirection.ltr,
                                                child: Padding(
                                                    padding: EdgeInsets.all(4),
                                                    child: Row(
                                                      children: [
                                                        AnimatedSearch((String searchText){
                                                          // Change Food list
                                                          // foodsData = [];
                                                          // foodsData = _viewModel.searchFoods(searchText);
                                                          contextChangingFood.read<FoodBloc>().search(_viewModel.searchFoods(searchText));
                                                          isFirstTimeFoods = true;
                                                        }),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),


                                              //////////////////////// * Foods  Title * ////////////////////////
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 16),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      child: AutoSizeText(
                                                        // AppLocalizations.of(context)!
                                                        //     .translate('drawable_item_foods'),
                                                          stateChangingFood.nameCategory,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline5!
                                                              .copyWith(),
                                                          minFontSize: 18,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),


                                              //////////////////////// * Foods List * ////////////////////////
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 2 , vertical: 8),
                                                child: Container(
                                                    child: StreamBuilder<QuerySnapshot>(
                                                        stream: stateChangingFood.foodData,
                                                        builder: (context , AsyncSnapshot<QuerySnapshot> snapshotFoods){

                                                          //There is an error
                                                          if (snapshotFoods.hasError) {
                                                            print('there is a problem !!!   ${snapshot.hasError.toString()}    ${snapshot.error.toString()}');
                                                            return DataTemplate.error(context);
                                                          }

                                                          ////No Data
                                                          if (!snapshotFoods.hasData) {
                                                            return DataTemplate.noData(context);
                                                          }

                                                          //Load data
                                                          if (snapshotFoods.connectionState == ConnectionState.waiting){
                                                            print('load category Data');
                                                            return DataTemplate.load(context);
                                                          }

                                                          //No Internet
                                                          if (snapshotFoods.connectionState == ConnectionState.none){
                                                            print('No Internet !!!');
                                                            return DataTemplate.noInternet(context);
                                                          }

                                                          //snapshot.connectionState == ConnectionState.active or snapshot.connectionState == ConnectionState.done (has data)
                                                          //Init data foods
                                                          if(isFirstTimeFoods){
                                                            print('pass it firstTime');
                                                            foods.clear();
                                                            foods = [];
                                                            snapshotFoods.data!.docs.forEach((DocumentSnapshot document){
                                                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                                              foods.add(Food(document.id , data['blurhashImg'].toString(), data['category_id'].toString(), data['code'].toString(), data['description'].toString(), data['hasDiscount'].toString(), data['img'].toString(), data['isSale'].toString(), data['name'].toString(), data['newPrice'].toString(), data['oldPrice'].toString(), data['star'].toString()));
                                                            });
                                                            isFirstTimeFoods = false;
                                                          }


                                                          //Print size of tabs list
                                                          print('size of foods is ${foods.length}');

                                                          return Container(
                                                            // height: MediaQuery.of(context).size.height + 800,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                LiveGrid.options(
                                                                  // And attach root sliver scrollController to widgets
                                                                  scrollDirection: Axis.vertical,
                                                                  controller: scrollController,
                                                                  options: options,
                                                                  shrinkWrap: true,
                                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                    childAspectRatio: MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height * 0.7),  // width/height children   //250
                                                                    crossAxisCount: 1,
                                                                    crossAxisSpacing: 10,  //16
                                                                    mainAxisSpacing: 10,   //16
                                                                  ),
                                                                  // showItemDuration: listShowItemDuration,
                                                                  itemCount: foods.length,
                                                                  itemBuilder: (contextt, index , animate) => buildFood(contextt, foods[index] , animate),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                    )
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                  ),

                                ]
                                )
                            ),

                          ],
                        );

                      }
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }




  buildBanner(BuildContext context, Bannerr banner, Animation<double> animation) {

    return BouncingWidget(
      onPressed: (){
        print('show details banner');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          // And slide transition
          child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child: BlocProvider<AnimatedButtonBloc>(
                create: (context) => AnimatedButtonBloc(),
                child: BlocBuilder<AnimatedButtonBloc,AnimatedButtonState>(
                    buildWhen: (oldState , newState) => oldState != newState,
                    builder: (contextBanner,stateBanner){

                      return MouseRegion(
                        onExit: (event) => contextBanner.read<AnimatedButtonBloc>().update(false),
                        onEnter: (event) => contextBanner.read<AnimatedButtonBloc>().update(true),
                        cursor: SystemMouseCursors.click,

                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: stateBanner.touched ? Theme.of(context).primaryColor : Colors.black54,
                                  offset: stateBanner.touched ? Offset(0.0, 3.0) : Offset(1.0, 6.0),
                                  blurRadius: stateBanner.touched ? 4 : 10,
                                  spreadRadius: 2.0,
                                )
                              ]
                          ),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: stateBanner.touched ? Theme.of(context).accentColor : Color(0xAD1C1C1C),
                                      offset: Offset(0.0, 5.0),
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ]
                              ),
                              height: 220,
                              width: 450,
                              child: Material(
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  child: OctoImage(
                                    height: 220,
                                    image: CachedNetworkImageProvider(
                                        banner.img),
                                    placeholderBuilder: OctoPlaceholder.blurHash(
                                      banner.blurhashImg,
                                    ),
                                    errorBuilder: OctoError.icon(color: Colors.red),
                                    fit: BoxFit.cover,
                                    fadeInCurve: Curves.easeIn,
                                    fadeOutCurve: Curves.easeOut,
                                    fadeInDuration: Duration(milliseconds: 300),
                                    fadeOutDuration: Duration(milliseconds: 300),
                                    placeholderFadeInDuration: Duration(milliseconds: 300),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              )
          ),
        ),
      ),
    );
  }

  buildFood(BuildContext context, Food food, Animation<double> animation) {

    return BouncingWidget(
      onPressed: () {
        print('show details foods');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),

          // And slide transition
          child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),

              child: BlocProvider<AnimatedButtonBloc>(
                create: (context) => AnimatedButtonBloc(),
                child: BlocBuilder<AnimatedButtonBloc,AnimatedButtonState>(
                    buildWhen: (oldState , newState) => oldState != newState,
                    builder: (contextFood,stateFood){

                      return MouseRegion(
                        onExit: (event) => contextFood.read<AnimatedButtonBloc>().update(false),
                        onEnter: (event) => contextFood.read<AnimatedButtonBloc>().update(true),
                        cursor: SystemMouseCursors.click,

                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: stateFood.touched ? Theme.of(context).primaryColor : Colors.black54,
                                  offset: stateFood.touched ? Offset(0.0, 3.0) : Offset(1.0, 6.0),
                                  blurRadius: stateFood.touched ? 4 : 10,
                                  spreadRadius: 2.0,
                                )
                              ]
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              height: 420,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: stateFood.touched ? Theme.of(context).accentColor : Colors.black54,
                                      offset: Offset(0.0, 5.0),
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ]
                              ),
                              // height: 220,
                              // width: 320,   because is gridView
                              child: Material(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(16),
                                child: Link(
                                  target: LinkTarget.self,
                                  uri: Uri(path: Routers.foodDetailRoute + '/' + food.name.toString()),
                                  builder: (context , followLink){
                                    return InkWell(
                                      onTap: (){
                                        print('inkwell tap it !');
                                        Navigator.of(context).pushNamed(Routers.foodDetailRoute , arguments: food);
                                      },
                                      borderRadius: BorderRadius.circular(16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          //////////////////////// * Image* ////////////////////////
                                          Container(
                                            height: 220,
                                            width: 600,
                                            child: Stack(
                                              children: [

                                                OctoImage(
                                                  height: 220,
                                                  width: 600,
                                                  image: CachedNetworkImageProvider(
                                                      food.img),
                                                  placeholderBuilder: OctoPlaceholder.blurHash(
                                                    food.blurhashImg,
                                                  ),
                                                  errorBuilder: OctoError.icon(color: Colors.red),
                                                  fit: BoxFit.cover,
                                                  fadeInCurve: Curves.easeIn,
                                                  fadeOutCurve: Curves.easeOut,
                                                  fadeInDuration: Duration(milliseconds: 300),
                                                  fadeOutDuration: Duration(milliseconds: 300),
                                                  placeholderFadeInDuration: Duration(milliseconds: 300),
                                                ),

                                                Container(
                                                  height: 220,
                                                  width: 600,
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
                                              ],
                                            ),
                                          ),


                                          // //////////////////////// * Image* ////////////////////////
                                          // Container(
                                          //   height: 25,
                                          //   decoration: BoxDecoration(
                                          //       gradient: LinearGradient(
                                          //         begin: Alignment.bottomCenter,
                                          //         end: Alignment.topCenter,
                                          //         colors: [
                                          //           Theme.of(context).cardColor,
                                          //           Colors.transparent
                                          //         ],
                                          //       )
                                          //   ),
                                          // ),
                                          //////////////////////// * Name * ////////////////////////
                                          SizedBox(height: 7,),
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(4),
                                              child: AutoSizeText(
                                                  food.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(),
                                                  minFontSize: 8,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 4,),

                                          //////////////////////// * Star * ////////////////////////
                                          Center(
                                            child: Padding(
                                                padding: EdgeInsets.all(4),
                                                child: RatingBar.builder(
                                                  itemSize: 28,
                                                  glow: true,
                                                  glowRadius: 5,
                                                  glowColor: Colors.yellowAccent,
                                                  initialRating: double.parse(food.star),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                )
                                            ),
                                          ),


                                          // //////////////////////// * Price * ////////////////////////
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(4),
                                              child: AutoSizeText(
                                                  food.newPrice.toString() + " \$",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4!
                                                      .copyWith(color: Theme.of(context).primaryColor),
                                                  minFontSize: 8,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              )
          ),
        ),
      ),
    );
  }







  void requestPermissionShowNotification() {

    //Request permission to android / ios
    if(PlatformDetector.isIOS || PlatformDetector.isAndroid){

      try{

        AwesomeNotifications().isNotificationAllowed().then((isAllowed){
          if (!isAllowed) {

            //Show dialog to permission
            PlatformDetector.isAndroid ?
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              // false = user must tap button, true = tap outside dialog
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  backgroundColor: Theme.of(context).cardColor,
                  title: Text(AppLocalizations.of(context)!.translate('checkout_notification_dialog_title') , style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),),
                  content: Text(AppLocalizations.of(context)!.translate('checkout_notification_dialog_content') , style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
                  actions: <Widget>[
                    TextButton(
                      child: Text(AppLocalizations.of(context)!.translate('checkout_notification_dialog_no') , style: TextStyle(color: Colors.grey),),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                    TextButton(
                      child: Text(AppLocalizations.of(context)!.translate('checkout_notification_dialog_ok') , style: TextStyle(color: Theme.of(context).primaryColor),),
                      onPressed: () {


                        AwesomeNotifications().requestPermissionToSendNotifications().then((value){

                          //if user accept permission
                          if(value){
                            SnakBarBuilder.buildAwesomeSnackBar(
                                context,
                                AppLocalizations.of(context)!.translate('food_snackBar_accept_permission'),
                                Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                AwesomeSnackBarType.success);
                          }
                          //if user denied permission
                          else {
                            SnakBarBuilder.buildAwesomeSnackBar(
                                context,
                                AppLocalizations.of(context)!.translate('food_snackBar_denied_permission'),
                                Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                AwesomeSnackBarType.error);
                          }

                        });
                        Navigator.of(dialogContext).pop();

                      },
                    ),
                  ],
                );

              },
            )
                :  //IOS
            showCupertinoDialog<void>(
              context: context,
              barrierDismissible: false,
              // false = user must tap button, true = tap outside dialog
              builder: (BuildContext dialogContext) {
                return CupertinoAlertDialog(
                  title: Text(AppLocalizations.of(context)!.translate('checkout_notification_dialog_title')),
                  content: Text(AppLocalizations.of(context)!.translate('checkout_notification_dialog_content')),
                  actions: [
                    CupertinoDialogAction(
                      child: Text(AppLocalizations.of(context)!.translate('checkout_notification_dialog_no') , style: TextStyle(color: CupertinoColors.systemRed),),
                      onPressed: (){
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text(AppLocalizations.of(context)!.translate('checkout_notification_dialog_ok') , style: TextStyle(color: CupertinoColors.systemBlue),),
                      onPressed: (){


                        AwesomeNotifications().requestPermissionToSendNotifications().then((value){


                          //if user accept permission
                          if(value){
                            SnakBarBuilder.buildAwesomeSnackBar(
                                context,
                                AppLocalizations.of(context)!.translate('food_snackBar_accept_permission'),
                                Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                AwesomeSnackBarType.success);
                          }
                          //if user denied permission
                          else {
                            SnakBarBuilder.buildAwesomeSnackBar(
                                context,
                                AppLocalizations.of(context)!.translate('food_snackBar_denied_permission'),
                                Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                AwesomeSnackBarType.error);
                          }

                        });
                        Navigator.of(dialogContext).pop();

                      },
                    )
                  ],
                );

              },
            );

          }
          //User allowed to push notification before
          else {
            //show Notification
            print('user is accept the permission before');
          }

        });


      }
      catch(e){
        print('error happened !!!!!! \n $e');
      }

    }
    else {
      print('other platforms no need request permission');
    }


  }

  startFirebaseMessagingForegroundListing() async{

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

      //Create a dialog
      showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Theme.of(context).cardColor,
            child: _showDialog(context , message),
          )
      );


      //Create a notification
      if(PlatformDetector.isAndroid || PlatformDetector.isIOS){

        AwesomeNotifications().isNotificationAllowed().then((isAllowed){

          if(!isAllowed){

            print('we do not have a permission to push notification');
            AwesomeNotifications().requestPermissionToSendNotifications().then((value){
              //No need to check value if true , because the user accept before

              //accept permission
              if(value){
                //show Notification
                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                      id: Random().nextInt(1000),
                      channelKey: '11112222',
                      title: PlatformDetector.isAndroid ?  message.data['title'] : message.notification!.title ,  //IOS
                      body: PlatformDetector.isAndroid ? message.data['body'] : message.notification!.body,  //IOS
                      // color: Theme.of(context).textTheme.bodyText1!.color,
                      // backgroundColor: Theme.of(context).cardColor,
                      icon: 'asset://assets/images/foody_logo.png',
                      // largeIcon: carts[0].img,
                      // bigPicture: carts[0].img,
                      displayOnBackground: true,
                      displayOnForeground: true,
                      hideLargeIconOnExpand: true,
                      notificationLayout: NotificationLayout.Default,
                    ),
                    actionButtons: [
                      NotificationActionButton(enabled: true, buttonType: ActionButtonType.DisabledAction)
                    ]
                );
              }
              else {
                print('can not push notification');
              }
            });

          }
          else {
            //show Notification
            AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: Random().nextInt(1000),
                  channelKey: '11112222',
                  title: PlatformDetector.isAndroid ?  message.data['title'] : message.notification!.title ,  //IOS
                  body: PlatformDetector.isAndroid ? message.data['body'] : message.notification!.body,  //IOS
                  // color: Theme.of(context).textTheme.bodyText1!.color,
                  // backgroundColor: Theme.of(context).cardColor,
                  icon: 'asset://assets/images/foody_logo.png',
                  // largeIcon: carts[0].img,
                  // bigPicture: carts[0].img,
                  displayOnBackground: true,
                  displayOnForeground: true,
                  hideLargeIconOnExpand: true,
                  notificationLayout: NotificationLayout.Default,
                ),
                actionButtons: [
                  NotificationActionButton(enabled: true, buttonType: ActionButtonType.DisabledAction)
                ]);
          }

        });

      }
      else if(!PlatformDetector.isWeb){  //Windows , Linux , MacOS


        var client = NotificationsClient();
        await client.notify(
          message.notification!.title.toString(),
          appName: 'Foody',
          body: message.notification!.body.toString(),
          actions: [
            NotificationAction('0', 'OK')
          ],
          // appIcon: '',   i don't know ??????????????????????????????
        );
        await client.close();

      }

    });
  }

  void startFirebaseMessagingBackgroundListing() async{

    // Important info : this method work with android/ios/macos , doesn't work with web

    FirebaseMessaging.onBackgroundMessage((message) async {

      if(PlatformDetector.isAndroid || PlatformDetector.isIOS){

        AwesomeNotifications().isNotificationAllowed().then((isAllowed){

          if(!isAllowed){

            print('we do not have a permission to push notification');
            AwesomeNotifications().requestPermissionToSendNotifications().then((value){
              //No need to check value if true , because the user accept before

              //accept permission
              if(value){
                //show Notification
                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                      id: Random().nextInt(1000),
                      channelKey: '11112222',
                      title: PlatformDetector.isAndroid ?  message.data['title'] : message.notification!.title ,  //IOS
                      body: PlatformDetector.isAndroid ? message.data['body'] : message.notification!.body,  //IOS
                      // color: Theme.of(context).textTheme.bodyText1!.color,
                      // backgroundColor: Theme.of(context).cardColor,
                      icon: 'asset://assets/images/foody_logo.png',
                      // largeIcon: carts[0].img,
                      // bigPicture: carts[0].img,
                      displayOnBackground: true,
                      displayOnForeground: true,
                      hideLargeIconOnExpand: true,
                      notificationLayout: NotificationLayout.Default,
                    ),
                    actionButtons: [
                      NotificationActionButton(enabled: true, buttonType: ActionButtonType.DisabledAction)
                    ]
                );
              }
              else {
                print('can not push notification');
              }


            });

          }
          else {
            //show Notification
            AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: Random().nextInt(1000),
                  channelKey: '11112222',
                  title: PlatformDetector.isAndroid ?  message.data['title'] : message.notification!.title ,  //IOS
                  body: PlatformDetector.isAndroid ? message.data['body'] : message.notification!.body,  //IOS
                  // color: Theme.of(context).textTheme.bodyText1!.color,
                  // backgroundColor: Theme.of(context).cardColor,
                  icon: 'asset://assets/images/foody_logo.png',
                  // largeIcon: carts[0].img,
                  // bigPicture: carts[0].img,
                  displayOnBackground: true,
                  displayOnForeground: true,
                  hideLargeIconOnExpand: true,
                  notificationLayout: NotificationLayout.Default,
                ),
                actionButtons: [
                  NotificationActionButton(enabled: true, buttonType: ActionButtonType.DisabledAction)
                ]);
          }

        });

      }
      else if(!PlatformDetector.isWeb){  //Windows , Linux , MacOS

        var client = NotificationsClient();
        await client.notify(
          message.notification!.title.toString(),
          appName: 'Foody',
          body: message.notification!.body.toString(),
          actions: [
            NotificationAction('0', 'OK')
          ],
          // appIcon: '',   i don't know ??????????????????????????????
        );
        await client.close();

      }

    });


  }

  void getFirebaseMessagingToken() async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // use the returned token to send messages to users from your custom server
    String? token = await messaging.getToken(vapidKey: "BNLJZI9tb9XnrgVUWog2-ymw5uFWjqSkXuL79skn0oE2nKo7M7MpaZ3hq-en-NNtBmEyqDmr5ACVoWCEwv7-6ug");
    print('firebase messaging token : $token');

    Common.firebaseMessagingToken = token;
  }

  Future<void> requestPermissionFirebaseMessaging() async {

    //Need permissions to web and ios

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }
    else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    }
    else {
      print('User declined or has not accepted permission');
    }
  }

  _showDialog(BuildContext context , RemoteMessage message) {

    //PlatformDetector.isAndroid ?  message.data['title'] : message.notification!.title
    //PlatformDetector.isAndroid ? message.data['body'] : message.notification!.body

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16
          ),
          padding: EdgeInsets.only(top: 32 , left: 16 , right: 16 , bottom: 12),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              SizedBox(height: 36,),
              //////////////////////// * Title * ////////////////////////
              AutoSizeText(
                  PlatformDetector.isAndroid ?  message.data['title'] : message.notification!.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Theme.of(context).primaryColor),
                  minFontSize: 12,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis
              ),
              SizedBox(height: 12),


              //////////////////////// * Subtitle * ////////////////////////
              AutoSizeText(
                  PlatformDetector.isAndroid ? message.data['body'] : message.notification!.body,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(),
                  minFontSize: 12,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis
              ),
              SizedBox(height: 12,),


              //////////////////////// * Star icon * ////////////////////////
              Center(
                child: Icon(Icons.star , size: 50, color: Colors.yellowAccent,),
              ),
              SizedBox(height: 36,),


              //////////////////////// * Button Cancel * ////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.translate('global_ok'),
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
        Positioned(
            top: -28,
            child: CircleAvatar(
              minRadius: 16,
              maxRadius: 28,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.attach_money,
                size: 28,
                color: Colors.white,
              ),
            )
        )

      ],
    );

  }

}






class AnimatedSearch extends StatefulWidget {

  ValueChanged<String>? onSearch;

  AnimatedSearch(this.onSearch);

  @override
  _AnimatedSearchState createState() => _AnimatedSearchState(onSearch);
}

class _AnimatedSearchState extends State<AnimatedSearch> with SingleTickerProviderStateMixin {

  late AnimationController _con;
  late TextEditingController _textEditingController;
  ValueChanged<String>? onSearch;
  bool isSpeechClicked = false;

  _AnimatedSearchState(this.onSearch);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 375),
    );

    _textEditingController= TextEditingController();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _con.dispose();
    _textEditingController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12 , vertical: 8),
      child: BlocProvider<AnimatedSearchBloc>(
        create: (context) => AnimatedSearchBloc(),
        child: BlocBuilder<AnimatedSearchBloc,AnimatedSearchState>(
          buildWhen: (oldState,newState) => oldState != newState,
          builder: (context,stateSearch){

            return Container(
              height: 48,  //Was 100
              width: 445,  //Was 250
              alignment: Alignment(-1.0, 0.0),

              child: MouseRegion(
                onEnter: (v) => context.read<AnimatedSearchBloc>().updateHover(true),
                onExit: (v) => context.read<AnimatedSearchBloc>().updateHover(false),


                //////////////////////// * Shadow Region * ////////////////////////
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 375),
                  height: 48.0,
                  width: 445.0,   //!stateSearch.toggle ? 48.0 : 445.0
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: stateSearch.hover ? Theme.of(context).primaryColor : Colors.yellowAccent,
                        spreadRadius: -10.0,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 6.0),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [

                      //////////////////////// * Microphone Button * ////////////////////////
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 375),
                        top: 6.0,
                        right: 7.0,
                        curve: Curves.easeOut,

                        child: AnimatedOpacity(
                          opacity: 1,  //!stateSearch.toggle ? 0.0 : 1.0
                          duration: Duration(milliseconds: 200),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,  //Color(0xffF2F3F7)
                              borderRadius: BorderRadius.circular(30.0),
                            ),

                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () async {

                                  print('status of clicked : ${isSpeechClicked}');

                                  //Start record voice to search
                                  print('init speech object');
                                  SpeechToText speech = SpeechToText();
                                  bool available = await speech.initialize( onStatus: _statusListener, onError: _errorListener );
                                  print('finish init speech object');



                                  //Check available
                                  if ( available ){
                                    print('it is available');

                                    //Speech detect is on (if is not clicked before)
                                    if(!isSpeechClicked){
                                      print('it is not clicked before');

                                      //Listen to user
                                      await speech.listen(
                                          onResult: (SpeechRecognitionResult result){
                                            _textEditingController.text = result.recognizedWords;
                                          });


                                      //Change status of microphone button
                                      isSpeechClicked = true;
                                      soundEffect('sounds/open_microphone.mp3');
                                      // context.read<AnimatedSearchBloc>().updateToggle(true);

                                    }
                                    //Speech detect is off
                                    else {
                                      print('it is clicked before');

                                      //Stop recording and search
                                      speech.stop();
                                      speech.cancel();

                                      if(_textEditingController.text.isNotEmpty)
                                        onSearch!.call(_textEditingController.text);


                                      //Change status of microphone button
                                      isSpeechClicked = false;
                                      soundEffect('sounds/close_microphone.mp3');
                                      // context.read<AnimatedSearchBloc>().updateToggle(false);
                                    }


                                  }
                                  else {
                                    print("The user has denied the use of speech recognition.");
                                  }

                                },
                                child: AnimatedBuilder(
                                  child: Icon(
                                    Icons.mic,
                                    size: 20.0,
                                    color: Theme.of(context).primaryColor,  //!stateSearch.toggle ?  Theme.of(context).textTheme.bodyText1!.color : Theme.of(context).primaryColor
                                  ),
                                  builder: (context, widget) {
                                    return Transform.rotate(
                                      angle: _con.value * 2.0 * pi,
                                      child: widget,
                                    );
                                  },
                                  animation: _con,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      //////////////////////// * TextField * ////////////////////////
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 375),
                        top: 2,  //11
                        bottom: 1,
                        left: 50.0,  //40
                        curve: Curves.easeOut,

                        child: AnimatedOpacity(
                          opacity: 1.0,
                          duration: Duration(milliseconds: 200),
                          child: Container(
                            height: 44.0,  //25
                            width: 350.0,  //180
                            color: Theme.of(context).cardColor,
                            child: RawKeyboardListener(
                              focusNode: FocusNode(),
                              onKey: (event){

                                if(_textEditingController.text.isNotEmpty){

                                  print('textfield is not empty !');
                                  if(event.isKeyPressed(LogicalKeyboardKey.enter)){


                                    //Search new Items
                                    print('Search here about 1 :' + _textEditingController.text);
                                    onSearch!.call(_textEditingController.text);

                                    // _listener.search(_textEditingController.text);

                                  }
                                  else if (event.runtimeType == RawKeyDownEvent  &&
                                      (event.logicalKey.keyId == 4295426088)){

                                    //or here
                                    print('Search here about 2 :' + _textEditingController.text);
                                    print(event.data.logicalKey.keyId);

                                    onSearch!.call(_textEditingController.text);
                                  }
                                }
                              },
                              child: TextFormField(
                                onFieldSubmitted: (value){
                                  print('Search here about 3 :' + value);
                                  onSearch!.call(value);
                                },
                                enableSuggestions: true,
                                readOnly: false,
                                textInputAction: TextInputAction.search,
                                // textAlign: AppLocalizations.of(context)!.isEnLocale
                                //     ? TextAlign.start
                                //     : TextAlign.end,
                                // textDirection: AppLocalizations.of(context)!.isEnLocale
                                //     ? TextDirection.ltr
                                //     : TextDirection.rtl,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                controller: _textEditingController,
                                cursorRadius: Radius.circular(10.0),
                                cursorWidth: 2.0,
                                cursorColor: Theme.of(context).primaryColor,
                                autofocus: false,
                                autocorrect: true,
                                style: Theme.of(context).textTheme.bodyText2,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  hintText: AppLocalizations.of(context)!.translate('food_search'),  //'Search...'
                                  // labelStyle: TextStyle(
                                  //   color: Color(0xff5B5B5B),
                                  //   fontSize: 17.0,
                                  //   fontWeight: FontWeight.w500,
                                  // ),
                                  // alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      //////////////////////// * Search Button * ////////////////////////
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 375),
                        top: 3.5,
                        left: 4.1,
                        curve: Curves.easeOut,
                        child: FocusableActionDetector(
                          mouseCursor : SystemMouseCursors.click,
                          child: Material(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(30.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30.0),
                              child: IconButton(
                                splashRadius: 19.0,
                                icon: Icon(
                                  Icons.search_outlined,
                                  size: 20,  //height: 18.0,
                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                ),
                                onPressed: () {

                                  if (stateSearch.toggle == false) {

                                    //Search
                                    if(_textEditingController.text.isNotEmpty)
                                      onSearch!.call(_textEditingController.text);


                                    // context.read<AnimatedSearchBloc>().updateToggle(true);
                                    _con.forward();

                                  }
                                  else {

                                    //Search
                                    if(_textEditingController.text.isNotEmpty)
                                      onSearch!.call(_textEditingController.text);

                                    // context.read<AnimatedSearchBloc>().updateToggle(false);
                                    _textEditingController.clear();
                                    _con.reverse();

                                  }

                                },
                              ),
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
        ),
      ),
    );
  }


  void _errorListener(SpeechRecognitionError errorNotification) {
    print('some error happened !!!');
    print('${errorNotification.errorMsg}');
  }

  void _statusListener(String status) {
    print('listen to status : $status}');
  }



  void soundEffect(String nameSong) {

    if(PlatformDetector.isWindows || PlatformDetector.isLinux){
      audioDesktop.AudioPlayer audioPlayer = new audioDesktop.AudioPlayer(id: Random().nextInt(10000));
      audioDesktop.AudioSource.fromAsset(nameSong).then((value) async{
        await audioPlayer.load(value);
        audioPlayer.play();
      });
    }

    else{
      just_audio.AudioPlayer player = just_audio.AudioPlayer();
      player.setAsset(nameSong).then((value) => player.play());
    }

  }


}