import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/style/platformDetect/PlatformDetector.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DataTemplate {  //Don't forget to change lottie images

  static int sizeWidth = 1300;

  static Widget noData(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // PlatformDetector.isWeb ?
          // SvgPicture.asset(
          //   'images/templateData/no_data.svg',
          //   width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   height: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   fit: BoxFit.fill,
          // )
          //     :
          // Lottie.asset(
          //   'lottie/no_data.json',
          //   width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   height: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   fit: BoxFit.fill,
          // ),
          // SizedBox(
          //   height: 18,
          // ),
          // Flexible(
          //   child: AutoSizeText(
          //       AppLocalizations.of(context)!.translate('templateData_noData'),
          //       style: Theme.of(context).textTheme.headline6!.copyWith(),
          //       minFontSize: 12,
          //       maxLines: 1,
          //       overflow: TextOverflow.ellipsis),
          // ),
        ],
      ),
    );
  }

  static Widget noInternet(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // PlatformDetector.isWeb ?
          // SvgPicture.asset(
          //   'images/templateData/no_internet.svg',
          //   width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   height: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   fit: BoxFit.fill,
          // )
          //     :
          // Lottie.asset(
          //   'lottie/no_internet.json',
          //   width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   height: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   fit: BoxFit.fill,
          // ),
          //
          // SizedBox(
          //   height: 18,
          // ),
          // Flexible(
          //   child: AutoSizeText(
          //       AppLocalizations.of(context)!.translate('templateData_noInternet'),
          //       style: Theme.of(context).textTheme.headline6!.copyWith(),
          //       minFontSize: 12,
          //       maxLines: 1,
          //       overflow: TextOverflow.ellipsis),
          // ),
        ],
      ),
    );
  }

  static Widget error(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // PlatformDetector.isWeb ?
          // SvgPicture.asset(
          //   'images/templateData/error.svg',
          //   width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   height: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   fit: BoxFit.fill,
          // )
          //     :
          // Lottie.asset(
          //   'lottie/error.json',
          //   width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   height: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   fit: BoxFit.fill,
          // ),
          //
          // SizedBox(
          //   height: 18,
          // ),
          // Flexible(
          //   child: AutoSizeText(
          //       AppLocalizations.of(context)!.translate('templateData_error'),
          //       style: Theme.of(context).textTheme.headline6!.copyWith(),
          //       minFontSize: 12,
          //       maxLines: 1,
          //       overflow: TextOverflow.ellipsis),
          // ),
        ],
      ),
    );
  }

  static Widget load(BuildContext context){
    print('is loading now');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlatformDetector.isWeb ?
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width > 700 ? MediaQuery.of(context).size.width/2 - 200: MediaQuery.of(context).size.width - 200,
              height: MediaQuery.of(context).size.width > 700 ? MediaQuery.of(context).size.width/2  - 200: MediaQuery.of(context).size.width - 200,
              child: Center(
                child: LiquidCircularProgressIndicator(
                  value: 0.50,
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  backgroundColor: Theme.of(context).cardColor, // Defaults to the current Theme's backgroundColor.
                  borderColor: Colors.red,
                  borderWidth: 0.3,
                  direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                  center: Text(
                    AppLocalizations.of(context)!.translate('templateData_load') ,
                    style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
            ),
          )
          // Image.asset(
          //   'lottie/gifs/loading.gif',
          //   width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   height: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
          //   fit: BoxFit.fill,
          // )
              :
          Lottie.asset(
            'lottie/loading.json',
            width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
            height: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
            fit: BoxFit.fill,
          ),

          SizedBox(
            height: 2,
          ),
          /////////////////////////////// * We don't need it * ///////////////////////////////
          // Flexible(
          //   child: AutoSizeText(
          //       AppLocalizations.of(context)!.translate('templateData_load'),
          //       style: Theme.of(context).textTheme.headline6!.copyWith(),
          //       minFontSize: 12,
          //       maxLines: 1,
          //       overflow: TextOverflow.ellipsis),
          // ),
        ],
      ),
    );
  }

  static Widget notFoundPage(BuildContext context){

    print('start load firebase storage not found page');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlatformDetector.isWeb ?
          FutureBuilder<String>(
            future: firebase_storage.FirebaseStorage.instance.ref('lottie/not_found_page.gif').getDownloadURL(),
            builder: (context , snapshot){
              return Image.network(
                snapshot.data.toString(),
                width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
                height: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
                fit: BoxFit.fill,
              );
            },
          )
              :
          Lottie.asset(
            'lottie/not_found_page.json',
            width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
            height: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width > sizeWidth ? 60 : 0),
            fit: BoxFit.fill,
          ),

          SizedBox(
            height: 18,
          ),
          Flexible(
            child: AutoSizeText(
                AppLocalizations.of(context)!.translate('templateData_not_found_page'),
                style: Theme.of(context).textTheme.headline6!.copyWith(),
                minFontSize: 12,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}