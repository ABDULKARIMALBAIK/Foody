import 'dart:convert';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:foody/bloc/blocUnit/AppBloc.dart';
import 'package:foody/bloc/blocUnit/SignIn/SignInCheckboxPravicyBloc.dart';
import 'package:foody/bloc/blocUnit/SignIn/SignInPasswordBloc.dart';
import 'package:foody/bloc/state/SignIn/SignInCheckboxPrivcyState.dart';
import 'package:foody/bloc/state/SignIn/SignInPasswordState.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/style/platformDetect/PlatformDetector.dart';
import 'package:foody/viewModel/SignInViewModel.dart';
import 'package:foody/widget/AnimatedButton.dart';
import 'package:foody/widget/AnimatedIconButton.dart';
import 'package:foody/widget/CrossAnimationButton.dart';
import 'package:g_captcha/g_captcha.dart';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class SignInAndroidMobilePortrait extends StatelessWidget {

  //Key Scaffold
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Init Controllers
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;
  late WebViewController webViewController;
  // late WebViewXController webviewController;


  //Build ViewModel
  late SignInViewModel viewModel;


  //Init Vars
  var darkMode;
  var arabicMode;
  bool isChecked = false;


  SignInAndroidMobilePortrait(){
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();

    viewModel = SignInViewModel();
  }



  @override
  Widget build(BuildContext context) {

    _scaffoldKey = GlobalKey<ScaffoldState>();

    //Init Hive
    var box = Hive.box('foody');
    darkMode = box.get('darkMode', defaultValue: false);
    arabicMode = box.get('arabicMode', defaultValue: false);
    print('isDark : ' + darkMode.toString());
    print('isEnglish : ' + arabicMode.toString());

    //Vars
    bool languageValue = arabicMode;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12 , vertical: 16),
            physics: ClampingScrollPhysics(),  //BouncingScrollPhysics , NeverScrollableScrollPhysics
            scrollDirection: Axis.vertical,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [

                //////////////////////// * Title * ////////////////////////
                Row(
                  children: [
                    Flexible(
                      child: AutoSizeText(
                          AppLocalizations.of(context)!.translate('signIn_title'),
                          style: Theme.of(context).textTheme.headline3!.copyWith(),
                          minFontSize: 12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),


                //////////////////////// * Themes & Languages * ////////////////////////
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Row(
                    children: [


                      //Dark /Light Themes
                      DayNightSwitcherIcon(
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

                      SizedBox(width:10,),

                      //Arabic /English Languages
                      AnimatedToggleSwitch<bool>.dual(
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),




                //////////////////////// * Lottie Gif * ////////////////////////
                Center(
                  child: Lottie.asset(
                    'lottie/sign_in.json',
                    repeat: true,
                    width: (MediaQuery.of(context).size.width / 2)  + 100,
                    height: (MediaQuery.of(context).size.width / 2)  + 100,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),



                //////////////////////// * Subtitle * ////////////////////////
                Row(
                  children: [
                    Flexible(
                      child: AutoSizeText(
                          AppLocalizations.of(context)!.translate('signIn_subtitle'),
                          style: Theme.of(context).textTheme.bodyText1!.copyWith( color: Theme.of(context).hintColor),
                          minFontSize: 8,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),


                //////////////////////// * Container for all the data * ////////////////////////
                Container(
                  width: 450,
                  child: AutofillGroup(
                    child: Column(
                      children: [

                        //////////////////////// * Email TextField * ////////////////////////
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                          child: Row(
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                    AppLocalizations.of(context)!.translate('signIn_TitleEmailTextField'),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                                    minFontSize: 18,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                        emailTextField(_controllerEmail,context),
                        SizedBox(
                          height: 15,
                        ),




                        //////////////////////// * Password TextField * ////////////////////////
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                          child: Row(
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                    AppLocalizations.of(context)!.translate('signIn_TitlePasswordTextField'),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                                    minFontSize: 18,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                        passwordTextField(_controllerPassword),
                        SizedBox(
                          height: 30,
                        ),





                        //////////////////////// * Card of captcha * ////////////////////////
                        (PlatformDetector.isAndroid || PlatformDetector.isIOS) ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //////////////////////// * Recaptcha * ////////////////////////
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: CrossAnimationButton(50 , 180, 1.2, Curves.easeInOut, 400, Theme.of(context).primaryColor, Theme.of(context).primaryColor, Theme.of(context).cardColor, Theme.of(context).primaryColor, Theme.of(context).primaryColor, Theme.of(context).cardColor, AppLocalizations.of(context)!.translate('checkout_button_showCaptcha') ,
                                        () async {
                                      String tokenResult = await GCaptcha.reCaptcha('6LeNsL0cAAAAADpULOuS7pjpVc90E5VawvEMlAjK');
                                      print('tokenResult: $tokenResult');
                                      //Then send the token to backend and get the result (success ot not)

                                    })
                            ),

                            //////////////////////// * hcaptcha * ////////////////////////
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: Container(
                                  color: Theme.of(context).cardColor,
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  child: WebView(
                                    // initialUrl: "webpages/hcaptcha_recaptcha_foody.html",
                                    javascriptMode: JavascriptMode.unrestricted,
                                    javascriptChannels: Set.from([
                                      JavascriptChannel(
                                          name: 'Captcha',
                                          onMessageReceived: (JavascriptMessage message) {
                                            // message contains the 'h-captcha-response' token.
                                            // Send it to your server in the login or other
                                            // data for verification via /siteverify
                                            // see: https://docs.hcaptcha.com/#server
                                            // print(message.message);
                                            print('captcha : ${message.message}');
                                          })
                                    ]),
                                    onWebViewCreated: (WebViewController w) async{

                                      webViewController = w;
                                      String fileText = await rootBundle.loadString('webpages/hcaptcha_recaptcha_foody.html');

                                      print('fileText $fileText');

                                      webViewController.loadUrl(Uri.dataFromString(
                                          fileText,
                                          mimeType: 'text/html',
                                          encoding: Encoding.getByName('utf-8')
                                      ).toString());

                                    },
                                  ),
                                )
                            ),
                          ],
                        ) : Container(),







                        //////////////////////// * Sign in button * ////////////////////////
                        Center(
                          child: AnimatedButton(Theme.of(context).primaryColor ,  AppLocalizations.of(context)!.translate('signIn_title') ,
                            () => viewModel.signIn(context, _scaffoldKey, _controllerEmail.text, _controllerPassword.text, isChecked)),
                        ),
                        SizedBox(
                          height: 30,
                        ),




                        //////////////////////// * Privacy Policy etc * ////////////////////////
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            children: [

                              //////////////////////// * CheckBox * ////////////////////////
                              BlocProvider<SignInCheckboxPrivcyBloc>(
                                create: (context) => SignInCheckboxPrivcyBloc(),
                                child: BlocBuilder<SignInCheckboxPrivcyBloc,SignInCheckboxPrivcyState>(
                                    buildWhen: (oldState,newState) => oldState != newState,
                                    builder: (context,state){

                                      isChecked = state.isCheckedPrivcyConditions;
                                      print('check value :' + isChecked.toString());

                                      return GlowCheckbox(
                                          color: Theme.of(context).primaryColor,
                                          value: state.isCheckedPrivcyConditions,
                                          onChange: (bool) => context.read<SignInCheckboxPrivcyBloc>().update(!state.isCheckedPrivcyConditions)
                                      );
                                    }
                                ),
                              ),
                              SizedBox(width: 12,),



                              //////////////////////// * PrivacyPolicy and Conditions_Terms * ////////////////////////
                              Expanded(
                                child: Wrap(
                                  children: [
                                    AutoSizeText(
                                      AppLocalizations.of(context)!.translate('signIn_privacy_1'),
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic),
                                      minFontSize: 6,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        url_launcher.canLaunch('URL_privacy_policy').then((value){
                                          if(value)
                                            url_launcher.launch('URL_privacy_policy');
                                        });
                                      },
                                      child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('signIn_privacy_2'),
                                        style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300,fontStyle: FontStyle.italic , decoration:  TextDecoration.underline,  decorationColor: Theme.of(context).primaryColor,),
                                        minFontSize: 6,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    AutoSizeText(
                                      AppLocalizations.of(context)!.translate('signIn_privacy_3'),
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic),
                                      minFontSize: 6,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // AutoSizeText.rich(
                                    //     TextSpan(
                                    //         children: [
                                    //
                                    //
                                    //         ]
                                    //     ),
                                    //     style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic),
                                    //     minFontSize: 6,
                                    //     maxLines: 1,
                                    //     overflow: TextOverflow.ellipsis),
                                    GestureDetector(
                                      onTap: (){
                                        url_launcher.canLaunch('URL_conditions_terms').then((value){
                                          if(value)
                                            url_launcher.launch('URL_conditions_terms');
                                        });
                                      },
                                      child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('signIn_privacy_4'),
                                        style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300,fontStyle: FontStyle.italic , decoration:  TextDecoration.underline,  decorationColor: Theme.of(context).primaryColor,),
                                        minFontSize: 6,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    AutoSizeText(
                                      AppLocalizations.of(context)!.translate('signIn_privacy_5'),
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic),
                                      minFontSize: 6,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),





                        //////////////////////// * OR Divider * ////////////////////////
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(child: Center(child: Divider(thickness: 1,height: 3, color: Theme.of(context).hintColor,))),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: AutoSizeText(
                                  AppLocalizations.of(context)!.translate('global_or'),
                                  style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).hintColor),
                                  minFontSize: 8,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Expanded(child: Center(child: Divider(thickness: 1,height: 3, color: Theme.of(context).hintColor,))),
                          ],
                        ),





                        //////////////////////// * Google Sign In * ////////////////////////
                        SizedBox(
                          height: 20,
                        ),
                        AnimatedIconButton(
                            320,
                            50,
                            darkMode ? Colors.purpleAccent : Colors.purple,
                            'images/socialMedia/google.svg',
                            'images/socialMedia/google.svg',
                            'signIn_google_title',
                            Theme.of(context).shadowColor.withOpacity(0.7),
                            darkMode ? Colors.purpleAccent : Colors.purple,
                                () => viewModel.signInGoogleMobile(context, _scaffoldKey)
                        ),




                        //////////////////////// * Facebook Sign In * ////////////////////////
                        SizedBox(
                          height: 20,
                        ),
                        AnimatedIconButton(
                            320,
                            50,
                            Color(0xFF005BFF),
                            'images/socialMedia/facebook_white.svg',   //images/socialMedia/facebook.svg
                            'images/socialMedia/facebook_white.svg',
                            'signIn_facebook_title',
                            Colors.white,
                            darkMode ? Color(0xFF005BFF) : Color(0xFF005BFF),
                                () => viewModel.signInFacebookMobile(context, _scaffoldKey)
                        ),





                        //////////////////////// * Microsoft Sign In * ////////////////////////
                        SizedBox(
                          height: 20,
                        ),
                        AnimatedIconButton(
                            320,
                            50,
                            darkMode ? Colors.lightGreen : Colors.green,
                            'images/socialMedia/microsoft.svg',
                            'images/socialMedia/microsoft.svg',
                            'signIn_microsoft_title',
                            Theme.of(context).shadowColor.withOpacity(0.7),
                            darkMode ? Colors.lightGreen : Colors.green,
                                () => viewModel.signInMicrosoftMobile(context, _scaffoldKey)
                        ),



                        //////////////////////// * Sign Up Navigation * ////////////////////////
                        SizedBox(height: 60,),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(
                                  AppLocalizations.of(context)!.translate('signIn_go_sign_up'),
                                  softWrap: true,
                                  style: Theme.of(context).textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),

                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pushNamed(Routers.signUpRoute);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.translate('signUp_title'),
                                    // softWrap: true,
                                    style: Theme.of(context).textTheme.caption!.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        shadows: [
                                          Shadow(
                                              color: Theme.of(context).primaryColor,
                                              offset: Offset(0,0),
                                              blurRadius: 6
                                          )
                                        ]
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )




                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget emailTextField(TextEditingController _controllerEmail , BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 0),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
          width: 450,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: TextField(
            enableSuggestions: true,
            readOnly: false,
            textInputAction: TextInputAction.next,
            // textAlign: AppLocalizations.of(context)!.isEnLocale
            //     ? TextAlign.start
            //     : TextAlign.end,
            // textDirection: AppLocalizations.of(context)!.isEnLocale
            //     ? TextDirection.ltr
            //     : TextDirection.rtl,

            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            // maxLengthEnforced: true,
            // maxLength: 100,
            autofocus: false,
            autocorrect: true,
            cursorColor: Theme.of(context).primaryColor,
            controller: _controllerEmail,
            autofillHints: [AutofillHints.email],
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.translate('signIn_hintEmailTextField'),
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColor,
                ),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  // color: Theme.of(context).primaryColor,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  color: Theme.of(context).dividerColor,
                  onPressed: () => _controllerEmail.clear(),
                )
            ),
          )
      ),
    );
  }

  Widget passwordTextField(TextEditingController controllerPassword) {

    return BlocProvider<SignInPasswordBloc>(
      create: (context) => SignInPasswordBloc(),
      child: BlocBuilder<SignInPasswordBloc, SignInPasswordState>(
          buildWhen: (oldState,newState) => oldState != newState,
          builder: (context,state){

            // print('start check');
            // print('(state.isPasswordVisible) : ${state.isPasswordVisible}');

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 0),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                  width: 450,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextField(
                    enableSuggestions: true,
                    readOnly: false,
                    textInputAction: TextInputAction.done,
                    // textAlign: arabicMode
                    //     ? TextAlign.end
                    //     : TextAlign.start,
                    // textDirection:  arabicMode
                    //     ? TextDirection.rtl
                    //     : TextDirection.ltr,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    // maxLengthEnforced: true,
                    // maxLength: 100,
                    autofocus: false,
                    autocorrect: true,
                    obscureText: !state.isPasswordVisible ,
                    cursorColor: Theme.of(context).primaryColor,
                    controller: controllerPassword,
                    autofillHints: [AutofillHints.password],
                    style: Theme.of(context).textTheme.bodyText1,
                    onEditingComplete: () => TextInput.finishAutofillContext(),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.translate('signIn_hintPasswordTextField'),
                      icon: Icon(
                        Icons.vpn_key,
                        color: Theme.of(context).primaryColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(state.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        color: Theme.of(context).primaryColor,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onPressed: () => context.read<SignInPasswordBloc>().update(!state.isPasswordVisible),
                      ),
                      border: InputBorder.none,
                    ),
                  )),
            );
          }
      ),
    );
  }

}