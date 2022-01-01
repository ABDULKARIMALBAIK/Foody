import 'dart:convert';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foody/bloc/blocUnit/AnimatedButtonBloc.dart';
import 'package:foody/bloc/blocUnit/Cart/CartTotalBloc.dart';
import 'package:foody/bloc/blocUnit/FoodDetail/FoodDetailPriceBloc.dart';
import 'package:foody/bloc/state/AnimatedButtonState.dart';
import 'package:foody/bloc/state/Cart/CartTotalState.dart';
import 'package:foody/bloc/state/FoodDetail/FoodDetailPriceState.dart';
import 'package:foody/constant/Common.dart';
import 'package:foody/constant/Util.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/model/modelApp/CheckoutPassModel.dart';
import 'package:foody/model/modelFake/Spice.dart';
import 'package:foody/moor/databaseMoor/FoodyDatabase.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/viewModel/CartViewModel.dart';
import 'package:foody/widget/CrossAnimationButton.dart';
import 'package:foody/widget/DataTemplate/DataTamplete.dart';
import 'package:foody/widget/DrawerApp.dart';
import 'package:foody/widget/FoodyNavigationRail.dart';
import 'package:foody/widget/SnakBarBuilder.dart';
import 'package:hive/hive.dart';
import 'package:octo_image/octo_image.dart';
import 'package:velocity_x/velocity_x.dart';

class CartAndroidMobilePortrait extends StatelessWidget {

  //Init options of liveList
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

  //Scroll Controller
  ScrollController scrollController = ScrollController();

  //Init ViewModel
  CartViewModel _viewModel = CartViewModel();

  //Load food cart
  late Future<List<FoodTable>> foodsCart;

  //Some data
  bool isFirstTimeFoods = true;

  //Init List of carts
  List<FoodTable> carts = [];

  //Scaffold Key
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  //Create a bloc to undo / redo , totalPrice , globals
  AnimatedButtonBloc _blocUndoRedo = AnimatedButtonBloc();
  CartTotalBloc blocTotalPrice = CartTotalBloc();
  late BuildContext globalContextTotalPriceBloc;
  late CartTotalState globalStateTotalPriceBloc;
  late GlobalKey<ScaffoldState> _scaffoldKey;


  CartAndroidMobilePortrait(){
    String currentUser = FirebaseAuth.instance.currentUser!.uid;
    foodsCart = _viewModel.allFoods(currentUser);
  }


