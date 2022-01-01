import 'package:firebase_auth/firebase_auth.dart';
class Common{

  static bool isDark = false;
  static User currentUser = FirebaseAuth.instance.currentUser as User;
  static String? firebaseMessagingToken = '';
  static bool isFirstTimeFirebaseMessaging = true;
  static int badgeCartCounter = 0;
  static bool isFirstTimeAppCheck = true;

}
