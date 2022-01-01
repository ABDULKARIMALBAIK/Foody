import 'dart:convert';
import 'dart:math';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_desktop/flutter_audio_desktop.dart' as audioDesktop;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foody/bloc/blocUnit/FoodDetail/FoodDetailCheckBoxBloc.dart';
import 'package:foody/bloc/blocUnit/FoodDetail/FoodDetailCheckRadioBloc.dart';
import 'package:foody/bloc/blocUnit/FoodDetail/FoodDetailPriceBloc.dart';
import 'package:foody/bloc/state/FoodDetail/FoodDetailCheckBoxState.dart';
import 'package:foody/bloc/state/FoodDetail/FoodDetailCheckRadioState.dart';
import 'package:foody/bloc/state/FoodDetail/FoodDetailPriceState.dart';
import 'package:foody/constant/Common.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/model/modelFake/Spice.dart';
import 'package:foody/model/modelNetwork/Comment.dart';
import 'package:foody/model/modelNetwork/Food.dart';
import 'package:foody/style/platformDetect/PlatformDetector.dart';
import 'package:foody/viewModel/FoodDetailViewModel.dart';
import 'package:foody/widget/AnimationIcon.dart';
import 'package:foody/widget/DataTemplate/DataTamplete.dart';
import 'package:foody/widget/SnakBarBuilder.dart';
import 'package:hive/hive.dart';
import 'package:octo_image/octo_image.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';


class FoodDetailWebTablet extends StatelessWidget{


  //Init options of liveList
  late LiveOptions options;

  //Init Data
  Food food;
  late ScrollController scrollController;
  int groupSizeRadio = 1;

  //Radio Size Bloc
  FoodDetailCheckRadioBloc _blocCheckRadio = FoodDetailCheckRadioBloc();

  //Init ViewModel
  late FoodDetailViewModel _viewModel;

  //Lists
  List<Spice> spices = [];
  List<Widget> checkSpices = [];
  List<Comment> comments = [];
  List<FoodDetailCheckBoxBloc> _listCheckBoxBlocs = [];


  //Blocs
  late FoodDetailPriceBloc _priceBloc;
  late BuildContext globalContextPriceBloc;
  late FoodDetailPriceState globalStatePriceBloc;



  //Vars
  late Stream<QuerySnapshot> ratingComments;
  bool isFirstTimeComment = true;
  int sizeSelected = 1;
  double currentPrice = 0;
  double _ratingCommentValue = 0.0;


  //Controllers
  late TextEditingController _controllerComment;
  late ConfettiController confettiController;


  //Key
  late GlobalKey<ScaffoldState> _scaffoldState;



