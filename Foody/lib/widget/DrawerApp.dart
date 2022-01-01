import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/blocUnit/AppBloc.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/model/modelUi/DrawerModel.dart';
import 'package:foody/moor/DaoMoor/FoodyDao.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/style/platformDetect/PlatformDetector.dart';
import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:velocity_x/velocity_x.dart';
import 'SnakBarBuilder.dart';

class DrawerApp extends StatelessWidget {

  //Vars
  int selectedIndex;
  BuildContext context;
  bool isMobile;
  GlobalKey<ScaffoldState> _scaffoldState;


  DrawerApp(this.selectedIndex , this.context , this._scaffoldState , this.isMobile);

  @override
  Widget build(BuildContext context) {


    //Init Hive
    var box = Hive.box('foody');
    var darkMode = box.get('darkMode', defaultValue: false);
    var arabicMode = box.get('arabicMode', defaultValue: false);
    print('isDark : ' + darkMode.toString());
    print('isEnglish : ' + arabicMode.toString());

    bool languageValue = arabicMode;





    //List of drawers
    List<DrawerModel> drawers = [

      //Food Page
      DrawerModel(
          darkMode ? Color(0x07FFFFFF) : Color(0x0A000000),   //Colors.white12 : Colors.black12
          darkMode ? Colors.white54 : Colors.black54,   //
          AppLocalizations.of(context)!.translate('drawable_item_foods'),
          Icons.fastfood_sharp,
              (){


                if(selectedIndex != 0){

                  if(isMobile)
                    VxNavigator.of(context).pop();

                  VxNavigator.of(context).push(Uri(path: Routers.foodsRoute));


                }
                else {
                  print('This is current page , you can not navigate to same page');
                }


              }),

      //Cart Page
      DrawerModel(
          darkMode ? Colors.white12 : Colors.black12,
          darkMode ? Colors.white54 : Colors.black54,
          AppLocalizations.of(context)!.translate('drawable_item_cart'),
          Icons.shopping_cart_outlined,
              (){

                if(selectedIndex != 1){

                  if(isMobile)
                    VxNavigator.of(context).pop();

                  VxNavigator.of(context).push(Uri(path: Routers.cartRoute));


                }
                else {
                  print('This is current page , you can not navigate to same page');
                }
          }),

      //Chart Page
      DrawerModel(
          darkMode ? Colors.white12 : Colors.black12,
          darkMode ? Colors.white54 : Colors.black54,
          AppLocalizations.of(context)!.translate('drawable_item_chart'),
          Icons.stacked_line_chart,
              () {



                if(selectedIndex != 2){

                  if(isMobile)
                    VxNavigator.of(context).pop();

                  VxNavigator.of(context).push(Uri(path: Routers.chartRoute));

                }
                else {
                  print('This is current page , you can not navigate to same page');
                }

              }),

      //Logout
      DrawerModel(
          darkMode ? Colors.white12 : Colors.black12,
          darkMode ? Colors.white54 : Colors.black54,
          AppLocalizations.of(context)!.translate('drawable_item_logout'),
          Icons.logout,
              (){

                //Clear moor
                FoodyDao dao = FoodyDao.instance;
                dao.clearFavoriteData().then((value) => print('Favorites table is cleared from moor database'));
                dao.clearFoodsData().then((value) => print('Foods table is cleared from moor database'));



                //Clear hive
                box.clear().then((value) => print('Data is cleared from hive database !!!'));



                //Firebase Firestore
                //order
                FirebaseFirestore.instance
                    .collection('order')
                    .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid != null ? FirebaseAuth.instance.currentUser!.uid : 'no found')
                    .get()
                    .then((snapshots){
                      for (var doc in snapshots.docs) {

                        String docId = doc.reference.id;

                        //Delete signature image of order in firebase storage
                        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                        FirebaseStorage.instance.refFromURL(data['signature_url'].toString())
                            .delete().then((value) => print('signature url is removed !!!'));

                        //Delete order
                        doc.reference.delete().then((value) => print('Order $docId is deleted !'));
                      }
                    });
                //Comment
                FirebaseFirestore.instance
                    .collection('Comment')
                    .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid != null ? FirebaseAuth.instance.currentUser!.uid : 'no found')
                    .get()
                    .then((snapshots){
                  for (var doc in snapshots.docs) {

                    //Delete Comment
                    String docId = doc.reference.id;
                    doc.reference.delete().then((value) => print('Comment $docId is deleted !'));
                  }
                });



                //Firebase Storage
                //Delete user's photo
                FirebaseStorage.instance.refFromURL(FirebaseAuth.instance.currentUser!.photoURL.toString())
                    .delete().then((value) => print('user\'s photo is deleted !!!'));




                //Clear Firebase Auth
                FirebaseAuth.instance.currentUser!.delete().then((value) => print('Firebase Auth: user\'s Data is cleared !'));


                //Navigate to home page
                VxNavigator.of(context).push(
                    Uri(path: Routers.homeRoute));


              }),

