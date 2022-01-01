

import 'package:universal_platform/universal_platform.dart';

class PlatformDetector {
  static bool get isAndroid => UniversalPlatform.isAndroid;
  static bool get isIOS => UniversalPlatform.isIOS;
  static bool get isWeb => UniversalPlatform.isWeb;
  static bool get isWindows => UniversalPlatform.isWindows;
  static bool get isMacOS => UniversalPlatform.isMacOS;
  static bool get isLinux => UniversalPlatform.isLinux;
  static bool get isFuchsia => UniversalPlatform.isFuchsia;
}