import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/blocUnit/AppBloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/moor/DaoMoor/FoodyDao.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/style/platformDetect/PlatformDetector.dart';
import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/link.dart';
import 'package:velocity_x/velocity_x.dart';
import 'SnakBarBuilder.dart';

class FoodyNavigationRail extends StatelessWidget {

  //Init vars
  int selectedIndex;
  BuildContext context;
  var darkMode;
  var arabicMode;


  FoodyNavigationRail(this.selectedIndex,this.context);

  @override
  Widget build(BuildContext context) {

    //Init Hive
    var box = Hive.box('foody');
    darkMode = box.get('darkMode', defaultValue: false);
    arabicMode = box.get('arabicMode', defaultValue: false);
    print('isDark : ' + darkMode.toString());
    print('isEnglish : ' + arabicMode.toString());

    //For languages
    bool languageValue = arabicMode;


   return Container(
     height: MediaQuery.of(context).size.height,
     child: NavigationRail(
       destinations: [

         //Logo
         NavigationRailDestination(
             icon: GestureDetector(
               onTap: (){},
               child: Link(
                 target: LinkTarget.self,
                 uri: Uri(path: Routers.homeRoute),
                 builder: (context , followLink){
                   return MouseRegion(
                     cursor: SystemMouseCursors.click,
                     child: Image.asset("images/foody_logo.png" , height: 30, width: 30, fit: BoxFit.cover , filterQuality: FilterQuality.high,),
                   );
                 },
               ),
             ),
             // padding: const EdgeInsets.all(16),
             label: Text('Foody')
         ),

         //Foods
         NavigationRailDestination(
           // selectedIcon: ,
             icon: GestureDetector(
               onTap: (){
                 selectedIndex != 0 ?
                 VxNavigator.of(context).push(Uri(path: Routers.foodsRoute))
                     :
                 print('This is current page , you can not navigate to same page');
               },
               child: Link(
                 target: LinkTarget.self,
                 uri: Uri(path: Routers.foodsRoute),
                 builder: (context , followLink){
                   return MouseRegion(
                     cursor: SystemMouseCursors.click,
                     child: Icon(
                       Icons.fastfood_sharp,
                       color: selectedIndex == 0 ? Theme.of(context).primaryColor : darkMode ? Colors.white54 : Colors.black54,
                       size: 19,
                     ),
                   );
                 },
               ),
             ),
             label: GestureDetector(
               onTap: (){
                 selectedIndex != 0 ?
                 VxNavigator.of(context).push(Uri(path: Routers.foodsRoute))
                     :
                 print('This is current page , you can not navigate to same page');
               },
               child: Link(
                   target: LinkTarget.self,
                   uri: Uri(path: Routers.foodsRoute),
                   builder: (context,followLink){
                     return MouseRegion(
                       cursor: SystemMouseCursors.click,
                       child: Text(
                         AppLocalizations.of(context)!.translate('drawable_item_foods'),
                         style: TextStyle(color: selectedIndex == 0 ? Theme.of(context).primaryColor : darkMode ? Colors.white54 : Colors.black54),
                       ),
                     );
                   }
               ),
             ),
             // padding: const EdgeInsets.all(16)
         ),


         //Cart
         NavigationRailDestination(
           // selectedIcon: ,
             icon: GestureDetector(
               onTap: (){
                 selectedIndex != 1 ?
                 VxNavigator.of(context).push(Uri(path: Routers.cartRoute))
                     :
                 print('This is current page , you can not navigate to same page');
               },
               child: Link(
                 target: LinkTarget.self,
                 uri: Uri(path: Routers.cartRoute),
                 builder: (context,followLink){
                   return MouseRegion(
                     cursor: SystemMouseCursors.click,
                     child: Icon(
                       Icons.shopping_cart_outlined,
                       color: selectedIndex == 1 ? Theme.of(context).primaryColor :  darkMode ? Colors.white54 : Colors.black54,
                       size: 19,
                     ),
                   );
                 },
               ),
             ),
             label: GestureDetector(
               onTap: (){
                 selectedIndex != 1 ?
                 VxNavigator.of(context).push(Uri(path: Routers.cartRoute))
                     :
                 print('This is current page , you can not navigate to same page');
               },
               child: Link(
                 target: LinkTarget.self,
                 uri: Uri(path: Routers.cartRoute),
                 builder: (context , followLink){
                   return MouseRegion(
                     cursor: SystemMouseCursors.click,
                     child: Text(
                       AppLocalizations.of(context)!.translate('drawable_item_cart'),
                       style: TextStyle(color: selectedIndex == 1 ? Theme.of(context).primaryColor :  darkMode ? Colors.white54 : Colors.black54),
                     ),
                   );
                 },
               ),
             ),
             // padding: const EdgeInsets.all(16)
         ),


         //Chart
         NavigationRailDestination(
           // selectedIcon: ,
             icon: GestureDetector(
               onTap: (){
                 selectedIndex != 2 ?
                 VxNavigator.of(context).push(Uri(path: Routers.chartRoute))
                     :
                 print('This is current page , you can not navigate to same page');
               },
               child: Link(
                 target: LinkTarget.self,
                 uri: Uri(path: Routers.chartRoute),
                 builder: (context , followLink){
                   return MouseRegion(
                     cursor: SystemMouseCursors.click,
                     child: Icon(
                       Icons.stacked_line_chart,
                       color: selectedIndex == 2 ? Theme.of(context).primaryColor :  darkMode ? Colors.white54 : Colors.black54,
                       size: 19,
                     ),
                   );
                 },
               ),
             ),
             label: GestureDetector(
               onTap: (){
                 selectedIndex != 2 ?
                 VxNavigator.of(context).push(Uri(path: Routers.chartRoute))
                     :
                 print('This is current page , you can not navigate to same page');
               },
               child: Link(
                 target: LinkTarget.self,
                 uri: Uri(path: Routers.chartRoute),
                 builder: (context , followLink){
                   return MouseRegion(
                     cursor: SystemMouseCursors.click,
                     child: Text(
                       AppLocalizations.of(context)!.translate('drawable_item_chart'),
                       style: TextStyle(color: selectedIndex == 2 ? Theme.of(context).primaryColor :  darkMode ? Colors.white54 : Colors.black54),
                     ),
                   );
                 },
               ),
             ),
             // padding: const EdgeInsets.all(16)
         ),


         //logout
         NavigationRailDestination(
           // selectedIcon: ,
             icon: GestureDetector(
               onTap: (){

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

               },
               child: Link(
                 target: LinkTarget.self,
                 uri: Uri(path: '/logout'),
                 builder: (context , followLink){
                   return MouseRegion(
                     cursor: SystemMouseCursors.click,
                     child: Icon(
                       Icons.logout,
                       color: darkMode ? Colors.white54 : Colors.black54,
                       size: 19,
                     ),
                   );
                 },
               ),
             ),
             label: GestureDetector(
               onTap: (){

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

               },
               child: Link(
                 target: LinkTarget.self,
                 uri: Uri(path: '/logout'),
                 builder: (context , followLink){
                   return MouseRegion(
                     cursor: SystemMouseCursors.click,
                     child: Text(
                       AppLocalizations.of(context)!.translate('drawable_item_logout'),
                       style: TextStyle(color: darkMode ? Colors.white54 : Colors.black54),
                     ),
                   );
                 },
               ),
             ),
             // padding: const EdgeInsets.all(16)
         ),

       ],
       selectedIndex: selectedIndex,

       backgroundColor: Theme.of(context).cardColor,
       elevation: 6,
       // leading: ,  //No Thing
       trailing: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Divider(),

             //Star Item
             InkWell(
               onTap: () async{

                 //In app review start
                 await reviewApp(context);
               },
               child: Link(
                 target: LinkTarget.self,
                 uri: Uri(path: '/review_app'),
                 builder: (context , followLink){
                   return MouseRegion(
                     cursor: SystemMouseCursors.click,
                     child: Icon(
                       Icons.star,
                       color: darkMode ? Colors.white54 : Colors.black54,
                       size: 19,
                     ),
                   );
                 },
               ),
             ),
             SizedBox(height: 8,),



             //Dark & Light Themes
             Padding(
               padding: const EdgeInsets.all(16),
               child: DayNightSwitcherIcon(
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
             SizedBox(height: 6,),


             //Languages Switch (RotatedBox != Transform.rotate)
             RotatedBox(
               quarterTurns: arabicMode ? 1 : 3,
               child: AnimatedToggleSwitch<bool>.dual(
                 first: false,
                 second: true,
                 current: languageValue,  //False: English , True: Arabic
                 indicatorColor: Theme.of(context).primaryColor,
                 borderColor: Theme.of(context).primaryColor,
                 height: 35,
                 dif: 10.0,
                 colorBuilder: (b) => b ? Theme.of(context).primaryColor : Colors.red[300],
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
             SizedBox(height: 4,),


           ],
         ),
       ),
       groupAlignment: -1,   //-1: Top , 0: Center , 1: Bottom
       onDestinationSelected: (int selectedDestination){

       },
       // unselectedLabelTextStyle: ,
       // selectedLabelTextStyle: ,
       // unselectedIconTheme: ,
       // selectedIconTheme: ,
       labelType: NavigationRailLabelType.none,

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