  @override
  Widget build(BuildContext context) {

    _scaffoldKey =  GlobalKey<ScaffoldState>();

    print('start widget tree');

    //Init Hive
    var box = Hive.box('foody');
    var darkMode = box.get('darkMode', defaultValue: false);
    var arabicMode = box.get('arabicMode', defaultValue: false);


    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // drawer: DrawerApp(1 , context , _scaffoldState , true),
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).cardColor,
      //   centerTitle: true,
      //   title: AutoSizeText(
      //       AppLocalizations.of(context)!.translate('cart_title'),
      //       style: Theme.of(context).textTheme.headline4!.copyWith(),
      //       minFontSize: 18,
      //       maxLines: 2,
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
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height ,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [

              //////////////////////// * carts * ////////////////////////
              Expanded(
                flex: 1,
                child:  FutureBuilder<bool>(
                  future: Util.checkInternet(),
                  builder: (contextInternet,snapshotInternet){

                    print('finish checking , check values');

                    //There is an error
                    if (snapshotInternet.hasError) {
                      print('there is a problem !!!   ${snapshotInternet.hasError.toString()}    ${snapshotInternet.error.toString()}');
                      return DataTemplate.error(context);
                    }

                    ////No Data
                    if (!snapshotInternet.hasData) {
                      if (snapshotInternet.connectionState == ConnectionState.done)
                        return DataTemplate.noData(context);
                    }

                    //Load data
                    if (snapshotInternet.connectionState == ConnectionState.waiting){
                      print('load category Data');
                      return DataTemplate.load(context);
                    }

                    //Check internet
                    //No internet
                    if (!snapshotInternet.data!){
                      print('No Internet !!!');
                      return DataTemplate.noInternet(context);
                    }
                    //has internet
                    else {
                      print('every thing is working , let start');
                      return Container(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2 , vertical: 8),
                            child: FutureBuilder<List<FoodTable>>(
                                future: foodsCart,
                                builder: (contextFoodCarts , AsyncSnapshot<List<FoodTable>> snapshotFoodCarts){

                                  print('Get data from moor');


                                  //There is an error
                                  if (snapshotFoodCarts.hasError) {
                                    print('there is a problem !!!   ${snapshotFoodCarts.hasError.toString()}    ${snapshotFoodCarts.error.toString()}');
                                    return DataTemplate.error(context);
                                  }

                                  ////No Data
                                  if (!snapshotFoodCarts.hasData) {
                                    if (snapshotFoodCarts.connectionState == ConnectionState.done)
                                      return DataTemplate.noData(context);
                                  }

                                  //Load data
                                  if (snapshotFoodCarts.connectionState == ConnectionState.waiting){
                                    print('load category Data');
                                    return DataTemplate.load(context);
                                  }

                                  //No Internet
                                  if (snapshotFoodCarts.connectionState == ConnectionState.none){
                                    print('No Internet !!!');
                                    return DataTemplate.noInternet(context);
                                  }

                                  //snapshot.connectionState == ConnectionState.active or snapshot.connectionState == ConnectionState.done (has data)
                                  //Init data foods
                                  if(isFirstTimeFoods){
                                    print('pass it firstTime');
                                    print('length of data is ${snapshotFoodCarts.data!.length}');
                                    carts.clear();
                                    carts = [];
                                    carts = snapshotFoodCarts.data!;
                                    isFirstTimeFoods = false;
                                  }


                                  //Print size of carts
                                  print('size of carts  is ${carts.length}');


                                  return Container(
                                    child: BlocProvider<CartTotalBloc>.value(
                                      value: blocTotalPrice,
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height - 16,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            //////////////////////// * List of Foods * ////////////////////////
                                            Expanded(
                                              child: CustomScrollView(
                                                controller: scrollController,
                                                scrollDirection: Axis.vertical,
                                                slivers: [
                                                  SliverList(

                                                      delegate: SliverChildListDelegate([

                                                        //////////////////////// * Title * ////////////////////////
                                                        // Padding(
                                                        //   padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 16),
                                                        //   child: Row(
                                                        //     mainAxisSize: MainAxisSize.max,
                                                        //     children: [
                                                        //       Flexible(
                                                        //         child: AutoSizeText(
                                                        //             AppLocalizations.of(context)!
                                                        //                 .translate('cart_title'),
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
                                                        //     mainAxisSize: MainAxisSize.max,
                                                        //     children: [
                                                        //       Flexible(
                                                        //         child: AutoSizeText(
                                                        //             AppLocalizations.of(context)!
                                                        //                 .translate('cart_subtitle'),
                                                        //             style: Theme.of(context)
                                                        //                 .textTheme
                                                        //                 .headline6!
                                                        //                 .copyWith( color: Theme.of(context).dividerColor),
                                                        //             minFontSize: 12,
                                                        //             maxLines: 4,
                                                        //             overflow: TextOverflow.ellipsis
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                        // SizedBox(
                                                        //   height: 18,
                                                        // ),




                                                        //////////////////////// * List of items of carts * ////////////////////////
                                                        BlocProvider<AnimatedButtonBloc>.value(
                                                          value: _blocUndoRedo,
                                                          child: BlocBuilder<AnimatedButtonBloc,AnimatedButtonState>(
                                                              buildWhen: (oldState,newState) => oldState != newState,
                                                              builder: (context,state){
                                                                return LiveList.options(
                                                                  // And attach root sliver scrollController to widgets
                                                                  scrollDirection: Axis.vertical,
                                                                  controller: scrollController,
                                                                  options: options,
                                                                  shrinkWrap: true,
                                                                  itemCount: carts.length,
                                                                  itemBuilder: (context, index , animate) =>  buildCartItem(context, carts[index] , index , animate),
                                                                );
                                                              }
                                                          ),
                                                        ),

                                                      ])
                                                  )
                                                ],
                                              ),
                                            ),

                                            //////////////////////// * Showing counts  * ////////////////////////
                                            Padding(
                                              padding: const EdgeInsets.all(0.0),
                                              child: BlocBuilder<CartTotalBloc,CartTotalState>(
                                                buildWhen: (oldState,newState) => oldState != newState,
                                                builder: (contextTotal,stateTotal){

                                                  globalContextTotalPriceBloc = contextTotal;
                                                  globalStateTotalPriceBloc = stateTotal;


                                                  return Card(
                                                    color: Theme.of(context).cardColor,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child: Column(
                                                        children: [
                                                          //////////////////////// * Total  * ////////////////////////
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              AutoSizeText(
                                                                  AppLocalizations.of(context)!
                                                                      .translate('cart_total'),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(),
                                                                  minFontSize: 10,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis
                                                              ),
                                                              Row(
                                                                children: [

                                                                  arabicMode ?
                                                                  Text(
                                                                    stateTotal.totalPrice.toString(),
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(),
                                                                  )
                                                                      :
                                                                  AnimatedFlipCounter(
                                                                    value: stateTotal.totalPrice,
                                                                    duration: Duration(milliseconds: 300),
                                                                    fractionDigits: 2,
                                                                    curve: Curves.bounceOut,
                                                                    textStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(),
                                                                  ),

                                                                  SizedBox(width: 3,),
                                                                  Text('\$' , style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith()
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(thickness: 1, color: Theme.of(context).dividerColor,),


                                                          //////////////////////// * Deliver Charge  * ////////////////////////
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              AutoSizeText(
                                                                  AppLocalizations.of(context)!
                                                                      .translate('cart_deliver_charge'),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyText2!
                                                                      .copyWith(),
                                                                  minFontSize: 10,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis
                                                              ),
                                                              Row(
                                                                children: [

                                                                  arabicMode ?
                                                                  Text(
                                                                    stateTotal.deliverCharge.toString(),
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyText2!
                                                                        .copyWith(),
                                                                  )
                                                                      :
                                                                  AnimatedFlipCounter(
                                                                    value: stateTotal.deliverCharge,
                                                                    duration: Duration(milliseconds: 300),
                                                                    fractionDigits: 2,
                                                                    curve: Curves.bounceOut,
                                                                    textStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyText2!
                                                                        .copyWith(),
                                                                  ),


                                                                  SizedBox(width: 3,),
                                                                  Text('\$' , style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyText2!
                                                                      .copyWith()
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(thickness: 1,),


                                                          //////////////////////// * Total Summation * ////////////////////////
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              AutoSizeText(
                                                                  AppLocalizations.of(context)!
                                                                      .translate('cart_total_summation'),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .headline6!
                                                                      .copyWith(color: Theme.of(context).primaryColor),
                                                                  minFontSize: 10,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis
                                                              ),
                                                              Row(
                                                                children: [

                                                                  arabicMode ?
                                                                  Text(
                                                                    stateTotal.totalSummation.toString(),
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .headline6!
                                                                        .copyWith(color: Theme.of(context).primaryColor),
                                                                  )
                                                                      :
                                                                  AnimatedFlipCounter(
                                                                    value: stateTotal.totalSummation,
                                                                    duration: Duration(milliseconds: 300),
                                                                    fractionDigits: 2,
                                                                    curve: Curves.bounceOut,
                                                                    textStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .headline6!
                                                                        .copyWith(color: Theme.of(context).primaryColor),
                                                                  ),


                                                                  SizedBox(width: 3,),
                                                                  Text('\$' , style: Theme.of(context)
                                                                      .textTheme
                                                                      .headline6!
                                                                      .copyWith(color: Theme.of(context).primaryColor)
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5,),


                                                          ///////////////// * Checkout button *///////////////
                                                          Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(12.0),
                                                                child: CrossAnimationButton(40 , 210, 1.2, Curves.easeInOut, 400, Theme.of(context).textTheme.headline4!.color, Theme.of(context).textTheme.headline4!.color, Theme.of(context).cardColor, Theme.of(context).textTheme.headline4!.color, Theme.of(context).textTheme.headline4!.color, Theme.of(context).cardColor, AppLocalizations.of(context)!.translate('cart_submit_button') ,
                                                                        (){
                                                                      print('pass to checkout page !');

                                                                      //Init Sizes to checkout !
                                                                      String sizes = '';
                                                                      carts.forEach((cart) {
                                                                        if(cart.size == 1)
                                                                          if(!sizes.contains('S'))
                                                                            sizes += 'S /';

                                                                        if(cart.size == 2)
                                                                          if(!sizes.contains('M'))
                                                                            sizes += ' M /';

                                                                        if(cart.size == 3)
                                                                          if(!sizes.contains('L'))
                                                                            sizes += ' L ';
                                                                      });


                                                                      print('start navigate');
                                                                      CheckoutPassModel passData = CheckoutPassModel(carts, carts.length, globalStateTotalPriceBloc.totalSummation, sizes);
                                                                      print('data is length : ${passData.carts.length}');


                                                                      //Navigate ot checkout
                                                                      if(carts.length <= 0){
                                                                        SnakBarBuilder.buildAwesomeSnackBar(
                                                                            context,
                                                                            AppLocalizations.of(context)!.translate('cart_snackBar_no_carts'),
                                                                            Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                                                            AwesomeSnackBarType.info);
                                                                      }
                                                                      else {
                                                                        VxNavigator.of(context).push(
                                                                            Uri(path: Routers.checkoutRoute , queryParameters: {"total_quantity":carts.length.toString()}) ,
                                                                            params: passData);
                                                                      }


                                                                    }),
                                                              )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            )
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  buildCartItem(BuildContext contextt, FoodTable cart, int index, Animation<double> animation) {


    //Refresh of totals
    double totalPrice = (carts != null && carts.length > 0) ?
    double.parse(carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element).toStringAsFixed(2)) : 0.0;

    double deliverCharge = (carts != null && carts.length > 0) ?
    double.parse((carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)* 0.1).toStringAsFixed(2)) : 0.0;

    double totalSummation = (carts != null && carts.length > 0) ?
    double.parse(((carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)) + carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)* 0.1).toStringAsFixed(2))
        : 0.0;

    globalContextTotalPriceBloc.read<CartTotalBloc>().change(totalPrice, deliverCharge, totalSummation);

    return Padding(
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
                  builder: (contextCart,stateCart){

                    return MouseRegion(
                      onExit: (event) => contextCart.read<AnimatedButtonBloc>().update(false),
                      onEnter: (event) => contextCart.read<AnimatedButtonBloc>().update(true),
                      cursor: SystemMouseCursors.click,

                      child: Slidable(
                        key: Key(cart.id.toString()),
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: [
                          IconSlideAction(
                            caption: AppLocalizations.of(contextt)!.translate('cart_delete'),
                            icon: Icons.delete,
                            color: Colors.red,
                            onTap: () {

                              //Remove from cart
                              carts.removeAt(index);
                              //item deleted , show the changes
                              contextt.read<AnimatedButtonBloc>().update(true);

                              //Delete from database
                              _viewModel.deleteFood(int.parse(cart.foodId)).then((value){
                                _scaffoldKey.currentState!.showSnackBar(SnakBarBuilder.build(
                                    contextt,
                                    SelectableText(
                                      AppLocalizations.of(contextt)!.translate('cart_snackBar_deleteCart'),
                                      cursorColor: Theme.of(contextt).primaryColor,
                                      style: Theme.of(contextt).textTheme.bodyText1!.copyWith(color: Colors.white),
                                    ),
                                    AppLocalizations.of(contextt)!.translate('global_undo'),
                                        () {
                                      //Insert into cart
                                      carts.insert(index, cart);
                                      //item inserted , show the changes
                                      contextt.read<AnimatedButtonBloc>().update(false);  //Item return

                                      //insert into database
                                      _viewModel.insertFood(cart.userId, cart.foodId, cart.blurhashImg, cart.category_id, cart.code, cart.description, cart.hasDiscount, cart.img, cart.isSale, cart.name, cart.newPrice, cart.oldPrice, cart.star,cart. quantity, cart.size, cart.spices);
                                      String currentUser = FirebaseAuth.instance.currentUser!.uid;
                                      foodsCart = _viewModel.allFoods(currentUser);


                                      //Refresh of totals
                                      double totalPrice = (carts != null && carts.length > 0) ?
                                      double.parse(carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element).toStringAsFixed(2)) : 0.0;

                                      double deliverCharge = (carts != null && carts.length > 0) ?
                                      double.parse((carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)* 0.1).toStringAsFixed(2)) : 0.0;

                                      double totalSummation = (carts != null && carts.length > 0) ?
                                      double.parse(((carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)) + carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)* 0.1).toStringAsFixed(2))
                                          : 0.0;

                                      globalContextTotalPriceBloc.read<CartTotalBloc>().change(totalPrice, deliverCharge, totalSummation);

                                    })
                                );
                              });

                              //Refresh the data
                              String currentUser = FirebaseAuth.instance.currentUser!.uid;
                              foodsCart = _viewModel.allFoods(currentUser);



                              //Refresh of totals
                              double totalPrice = (carts != null && carts.length > 0) ?
                              double.parse(carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element).toStringAsFixed(2)) : 0.0;

                              double deliverCharge = (carts != null && carts.length > 0) ?
                              double.parse((carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)* 0.1).toStringAsFixed(2)) : 0.0;

                              double totalSummation = (carts != null && carts.length > 0) ?
                              double.parse(((carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)) + carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)* 0.1).toStringAsFixed(2))
                                  : 0.0;

                              globalContextTotalPriceBloc.read<CartTotalBloc>().change(totalPrice, deliverCharge, totalSummation);


                            },
                          )
                        ],
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: stateCart.touched ? Theme.of(contextCart).primaryColor : Colors.black54,
                                  offset: stateCart.touched ? Offset(0.0, 3.0) : Offset(1.0, 6.0),
                                  blurRadius: stateCart.touched ? 4 : 10,
                                  spreadRadius: 2.0,
                                )
                              ]
                          ),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              decoration: BoxDecoration(
                                  color: Theme.of(contextCart).cardColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: stateCart.touched ? Theme.of(contextCart).accentColor : Color(0xAD1C1C1C),
                                      offset: Offset(0.0, 5.0),
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ]
                              ),
                              child: Material(
                                borderRadius: BorderRadius.circular(6),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(4)),
                                          child: OctoImage(
                                            // height: 220,
                                            image: CachedNetworkImageProvider(
                                                cart.img),
                                            // placeholderBuilder: OctoPlaceholder.blurHash(
                                            //   cart.blurhashImg,
                                            // ),
                                            color: Colors.black26,
                                            errorBuilder: OctoError.icon(color: Colors.red),
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high,
                                            fadeInCurve: Curves.easeIn,
                                            fadeOutCurve: Curves.easeOut,
                                            fadeInDuration: Duration(milliseconds: 300),
                                            fadeOutDuration: Duration(milliseconds: 300),
                                            placeholderFadeInDuration: Duration(milliseconds: 300),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: 8),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              //////////////////// * Food Name * //////////////////////
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8, right: 8),
                                                child: AutoSizeText(
                                                    cart.name,
                                                    style: Theme.of(contextt)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontWeight: FontWeight.bold),
                                                    minFontSize: 10,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis
                                                ),
                                              ),


                                              //////////////////// * Food Price * ////////////////////
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 8, right: 8, top: 8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.monetization_on,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 8),
                                                      child: AutoSizeText(
                                                          cart.newPrice,
                                                          style: Theme.of(contextt)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(fontWeight: FontWeight.bold),
                                                          minFontSize: 10,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              //////////////////// * Food Size * ////////////////////
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(left: 8),
                                                      child: AutoSizeText(
                                                          AppLocalizations.of(contextt)!.translate('foodDetail_size') + ' ' + getSize(cart.size),
                                                          style: Theme.of(contextt)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(fontWeight: FontWeight.bold),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),


                                              //////////////////// * Food Spices * ////////////////////
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                                                child: Wrap(
                                                    children: getSpices(contextt, cart)
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      //////////////////// * NumberPick * ////////////////////
                                      BlocProvider<FoodDetailPriceBloc>(
                                        create: (context) => FoodDetailPriceBloc(double.parse(cart.quantity.toString())),
                                        child: BlocBuilder<FoodDetailPriceBloc,FoodDetailPriceState>(
                                          buildWhen: (oldState,newState) => oldState != newState,
                                          builder: (contextCounter , stateCounter){
                                            return Center(
                                              child: ElegantNumberButton(
                                                initialValue: int.parse(stateCounter.price.toString()),
                                                minValue: 1,
                                                maxValue: 200,
                                                buttonSizeHeight: 20,
                                                buttonSizeWidth: 35,
                                                color: Theme.of(contextt).cardColor,
                                                decimalPlaces: 0,
                                                onChanged: (value) async {

                                                  int quantityIncrement = value as int;
                                                  print('value after $quantityIncrement');

                                                  contextCounter.read<FoodDetailPriceBloc>().change(double.parse(quantityIncrement.toString()));

                                                  //Change quantity of cart
                                                  carts[index].quantity = quantityIncrement;
                                                  print('print  pass it ');

                                                  //insert into database
                                                  _viewModel.changeQuantity(cart.id,cart.userId, cart.foodId, cart.blurhashImg, cart.category_id, cart.code, cart.description, cart.hasDiscount, cart.img, cart.isSale, cart.name, cart.newPrice, cart.oldPrice, cart.star, quantityIncrement, cart.size, cart.spices);
                                                  String currentUser = FirebaseAuth.instance.currentUser!.uid;
                                                  foodsCart = _viewModel.allFoods(currentUser);


                                                  //Refresh of totals
                                                  double totalPrice = (carts != null && carts.length > 0) ?
                                                  double.parse(carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element).toStringAsFixed(2)) : 0.0;

                                                  double deliverCharge = (carts != null && carts.length > 0) ?
                                                  double.parse((carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)* 0.1).toStringAsFixed(2)) : 0.0;

                                                  double totalSummation = (carts != null && carts.length > 0) ?
                                                  double.parse(((carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)) + carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)* 0.1).toStringAsFixed(2))
                                                      : 0.0;

                                                  globalContextTotalPriceBloc.read<CartTotalBloc>().change(totalPrice, deliverCharge, totalSummation);

                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
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
    );

  }

  String getSize(int size) {
    switch(size){
      case 1:{
        return 'Small';
      }
      case 2:{
        return 'Medium';
      }
      case 3:{
        return 'Large';
      }
      default:{
        return 'Small';
      }
    }
  }

  List<Widget> getSpices(BuildContext contextt , FoodTable cart) {

    //Add first widget
    List<Widget> spicesWidgets = [];

    //Get data and convert it to list
    var data = jsonDecode(cart.spices) as List<dynamic>;
    List<Spice> listSpices = data.map((model) => Spice.fromJson(model)).toList();

    //Spices word
    spicesWidgets.add(
      AutoSizeText(
          AppLocalizations.of(contextt)!.translate('checkout_spices'),
          style: Theme.of(contextt)
              .textTheme
              .bodyText2!
              .copyWith(fontWeight: FontWeight.bold),
          minFontSize: 8,
          maxLines: 3,
          overflow: TextOverflow.ellipsis
      ),
    );


    //create a list of widgets
    listSpices.forEach((spice) {
      spicesWidgets.add(
        AutoSizeText(
            spice.name + ' ' + spice.price.toString() + '\$' + ' , ',
            style: Theme.of(contextt)
                .textTheme
                .bodyText2!
                .copyWith(),
            minFontSize: 8,
            maxLines: 3,
            overflow: TextOverflow.ellipsis
        ),
      );
    });

    return spicesWidgets;
  }

}