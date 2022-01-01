
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart' if (dart.library.html) 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foody/style/AppBuilder/AppBuilder.dart';
import 'package:foody/style/platformDetect/PlatformDetector.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:hive/hive.dart';
import 'package:firebase_app_check_web/firebase_app_check_web.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:universal_html/html.dart' as html;


void main() async {

  //Init google apis not need it
  // GoogleMap.init('.....................................');

  //Setup Sync Urls (Remove #)
  Vx.setPathUrlStrategy();




  //Binding Widgets
  //You only need to call this method if you need the binding to be initialized before calling
  WidgetsFlutterBinding.ensureInitialized();




  //Setup awesome notification lib
  if(PlatformDetector.isAndroid || PlatformDetector.isIOS)
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        'resource://drawable/res_app_icon',
        [
          NotificationChannel(
              channelKey: '11112222',
              channelName: 'Foody App',
              channelDescription: 'Interactive Food Order App',
              // defaultColor: AppColor.primaryColorLight,
              importance: NotificationImportance.High,
              channelShowBadge: true,
              ledColor: Colors.white
          )
        ],
        debug: true
    );




  //Init Stripe
  if(!PlatformDetector.isWeb)
    Stripe.publishableKey = '...........................................................................';





  //Init Hive
  Hive.init('/storeData');
  await Hive.openBox("foody");




  //init firebase
  print('is init firebase core');
  final fbApp =  await Firebase.initializeApp();













  //App Check Run
  var box = Hive.box('foody');
  bool isFirebaseAppCheckInitialized = box.get('isFirebaseAppCheckInitialized', defaultValue: false);







  //Hive database store status of AppCheck if running or not , when user open the website to first time , isFirebaseAppCheckInitialized is false
  //So activate the AppCheck just one time (throw error for multiple times) then make isFirebaseAppCheckInitialized true , then if user run
  //The website or refresh it won't crush , but there is a problem , if user close the browser or the website , and enter the website again
  //isFirebaseAppCheckInitialized is still false , so won't activate the AppCheck according to the condition , so we use (html.window.onBeforeUnload.listen)
  //it is listening if user close/refresh the website => change isFirebaseAppCheckInitialized to false , and this solve the issue.
  print(' isFirebaseAppCheckInitialized is : ${box.get('isFirebaseAppCheckInitialized', defaultValue: false)}');
  if(!isFirebaseAppCheckInitialized) {
    box.put('isFirebaseAppCheckInitialized', true);
    print(' ___isFirebaseAppCheckInitialized is  ${box.get('isFirebaseAppCheckInitialized', defaultValue: false)}');
    if (PlatformDetector.isWeb) {
      final appCheckWeb =  FirebaseAppCheckWeb(app: fbApp);
      await appCheckWeb.activate(webRecaptchaSiteKey: '..............................................');
    }
    else {
      if(FirebaseAppCheck.instance != null){
        await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: '......................................');
      }
    }
  }


  //Check if Website is closed !!!!
  html.window.onBeforeUnload.listen((event) {
    //Activate the AppCheck after the Website is closed in chrome
    box.put('isFirebaseAppCheckInitialized', false);
    print('change isFirebaseAppCheckInitialized to ${box.get('isFirebaseAppCheckInitialized', defaultValue: false)}');
    print('type: ${event.type}');
    print('bubbles: ${event.bubbles}');
    print('cancelable: ${event.cancelable}');
    print('composed: ${event.composed}');
    print('eventPhase: ${event.eventPhase}');
    print('isTrusted: ${event.isTrusted}');
  });



  //Licenses of google font to publish app
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('license_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['license_fonts'], license);
  });




  //Run App
  runApp(checkPlatform());
}



Widget checkPlatform() {

  if(PlatformDetector.isAndroid){
    //No need init opening Moor Database
    return AppBuilder().BuildAndroid;
  }
  else if(PlatformDetector.isIOS){
    //No need init opening Moor Database
    return Container();
  }
  else if(PlatformDetector.isWeb){
    return AppBuilder().buildWeb;
  }
  else if(PlatformDetector.isWindows){
    //import 'package:foody/moor/AdaptiveDatabase.dart';
    //Init Opening Moor Database    (Call this method inside code of Windows)
    // AdaptiveDatabase().openWindowsMoorDatabase();
    return Container();
  }
  else if(PlatformDetector.isMacOS){
    //No need init opening Moor Database
    return Container();
  }
  else if(PlatformDetector.isLinux){
    //import 'package:foody/moor/AdaptiveDatabase.dart';
    //Init Opening Moor Database    (Call this method inside code of linux)
    // AdaptiveDatabase().openLinuxMoorDatabase();
    return Container();
  }
  else
    return Container();  //Like Watch

}