  FoodDetailWebTablet(this.food){

    options = LiveOptions(
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
    _controllerComment = TextEditingController();
    confettiController = ConfettiController(duration: Duration(seconds: 2));
    scrollController = ScrollController();

    //init _viewModel
    _viewModel = FoodDetailViewModel();


    //rating value
    _ratingCommentValue = double.parse(food.star);


    //load comments list
    ratingComments = _viewModel.ratingCommentsFood(food.foodId);


    //load spices of food
    spices = _viewModel.getSpices();
    for(var i = 0; i < spices.length ; i++)
      _listCheckBoxBlocs.add(FoodDetailCheckBoxBloc());


    //Other init
    _priceBloc = FoodDetailPriceBloc(double.parse(food.newPrice));
    currentPrice = double.parse(food.newPrice);
  }




  @override
  Widget build(BuildContext context) {


    //set value of counter
    if(Common.badgeCartCounter > 0){
      SystemChrome.setApplicationSwitcherDescription(
          ApplicationSwitcherDescription(
            label: 'Foody  +' + Common.badgeCartCounter.toString(),
          )
      );
    }


    _buildSpices(context);
    _scaffoldState = GlobalKey<ScaffoldState>();


    //Init Hive
    var box = Hive.box('foody');
    var darkMode = box.get('darkMode', defaultValue: false);
    var arabicMode = box.get('arabicMode', defaultValue: false);




    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: _scaffoldState,
      body: SafeArea(
        child: BlocProvider<FoodDetailPriceBloc>.value(
          value: _priceBloc,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Expanded(
                        child: CustomScrollView(
                            controller: scrollController,
                            scrollDirection: Axis.vertical,
                            slivers: [
                              SliverList(
                                delegate: SliverChildListDelegate([

                                  //////////////////////// * Image food , Cart Button * ////////////////////////
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 450,
                                    child: Stack(
                                      children: [

                                        //////////////////////// * Image * ////////////////////////
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 450,
                                          child: ClipPath(
                                            clipper: ImageFoodClipper(),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 450,
                                              child: OctoImage(
                                                height: 450,
                                                width: MediaQuery.of(context).size.width,
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
                                            ),
                                          ),
                                        ),

                                        //////////////////////// * Cart Button * ////////////////////////
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Transform.translate(
                                            offset: Offset(0 , -50),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 70,
                                              child: Center(
                                                child: Link(
                                                  target: LinkTarget.self,
                                                  uri: Uri(path: '/add_to_cart'),
                                                  builder: (context , followLink){
                                                    return AnimationIcon(
                                                        Colors.white,
                                                        darkMode ? Colors.purpleAccent : Colors.purple,
                                                        Theme.of(context).accentColor.withOpacity(0.7),
                                                        darkMode ? Colors.purpleAccent : Colors.purple,
                                                        darkMode ? Colors.purpleAccent : Colors.purple,
                                                        Theme.of(context).cardColor,
                                                        Icons.shopping_cart_outlined,
                                                        Icons.shopping_cart_outlined,
                                                            (){

                                                          print('spices size is ${spices.length}');

                                                          int countSpicesSelected = 0;
                                                          spices.forEach((spice) {
                                                            if(spice.selected)
                                                              countSpicesSelected += 1;
                                                          });

                                                          if(countSpicesSelected <= 0){
                                                            print('no spices , this is problem , show snackBar');
                                                            SnakBarBuilder.buildAwesomeSnackBar(
                                                                context,
                                                                AppLocalizations.of(context)!.translate('foodDetail_snackBar_empty_spics'),
                                                                Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                                                AwesomeSnackBarType.info);
                                                          }
                                                          else {

                                                            print('has spices , complete the work');


                                                            //Play sound add to cart
                                                            if(PlatformDetector.isWindows || PlatformDetector.isLinux){
                                                              audioDesktop.AudioPlayer audioPlayer = new audioDesktop.AudioPlayer(id: Random().nextInt(10000));
                                                              audioDesktop.AudioSource.fromAsset('sounds/add_to_cart.mp3').then((value) async{
                                                                await audioPlayer.load(value);
                                                                audioPlayer.play();
                                                              });
                                                            }
                                                            else{
                                                              just_audio.AudioPlayer player = just_audio.AudioPlayer();
                                                              player.setAsset('sounds/add_to_cart.mp3').then((value) => player.play());
                                                            }





                                                            print('start check food');
                                                            //Check if an food is saved before if exists increment food's quantity or save new food
                                                            String currentUserId = FirebaseAuth.instance.currentUser!.uid;
                                                            print('userId is : $currentUserId');
                                                            print('food id is : ${food.foodId}');
                                                            print('food id is : ${food.img}');
                                                            print('food id is : ${food.blurhashImg}');


                                                            //Change badge counter
                                                            Common.badgeCartCounter += 1;
                                                            SystemChrome.setApplicationSwitcherDescription(
                                                                ApplicationSwitcherDescription(
                                                                    label: 'Foody  +' + Common.badgeCartCounter.toString(),
                                                                    primaryColor: Theme.of(context).primaryColor.value
                                                                )
                                                            );



                                                            _viewModel.getFoodByFoodId(currentUserId, food.foodId).then((foodCart) {
                                                              //Food Item has same size  , increment quantity
                                                              if (foodCart.size == sizeSelected){

                                                                print('sizeSelected is true');
                                                                //Just print
                                                                print('the food is repeated again');

                                                                //print data before
                                                                print('food, size is ${foodCart.size}  , quantity is ${foodCart.quantity}  ,  foodId is ${foodCart.foodId}  ,  name is ${foodCart.name } , spices is ${foodCart.spices}');

                                                                //Create bew Quantity object
                                                                print('quantity before: ${foodCart.quantity}');
                                                                int newQuantity = foodCart.quantity + 1;


                                                                //Get selected spices then convert it to json
                                                                List<Spice> selectedSpices = [];
                                                                for(var i = 0 ; i < spices.length ; i++){
                                                                  if(spices[i].selected){
                                                                    print('spices is ${spices[i].name} is selected');
                                                                    selectedSpices.add(spices[i]);
                                                                  }
                                                                }

                                                                var spicesJson = jsonEncode(selectedSpices.map((e) => e.toJson()).toList());
                                                                print('spices as json: $spicesJson');


                                                                print('total is  ${(double.parse(foodCart.newPrice) + double.parse(globalStatePriceBloc.price.toString())).toString()}');
                                                                _viewModel.updateFood(foodCart.id , foodCart.userId, foodCart.foodId, foodCart.blurhashImg, foodCart.category_id, foodCart.code, foodCart.description, foodCart.hasDiscount, foodCart.img, foodCart.isSale, foodCart.name, (double.parse(foodCart.newPrice) + double.parse(globalStatePriceBloc.price.toString())).toString() , foodCart.oldPrice, foodCart.star , newQuantity , foodCart.size , spicesJson);



                                                                //SnackBar
                                                                SnakBarBuilder.buildAwesomeSnackBar(
                                                                    context,
                                                                    AppLocalizations.of(context)!.translate('foodDetail_snackBar_addItem'),
                                                                    Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                                                    AwesomeSnackBarType.success);


                                                                //Play Confetti Effect
                                                                confettiController.play();
                                                                print('FINISH WORK !!!');


                                                                // _scaffoldState.currentState!.showSnackBar(SnakBarBuilder.build(
                                                                //     context,
                                                                //     SelectableText(
                                                                //       AppLocalizations.of(context)!.translate('foodDetail_snackBar_addItem'),
                                                                //       cursorColor: Theme.of(context).primaryColor,
                                                                //     ),
                                                                //     AppLocalizations.of(context)!.translate('global_ok'),
                                                                //         () {print('add to cart , increment quantity');}));


                                                              }
                                                              //Food Item has not same size  , create new one
                                                              else {

                                                                print('sizeSelected is false');
                                                                //print data before
                                                                print('food, size is $sizeSelected  , quantity is ${1}  ,  foodId is ${food.foodId}  ,  name is ${food.name} , spices is no thing');

                                                                //Get selected spices then convert it to json
                                                                List<Spice> selectedSpices = [];
                                                                for(var i = 0 ; i < spices.length ; i++){
                                                                  if(spices[i].selected){
                                                                    print('spices is ${spices[i].name} is selected');
                                                                    selectedSpices.add(spices[i]);
                                                                  }
                                                                }

                                                                var spicesJson = jsonEncode(selectedSpices.map((e) => e.toJson()).toList());
                                                                print('spices as json: $spicesJson');

                                                                _viewModel.insertFood(currentUserId, food.foodId, food.blurhashImg, food.category_id, food.code, food.description, food.hasDiscount, food.img, food.isSale, food.name,double.parse(globalStatePriceBloc.price.toString()).toString() , food.oldPrice, food.star , 1 , sizeSelected , spicesJson);

                                                                //Show SnackBar
                                                                SnakBarBuilder.buildAwesomeSnackBar(
                                                                    context,
                                                                    AppLocalizations.of(context)!.translate('foodDetail_snackBar_addItem'),
                                                                    Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                                                    AwesomeSnackBarType.success);


                                                                //Play Confetti Effect
                                                                confettiController.play();
                                                                print('FINISH WORK !!!');


                                                                // _scaffoldState.currentState!.showSnackBar(SnakBarBuilder.build(
                                                                //     context,
                                                                //     SelectableText(
                                                                //       AppLocalizations.of(context)!.translate('foodDetail_snackBar_addItem'),
                                                                //       cursorColor: Theme.of(context).primaryColor,
                                                                //     ),
                                                                //     AppLocalizations.of(context)!.translate('global_ok'),
                                                                //         () {print('add to cart , create new one');}));
                                                              }
                                                            })
                                                                .catchError((error){
                                                              //Food Item is not exists in database => create new one
                                                              //print data before
                                                              print('food, size is $sizeSelected  , quantity is ${1}  ,  foodId is ${food.foodId}  ,  name is ${food.name} , spices is no thing');

                                                              //Get selected spices then convert it to json
                                                              List<Spice> selectedSpices = [];
                                                              for(var i = 0 ; i < spices.length ; i++){
                                                                if(spices[i].selected){
                                                                  print('spices is ${spices[i].name} is selected');
                                                                  selectedSpices.add(spices[i]);
                                                                }
                                                              }


                                                              var spicesJson = jsonEncode(selectedSpices.map((e) => e.toJson()).toList());
                                                              print('spices as json: $spicesJson');

                                                              _viewModel.insertFood(currentUserId, food.foodId, food.blurhashImg, food.category_id, food.code, food.description, food.hasDiscount, food.img, food.isSale, food.name,(double.parse(globalStatePriceBloc.price.toString())).toString() , food.oldPrice, food.star , 1 , sizeSelected , spicesJson);

                                                              //SnackBar
                                                              SnakBarBuilder.buildAwesomeSnackBar(
                                                                  context,
                                                                  AppLocalizations.of(context)!.translate('foodDetail_snackBar_addItem'),
                                                                  Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                                                  AwesomeSnackBarType.success);


                                                              //Play Confetti Effect
                                                              confettiController.play();
                                                              print('FINISH WORK !!!');

                                                              // _scaffoldState.currentState!.showSnackBar(SnakBarBuilder.build(
                                                              //     context,
                                                              //     SelectableText(
                                                              //       AppLocalizations.of(context)!.translate('foodDetail_snackBar_addItem'),
                                                              //       style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
                                                              //       cursorColor: Theme.of(context).primaryColor,
                                                              //     ),
                                                              //     AppLocalizations.of(context)!.translate('global_ok'),
                                                              //         () {print('add to cart , create new one');}));

                                                            });


                                                          }


                                                        },
                                                        60,
                                                        50,
                                                        60,
                                                        50,
                                                        35,
                                                        25);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30,),


                                  //////////////////////// * Name , Description , Price * ////////////////////////
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        //////////////////////// * Name * ////////////////////////
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4 , vertical: 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                AutoSizeText(
                                                    food.name,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(),
                                                    minFontSize: 12,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),




                                        //////////////////////// * Description * ////////////////////////
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4 , vertical: 8),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                      food.description,
                                                      textAlign: TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6!
                                                          .copyWith( color: Theme.of(context).dividerColor),
                                                      // minFontSize: 12,
                                                      maxLines: 8,
                                                      overflow: TextOverflow.ellipsis
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),


                                        //////////////////////// * Price * ////////////////////////
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4 , vertical: 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                BlocBuilder<FoodDetailPriceBloc,FoodDetailPriceState>(
                                                    buildWhen: (oldState,newState) => oldState != newState,
                                                    builder: (contextPriceBlocBuilder,statePriceBlocBuilder){

                                                      globalContextPriceBloc = contextPriceBlocBuilder;
                                                      globalStatePriceBloc = statePriceBlocBuilder;

                                                      return Row(
                                                        children: [

                                                          //////////////////////// * counter text * ////////////////////////
                                                          arabicMode ?
                                                          Text(
                                                            statePriceBlocBuilder.price.toString(),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .headline4!
                                                                .copyWith(color: Theme.of(context).primaryColor),
                                                          )
                                                              :
                                                          AnimatedFlipCounter(
                                                            value: double.parse(statePriceBlocBuilder.price.toString()),
                                                            duration: Duration(milliseconds: 300),
                                                            fractionDigits: 2,
                                                            curve: Curves.bounceOut,
                                                            textStyle: Theme.of(context)
                                                                .textTheme
                                                                .headline4!
                                                                .copyWith(color: Theme.of(context).primaryColor),
                                                            // minFontSize: 8,
                                                            // maxLines: 1,
                                                            // overflow: TextOverflow.ellipsis,
                                                          ),


                                                          SizedBox(width: 3,),
                                                          Text('\$' , style: Theme.of(context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(color: Theme.of(context).primaryColor),)
                                                        ],
                                                      );
                                                    }
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),






                                  //////////////////////// * Size * ////////////////////////
                                  Padding(
                                    padding: EdgeInsets.only(top: 70, bottom: 15, left: 16, right: 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: AutoSizeText(
                                              AppLocalizations.of(context)!.translate('foodDetail_size'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(),
                                              minFontSize: 10,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Wrap(
                                        children: [
                                          BlocProvider<FoodDetailCheckRadioBloc>.value(
                                            value: _blocCheckRadio,
                                            child: BlocBuilder<FoodDetailCheckRadioBloc,FoodDetailCheckRadioState>(
                                                buildWhen: (oldState,newState) => oldState != newState,
                                                builder: (contextRadio , stateRadio) {

                                                  // sizeSelected = stateRadio.radioCheck;    //Important check hereee

                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      //////////////////////// * Small * ////////////////////////
                                                      Row(
                                                        children: [
                                                          Radio<int>(
                                                              hoverColor: Theme.of(context).primaryColor.withOpacity(0.3),
                                                              focusColor: Theme.of(context).primaryColor.withOpacity(0.3),
                                                              overlayColor: Theme.of(context).radioTheme.overlayColor,
                                                              autofocus: false,
                                                              activeColor: Theme.of(context).primaryColor,
                                                              groupValue: stateRadio.radioCheck,
                                                              fillColor: Theme.of(context).radioTheme.fillColor,
                                                              mouseCursor: SystemMouseCursors.click,
                                                              value: 1,
                                                              onChanged: (value){

                                                                print('change price with small size');
                                                                contextRadio.read<FoodDetailCheckRadioBloc>().change(1);
                                                                sizeSelected = 1;
                                                                //Update Price
                                                                updatePrice(sizeSelected);
                                                              }),
                                                          SizedBox(width: 3,),
                                                          AutoSizeText(
                                                              AppLocalizations.of(context)!.translate('foodDetail_size_small'),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(),
                                                              minFontSize: 4,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 3,),
                                                      //////////////////////// * Medium * ////////////////////////
                                                      Row(
                                                        children: [
                                                          Radio<int>(
                                                              hoverColor: Theme.of(context).primaryColor.withOpacity(0.3),
                                                              focusColor: Theme.of(context).primaryColor.withOpacity(0.3),
                                                              overlayColor: Theme.of(context).radioTheme.overlayColor,
                                                              autofocus: false,
                                                              activeColor: Theme.of(context).primaryColor,
                                                              groupValue: stateRadio.radioCheck,
                                                              fillColor: Theme.of(context).radioTheme.fillColor,
                                                              mouseCursor: SystemMouseCursors.click,
                                                              value: 2,
                                                              onChanged: (value){

                                                                print('change price with Medium size');
                                                                contextRadio.read<FoodDetailCheckRadioBloc>().change(2);
                                                                sizeSelected = 2;
                                                                //Update Price
                                                                updatePrice(sizeSelected);
                                                              }),
                                                          SizedBox(width: 3,),
                                                          AutoSizeText(
                                                              AppLocalizations.of(context)!.translate('foodDetail_size_medium'),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(),
                                                              minFontSize: 10,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 3,),
                                                      //////////////////////// * Large * ////////////////////////
                                                      Row(
                                                        children: [
                                                          Radio<int>(
                                                              hoverColor: Theme.of(context).primaryColor.withOpacity(0.3),
                                                              focusColor: Theme.of(context).primaryColor.withOpacity(0.3),
                                                              overlayColor: Theme.of(context).radioTheme.overlayColor,
                                                              autofocus: false,
                                                              activeColor: Theme.of(context).primaryColor,
                                                              groupValue: stateRadio.radioCheck,
                                                              fillColor: Theme.of(context).radioTheme.fillColor,
                                                              mouseCursor: SystemMouseCursors.click,
                                                              value: 3,
                                                              onChanged: (value){

                                                                print('change price with Large size');
                                                                contextRadio.read<FoodDetailCheckRadioBloc>().change(3);
                                                                sizeSelected = 3;
                                                                //Update Price
                                                                updatePrice(sizeSelected);
                                                              }),
                                                          SizedBox(width: 3,),
                                                          AutoSizeText(
                                                              AppLocalizations.of(context)!.translate('foodDetail_size_large'),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(),
                                                              minFontSize: 10,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 25,),





                                  //////////////////////// * Spices * ////////////////////////
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 25 , horizontal: 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: AutoSizeText(
                                              AppLocalizations.of(context)!.translate('foodDetail_spices'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(),
                                              minFontSize: 10,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Wrap(
                                      children: [
                                        for(Widget item in checkSpices)
                                          item
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 25,),





                                  //////////////////////// * Share & Comment & Favorite * ////////////////////////
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 25 , horizontal: 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: AutoSizeText(
                                              AppLocalizations.of(context)!.translate('foodDetail_shareETC'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(),
                                              minFontSize: 10,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            //////////////////////// * Favorite * ////////////////////////
                                            Link(
                                              target: LinkTarget.self,
                                              uri: Uri(path: '/add_to_favorite'),
                                              builder: (context , followLink){
                                                return AnimationIcon(
                                                    Colors.white,
                                                    Theme.of(context).primaryColor,
                                                    Theme.of(context).primaryColor.withOpacity(0.5),
                                                    Theme.of(context).primaryColor,
                                                    Theme.of(context).primaryColor,
                                                    Theme.of(context).cardColor,
                                                    Icons.favorite,
                                                    Icons.favorite_border_outlined,
                                                        (){
                                                      String currentUser = FirebaseAuth.instance.currentUser!.uid;
                                                      //add to fav list (Moor) , we gonna ignore checking if client added to fav before
                                                      _viewModel.insertFavorite(currentUser, food.foodId, food.blurhashImg, food.category_id, food.code, food.description, food.hasDiscount, food.img, food.isSale, food.name, food.newPrice, food.oldPrice, food.star).then((value){


                                                        SnakBarBuilder.buildAwesomeSnackBar(
                                                            context,
                                                            AppLocalizations.of(context)!.translate('foodDetail_snackBar_addFav'),
                                                            Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                                            AwesomeSnackBarType.success);


                                                        // _scaffoldState.currentState!.showSnackBar(SnakBarBuilder.build(
                                                        //     context,
                                                        //     SelectableText(
                                                        //       AppLocalizations.of(context)!.translate('foodDetail_snackBar_addFav'),
                                                        //       cursorColor: Theme.of(context).primaryColor,
                                                        //     ),
                                                        //     AppLocalizations.of(context)!.translate('global_ok'),
                                                        //         () {print('add to favorite');}));


                                                      });

                                                    },
                                                    60,
                                                    50,
                                                    60,
                                                    50,
                                                    35,
                                                    25);
                                              },
                                            ),
                                            //////////////////////// * Rating * ////////////////////////
                                            Link(
                                              target: LinkTarget.self,
                                              uri: Uri(path: '/rating_food'),
                                              builder: (context,followLink){
                                                return AnimationIcon(
                                                    Colors.white,
                                                    Theme.of(context).accentColor,
                                                    Theme.of(context).accentColor.withOpacity(0.5),
                                                    Theme.of(context).accentColor,
                                                    Theme.of(context).accentColor,
                                                    Theme.of(context).cardColor,
                                                    Icons.star,
                                                    Icons.star_border_outlined,
                                                        (){
                                                      //Show dialog and save in firestore img,comment,name,food_id,stars
                                                      // show the dialog
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => Dialog(
                                                            backgroundColor: Theme.of(context).cardColor,
                                                            child: _showDialogRating(context),
                                                          )
                                                      );
                                                    },
                                                    60,
                                                    50,
                                                    60,
                                                    50,
                                                    35,
                                                    25);
                                              },
                                            ),
                                            //////////////////////// * Share * ////////////////////////
                                            if(!PlatformDetector.isWeb)
                                              Link(
                                                target: LinkTarget.self,
                                                uri: Uri(path: '/share'),
                                                builder: (context , followLink){
                                                  return AnimationIcon(
                                                      Colors.white,
                                                      darkMode ? Colors.blue : Colors.lightBlue,
                                                      darkMode ? Colors.blue.withOpacity(0.3) : Colors.lightBlue.withOpacity(0.3),
                                                      darkMode ? Colors.blue : Colors.lightBlue,
                                                      darkMode ? Colors.blue : Colors.lightBlue,
                                                      Theme.of(context).cardColor,
                                                      Icons.share_outlined,
                                                      Icons.share_outlined,
                                                          (){
                                                        //Share the Image to social media
                                                        //If windows or linux we can't share images (files) but we can share text (urls)
                                                        if(PlatformDetector.isWindows || PlatformDetector.isLinux){

                                                          print('start share url of image of food for windows or linux');
                                                          Share.share(food.img , subject: 'Image of ${food.name.toString()}');

                                                          //Show SnackBar
                                                          // _scaffoldState.currentState!.showSnackBar(SnakBarBuilder.build(
                                                          //     context,
                                                          //     SelectableText(
                                                          //       'You can not share images in windows or linux !!!!',
                                                          //       cursorColor: Theme.of(context).primaryColor,
                                                          //     ),
                                                          //     AppLocalizations.of(context)!.translate('global_ok'),
                                                          //         () {print('Platform is  windows or linux !!!');}));
                                                        }

                                                        else {  //Otherwise , we gonna create load image by http and save it in local directory and share it
                                                          print('start share image of food');
                                                          shareImage(context);
                                                        }
                                                      },
                                                      60,
                                                      50,
                                                      60,
                                                      50,
                                                      35,
                                                      25);
                                                },
                                              )


                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 25,),





                                  //////////////////////// * Share social media (FOR WEB ONLY) * ////////////////////////
                                  PlatformDetector.isWeb ?
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 25 , horizontal: 16),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: AutoSizeText(
                                                  AppLocalizations.of(context)!.translate('foodDetail_share_title'),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4!
                                                      .copyWith(),
                                                  minFontSize: 18,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis
                                              ),
                                            ),


                                          ],
                                        ),
                                      ),
                                      Wrap(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [

                                              //share Facebook
                                              Link(
                                                target: LinkTarget.self,
                                                uri: Uri(path: '/share_facebook'),
                                                builder: (context , followLink){
                                                  return InkWell(
                                                    child: Container(
                                                      width: 64,
                                                      height: 64,
                                                      child: Center(
                                                        child: FaIcon(FontAwesomeIcons.facebook, color: Color(0xFF0075fc), size: 40,),
                                                      ),
                                                    ),
                                                    onTap: () => shareWebUrlImage(SocialMedia.facebook),
                                                  );
                                                },
                                              ),


                                              //share Twitter
                                              Link(
                                                target: LinkTarget.self,
                                                uri: Uri(path: '/share_twitter'),
                                                builder: (context , followLink){
                                                  return  InkWell(
                                                    child: Container(
                                                      width: 64,
                                                      height: 64,
                                                      child: Center(
                                                        child: FaIcon(FontAwesomeIcons.twitter, color: Color(0xFF1da1f2), size: 40,),
                                                      ),
                                                    ),
                                                    onTap: () => shareWebUrlImage(SocialMedia.twitter),
                                                  );
                                                },
                                              ),



                                              //share Linkin
                                              Link(
                                                target: LinkTarget.self,
                                                uri: Uri(path: '/share_linkin'),
                                                builder: (context , followLink){
                                                  return InkWell(
                                                    child: Container(
                                                      width: 64,
                                                      height: 64,
                                                      child: Center(
                                                        child: FaIcon(FontAwesomeIcons.linkedin, color: Color(0xFF2867B2), size: 40,),
                                                      ),
                                                    ),
                                                    onTap: () => shareWebUrlImage(SocialMedia.linkedIn),
                                                  );
                                                },
                                              ),



                                              //share whatsapp
                                              Link(
                                                target: LinkTarget.self,
                                                uri: Uri(path: '/share_whatsapp'),
                                                builder: (context , followLink){
                                                  return  InkWell(
                                                    child: Container(
                                                      width: 64,
                                                      height: 64,
                                                      child: Center(
                                                        child: FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF2FAA32), size: 40,),
                                                      ),
                                                    ),
                                                    onTap: () => shareWebUrlImage(SocialMedia.whatsapp),
                                                  );
                                                },
                                              ),


                                              //share reddit
                                              Link(
                                                target: LinkTarget.self,
                                                uri: Uri(path: '/share_reddit'),
                                                builder: (context , followLink){
                                                  return  InkWell(
                                                    child: Container(
                                                      width: 64,
                                                      height: 64,
                                                      child: Center(
                                                        child: FaIcon(FontAwesomeIcons.reddit, color: Color(0xFFFF5700), size: 40,),
                                                      ),
                                                    ),
                                                    onTap: () => shareWebUrlImage(SocialMedia.reddit),
                                                  );
                                                },
                                              ),


                                              //share Email
                                              Link(
                                                target: LinkTarget.self,
                                                uri: Uri(path: '/share_email'),
                                                builder: (context , followLink){
                                                  return InkWell(
                                                    child: Container(
                                                      width: 64,
                                                      height: 64,
                                                      child: Center(
                                                        child: FaIcon(Icons.email, color: Theme.of(context).primaryColor, size: 40,),
                                                      ),
                                                    ),
                                                    onTap: () => shareWebUrlImage(SocialMedia.email),
                                                  );
                                                },
                                              ),


                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20,)
                                    ],
                                  )
                                      :
                                  Container(),





                                  //////////////////////// * Ratings and comments list * ////////////////////////
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 25 , horizontal: 16),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: AutoSizeText(
                                              AppLocalizations.of(context)!.translate('foodDetail_comment'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(),
                                              minFontSize: 18,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4 , horizontal: 8),
                                    child: Container(
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: ratingComments,
                                            builder: (context , AsyncSnapshot<QuerySnapshot> snapshotComment){

                                              //There is an error
                                              if (snapshotComment.hasError) {
                                                print('there is a problem !!!   ${snapshotComment.hasError.toString()}    ${snapshotComment.error.toString()}');
                                                return DataTemplate.error(context);
                                              }

                                              ////No Data
                                              if (!snapshotComment.hasData) {
                                                if (snapshotComment.connectionState == ConnectionState.done)
                                                  return DataTemplate.noData(context);
                                              }

                                              //Load data
                                              if (snapshotComment.connectionState == ConnectionState.waiting){
                                                print('load category Data');
                                                return DataTemplate.load(context);
                                              }

                                              //No Internet
                                              if (snapshotComment.connectionState == ConnectionState.none){
                                                print('No Internet !!!');
                                                return DataTemplate.noInternet(context);
                                              }

                                              //snapshot.connectionState == ConnectionState.active or snapshot.connectionState == ConnectionState.done (has data)
                                              //Init data foods
                                              if(isFirstTimeComment){
                                                print('pass it firstTime');
                                                comments.clear();
                                                comments = [];
                                                snapshotComment.data!.docs.forEach((DocumentSnapshot document){
                                                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>; //data['blurhashImg'].toString(),
                                                  comments.add(Comment(data['comment'].toString(),data['food_id'].toString(),data['img'].toString(),data['name'].toString(),data['star'].toString()));
                                                });
                                                isFirstTimeComment = false;
                                              }


                                              //Print size of tabs list
                                              print('size of comments is ${comments.length}');

                                              return LiveList.options(
                                                // And attach root sliver scrollController to widgets
                                                controller: ScrollController(),
                                                shrinkWrap: true,
                                                options: options,
                                                // showItemDuration: listShowItemDuration,
                                                itemCount: comments.length,
                                                itemBuilder: (context, index , animate) => buildComment(context, comments[index] , animate),
                                              );
                                            }
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 10,)


                                ]),
                              )
                            ]
                        ),
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: false,
                    colors: [
                      Colors.green,
                      Colors.blue,
                      Colors.red,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple,
                      Colors.yellow,
                      Colors.cyan,
                    ],
                    createParticlePath: drawStar,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



  _buildSpices(BuildContext context) {

    checkSpices = [];
    for(var i = 0 ; i < spices.length ; i++){
      checkSpices.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2 , horizontal: 22),
            child: BlocProvider<FoodDetailCheckBoxBloc>.value(
              value: _listCheckBoxBlocs[i],
              child: BlocBuilder<FoodDetailCheckBoxBloc,FoodDetailCheckBoxState>(
                  buildWhen: (oldState,newState) => oldState != newState,
                  builder: (contextCheckBox , stateCheckBox){
                    return Row(
                      children: [
                        Checkbox(
                            overlayColor: Theme.of(context).checkboxTheme.overlayColor,
                            fillColor: Theme.of(context).checkboxTheme.fillColor,
                            checkColor: Colors.white,
                            activeColor: Theme.of(context).primaryColor,
                            focusColor: Theme.of(context).primaryColor.withOpacity(0.3),
                            hoverColor: Theme.of(context).primaryColor.withOpacity(0.3),
                            autofocus: false,
                            mouseCursor: SystemMouseCursors.click,
                            value: stateCheckBox.checked,
                            onChanged: (value){

                              //Change state of check box
                              bool currentValue = value as bool;
                              spices[i].selected = currentValue;
                              contextCheckBox.read<FoodDetailCheckBoxBloc>().change(currentValue);

                              //Update the price
                              print('change checkBox of ${spices[i].name}');
                              updatePrice(sizeSelected);

                            }),
                        SizedBox(width: 3,),
                        AutoSizeText(
                            spices[i].name,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(),
                            minFontSize: 4,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                        ),
                        SizedBox(width: 3,),
                        AutoSizeText(
                            spices[i].price.toString() + ' \$',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Theme.of(context).primaryColor),
                            minFontSize: 4,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                        ),
                      ],
                    );
                  }
              ),
            ),
          )
      );
    }

  }

  buildComment(BuildContext context, Comment comment, Animation<double> animate) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animate),
        // And slide transition
        child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animate),
            child: Container(
              child: ListTile(
                  hoverColor: Theme.of(context).cardColor.withOpacity(0.3),
                  focusColor: Theme.of(context).cardColor.withOpacity(0.3),


                  leading: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: CachedNetworkImageProvider(comment.img),
                  ),


                  title: Text(
                      comment.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                  ),


                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 4,),
                            Row(
                              children: [
                                Text(
                                    comment.comment,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis
                                ),
                              ],
                            ),
                            SizedBox(height: 4,),
                            RatingBar.builder(
                              glowRadius: 5,
                              itemSize: 20,
                              glow: true,
                              glowColor: Colors.yellowAccent,
                              initialRating: double.parse(comment.star),
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
                          ],
                        ),
                      ],
                    ),
                  )


              ),
            )
        ),
      ),
    );
  }

  void updatePrice(int sizeType) {

    print('price before : ' + globalStatePriceBloc.price.toString());

    //Calculate spices count
    double spicesCount = 0;
    for(var i = 0 ; i < spices.length ; i++){
      if(spices[i].selected){
        print('spices is ${spices[i].name} is selected');
        spicesCount += spices[i].price;
      }
    }
    print('total of spices is $spicesCount');

    //Calculate Size count
    double sizeCount = 0; //Small
    switch(sizeType){
      case 1 :{
        sizeCount = 0;
        print('Small Size is selected !');
        break;
      }
      case 2 :{
        sizeCount = 200;
        print('Medium Size is selected !');
        break;
      }
      case 3 :{
        sizeCount = 400;
        print('Large Size is selected !');
        break;
      }
      default :{
        sizeCount = 0;
        print('Default Small Size is selected !');
        break;
      }
    }

    //Calculate all
    double totalPrice = currentPrice + sizeCount + spicesCount;
    print('total price is $totalPrice');
    globalContextPriceBloc.read<FoodDetailPriceBloc>().change(totalPrice);

  }

  void shareImage(BuildContext context) async {

    print('start share .....');

    //Get image from internet first !

    var response = await http.get(
        Uri.parse(food.img.toString()));

    print('get the image ${response.body.length}');

    Directory documentDirectory = await getTemporaryDirectory(); //or getApplicationSupportDirectory() this more secure
    File file = new File(join(documentDirectory.path, '${food.name + Random().nextInt(10000).toString()}.jpg'));

    file.writeAsBytes(response.bodyBytes);

    print('path the image of food is ${file.path}');

    Share.shareFiles([file.absolute.path] , text: '${food.name + Random().nextInt(10000).toString()}.jpg').then((value){

      print('process of image is ended !!!');

      //We can't show message to share image because we don't know if user share the image or not  !!!!
      //   _scaffoldState.currentState!.showSnackBar(SnakBarBuilder.build(
      //       context,
      //       SelectableText(
      //         'share it image success',
      //         cursorColor: Theme.of(context).primaryColor,
      //       ),
      //       AppLocalizations.of(context)!.translate('global_ok'),
      //           () {print('Platform is  windows or linux !!!');}));
      //
    });
  }

  _showDialogRating(BuildContext context) {

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
                  AppLocalizations.of(context)!.translate('foodDetail_ratingCommentDialog_title'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(),
                  minFontSize: 12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis
              ),
              SizedBox(height: 12),

              //////////////////////// * Subtitle * ////////////////////////
              AutoSizeText(
                  AppLocalizations.of(context)!.translate('foodDetail_ratingCommentDialog_content'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Theme.of(context).dividerColor),
                  minFontSize: 12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis
              ),
              SizedBox(height: 12,),

              RatingBar.builder(
                itemSize: 25,
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
                  _ratingCommentValue = rating;
                },
              ),
              SizedBox(height: 12,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 0),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                    width: 350,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      enableSuggestions: true,
                      readOnly: false,
                      textInputAction: TextInputAction.done,
                      // textAlign: AppLocalizations.of(context)!.isEnLocale
                      //     ? TextAlign.start
                      //     : TextAlign.end,
                      // textDirection: AppLocalizations.of(context)!.isEnLocale
                      //     ? TextDirection.ltr
                      //     : TextDirection.rtl,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      // maxLengthEnforced: true,
                      // maxLength: 100,
                      autofocus: false,
                      autocorrect: true,
                      cursorColor: Theme.of(context).primaryColor,
                      controller: _controllerComment,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.translate('foodDetail_ratingCommentDialog_hintTextField'),
                        icon: Icon(
                          Icons.insert_comment_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    )
                ),
              ),
              SizedBox(height: 36,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.translate('global_cancel'),
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                  ),
                  TextButton(
                      onPressed: (){
                        //Save in comment collection in database
                        _viewModel.addRatingComment(context, _scaffoldState, Common.currentUser.displayName.toString(), Common.currentUser.photoURL.toString(), _controllerComment.text, _ratingCommentValue.toInt(), int.parse(food.foodId));
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.translate('global_submit'),
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Theme.of(context).primaryColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
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
                Icons.star,
                size: 28,
                color: Colors.white,
              ),
            )
        )

      ],
    );

  }

  shareWebUrlImage(SocialMedia socialMedia) async{

    String text = 'Foody Restaurant\nWe have many of foods and recipes which gonna you like and you are waiting to see you ❤❤❤';
    String subject = 'Foody';
    String urlShare = Uri.encodeComponent(food.img);

    var urls ={
      SocialMedia.facebook : 'https://www.facebook.com/sharer/sharer.php?u=$urlShare&t=$text',
      SocialMedia.twitter : 'https://twitter.com/intent/tweet?url=$urlShare&text=$text',
      SocialMedia.email : 'mailto:?subject=$subject&body=$text\n\n$urlShare',
      SocialMedia.linkedIn : 'https://www.linkedin.com/shareArticle?mini=true&url=$urlShare',
      SocialMedia.whatsapp : 'https://api.whatsapp.com/send?text=$text\n$urlShare',
      SocialMedia.reddit: 'https://www.reddit.com/submit?url=$urlShare',
    };

    final url = urls[socialMedia];

    if(await canLaunch(url!))
      await launch(url);
  }

  Path drawStar(Size size) {

    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;

  }


}

class ImageFoodClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    Path path = Path();

    path.lineTo(0, size.height - 170);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height - 170);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

enum SocialMedia{
  //There no thing available to messenger and tiktok
  facebook,
  twitter,
  linkedIn,
  whatsapp,
  // messenger,
  // tiktok,
  reddit,
  email
}