      //Add Switch dark/light themes
      //Add Language selection

    ];





    //change color of items selected
    drawers[selectedIndex].colorTitleIcon = Theme.of(context).primaryColor;





    //combine header and items in one list
    List<Widget> finalList = [

      //Header
      Container(
        width: 600,
        height: 200,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset("images/foody_logo.png" , height: 100, width: 100, fit: BoxFit.cover , filterQuality: FilterQuality.high,),
                SizedBox(height: 13,),
                BorderedText(
                  strokeWidth: 5,
                  strokeColor: Colors.white,
                  child: Text(
                    AppLocalizations.of(context)!.translate('home_title_header'),
                    style: Theme.of(context).textTheme.headline6!.copyWith(
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
              ],
            ),
          ),
        ),
      )

      // DrawerHeader(
      //   child: Image.asset("images/foody_logo.png" , height: 100, width: 100, fit: BoxFit.cover , filterQuality: FilterQuality.high,),
      // ),

    ]..addAll(drawers.map((drawer){

      print('hoverColor : ' + (drawer.colorHover != null).toString());
      print('colorTitleIcon : ' + (drawer.colorTitleIcon != null).toString());
      print('title : ' + (drawer.title != null).toString());
      print('icon : ' + (drawer.icon != null).toString());

      return drawerListTile(
          drawer.colorHover, drawer.colorTitleIcon, drawer.title,
          drawer.icon, drawer.press);
    }));





    finalList.addAll([

      SizedBox(height: 10,),

      Divider(thickness: 1, color: Theme.of(context).dividerColor,),

      //Review The App
      ListTile(
        hoverColor: darkMode ? Color(0x07FFFFFF) : Color(0x0A000000),
        onTap: () async{

          //In app review start
          await reviewApp(context);

        },
        horizontalTitleGap: 0.0,
        leading: Icon(
          Icons.star,
          color: darkMode ? Colors.white54 : Colors.black54,
          size: 19,
        ),
        title: Text(
          AppLocalizations.of(context)!.translate('drawable_item_review'),
          style: TextStyle(color: darkMode ? Colors.white54 : Colors.black54),
        ),
      ),

      //Dark /Light Themes
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 12),
          child: DayNightSwitcher(
            isDarkModeEnabled: darkMode,
            onStateChanged: (isDarkModeEnabled) {

              if(isDarkModeEnabled){
                context.read<AppBloc>().toDark();
                box.put('darkMode', true);
              }
              else {
                context.read<AppBloc>().toLight();
                box.put('darkMode', false);
              }

              // setState(() {
              //   this.isDarkModeEnabled = isDarkModeEnabled;
              // });

            },
          ),
        ),
      ),

      //Arabic /English Languages
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 12),
          child:  AnimatedToggleSwitch<bool>.dual(
            first: false,
            second: true,
            current: languageValue,  //False: English , True: Arabic
            indicatorColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            height: 35,
            dif: 10.0,
            colorBuilder: (b) => b ? Theme.of(context).primaryColor : Colors.red[200],
            iconBuilder: (b, size, active) => b
                ? Icon(Icons.translate)  //Arabic
                : Icon(Icons.star),  //English
            textBuilder: (b, size, active) => b
                ? Center(child: Text('Arabic' , style: Theme.of(context).textTheme.overline!.copyWith(color: darkMode ? Colors.white : Colors.black87)))  //Arabic
                : Center(child: Text('English' , style: Theme.of(context).textTheme.overline!.copyWith(color: darkMode ? Colors.white : Colors.black87))),  //English
            onChanged: (isArabic){

              print('languageValue: $languageValue');
              print('isArabic: $isArabic');


              languageValue = isArabic;

              if(!isArabic){  //English
                context.read<AppBloc>().toEnglish();
                box.put('arabicMode', false);
              }
              else {  //languageType == 1   //Arabic
                context.read<AppBloc>().toArabic();
                box.put('arabicMode', true);
              }
              // setState(() => value = i)
            },
            // iconBuilder: (i , size , active){
            //
            //   print('i: $i');
            //   print('active: $active');
            //   print('size: $size');
            //
            //   IconData data = Icons.navigate_next;
            //   if (i.isEven){
            //     print('i.isEven: ${i.isEven}');
            //     data = Icons.translate;
            //   }
            //
            //   return Icon(
            //     data,
            //     size: size.shortestSide,
            //     color: active ? Colors.white : Colors.white60,
            //   );
            // },
          ),
        ),
      ),

      SizedBox(height: 10,)

    ]);



    return Drawer(
      child: ListView(
        children: finalList,
      ),
    );
  }

  Future<void> reviewApp(BuildContext context) async {
     if(PlatformDetector.isWeb){

       SnakBarBuilder.buildAwesomeSnackBar(
           context,
           AppLocalizations.of(context)!.translate('drawable_item_snackBar_review_web_platform'),
           Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
           AwesomeSnackBarType.info);

      // _scaffoldState.currentState!.showSnackBar(SnakBarBuilder.build(
      //     context,
      //     SelectableText(
      //       AppLocalizations.of(context)!.translate('drawable_item_snackBar_review_web_platform'),
      //       cursorColor: Theme.of(context).primaryColor,
      //     ),
      //     AppLocalizations.of(context)!.translate('global_ok'),
      //         () {print('ok');}));


            /////////////////// OR You can use url_launcher to rate on google play /////////////////////

    }
    else if(PlatformDetector.isAndroid || PlatformDetector.isIOS || PlatformDetector.isMacOS){

      final InAppReview inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview().then((value) => print('open Google/Apple Stores !!!!!!!!'));
      }
      else{

        SnakBarBuilder.buildAwesomeSnackBar(
            context,
            AppLocalizations.of(context)!.translate('drawable_item_snackBar_review_not_available'),
            Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
            AwesomeSnackBarType.error);

        // _scaffoldState.currentState!.showSnackBar(SnakBarBuilder.build(
        //     context,
        //     SelectableText(
        //       AppLocalizations.of(context)!.translate('drawable_item_snackBar_review_not_available'),
        //       cursorColor: Theme.of(context).primaryColor,
        //     ),
        //     AppLocalizations.of(context)!.translate('global_ok'),
        //         () {print('ok');}));
      }

    }
    else if(PlatformDetector.isWindows){

      final InAppReview inAppReview = InAppReview.instance;
      inAppReview.openStoreListing(appStoreId: '..................................', microsoftStoreId: '.....................................')
          .then((value) => print('open Microsoft Store !!!!!!!!'));

    }
    else {
      //Linux Don't support
    }
  }
}



class drawerListTile extends StatelessWidget {

  Color colorHover;
  Color colorTitleIcon;
  String title;
  IconData icon;
  GestureTapCallback? press;

  drawerListTile(this.colorHover, this.colorTitleIcon, this.title, this.icon, this.press);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      hoverColor: colorHover,
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: colorTitleIcon,
        size: 19,
      ),
      title: Text(
        title,
        style: TextStyle(color: colorTitleIcon),
      ),
    );
  }

}