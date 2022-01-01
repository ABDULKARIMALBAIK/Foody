import 'dart:io';
import 'dart:typed_data';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:camera/camera.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foody/bloc/blocUnit/AnimatedButtonBloc.dart';
import 'package:foody/bloc/blocUnit/AppBloc.dart';
import 'package:foody/bloc/blocUnit/SignIn/SignInCheckboxPravicyBloc.dart';
import 'package:foody/bloc/blocUnit/SignIn/SignInPasswordBloc.dart';
import 'package:foody/bloc/blocUnit/SignUp/SignUpPickImageBloc.dart';
import 'package:foody/bloc/blocUnit/SignUp/StrongPasswordBloc.dart';
import 'package:foody/bloc/state/AnimatedButtonState.dart';
import 'package:foody/bloc/state/SignIn/SignInCheckboxPrivcyState.dart';
import 'package:foody/bloc/state/SignIn/SignInPasswordState.dart';
import 'package:foody/bloc/state/SignUp/SignUpPickImageState.dart';
import 'package:foody/bloc/state/SignUp/StrongPasswordState.dart';
import 'package:foody/constant/Util.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/style/platformDetect/PlatformDetector.dart';
import 'package:foody/viewModel/SignUpViewModel.dart';
import 'package:foody/widget/AnimatedButton.dart';
import 'package:foody/widget/AnimatedIconButton.dart';
import 'package:foody/widget/CrossAnimationButton.dart';
import 'package:foody/widget/SnakBarBuilder.dart';
import 'package:g_captcha/g_captcha.dart';
import 'package:hive/hive.dart';
import 'package:image_cropping/constant/enums.dart';
import 'package:image_cropping/image_cropping.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:url_launcher/link.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;



class SignUpWebTablet extends StatelessWidget{


  //Hide keyboard when launch page
  // FocusScope.of(context).unfocus();

  //Init Controllers
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _controllerName = TextEditingController();
  var _controllerPhone = TextEditingController();
  var _controllerAddress = TextEditingController();
  late DropzoneViewController dropzoneViewController;


  //Init Blocs
  StrongPasswordBloc strongPassword = StrongPasswordBloc();
  SignUpPickImageBloc pickedFileBloc = SignUpPickImageBloc();
  AnimatedButtonBloc dropBloc = AnimatedButtonBloc();
  late BuildContext globalPickImageContext;
  late SignUpPickImageState globalPickImageState;


  //Check Item Privacy
  bool isChecked = false;

  //Init ViewModel
  SignUpViewModel viewModel = SignUpViewModel();


  //Key Scaffold
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  //Init vars
  var darkMode;
  var arabicMode;
  late Uint8List pickedFile;
  String pathImage = '';
  bool isPickedImage = false;


  @override
  Widget build(BuildContext context) {


    //Init Hive
    var box = Hive.box('foody');
    darkMode = box.get('darkMode', defaultValue: false);
    arabicMode = box.get('arabicMode', defaultValue: false);
    print('isDark : ' + darkMode.toString());
    print('isEnglish : ' + arabicMode.toString());


    //Vars
    bool languageValue = arabicMode;



    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12 , vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  //////////////////////// * Title * ////////////////////////
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Flexible(
                          child: AutoSizeText(
                              AppLocalizations.of(context)!
                                  .translate('signUp_title'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
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
                    height: 12,
                  ),




                  //////////////////////// * Themes & Languages * ////////////////////////
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12 , horizontal: 16),
                    child:  Container(
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
                  ),
                  SizedBox(
                    height: 25,
                  ),




                  //////////////////////// * Lottie Gif * ////////////////////////
                  Center(
                    child: SvgPicture.asset(
                      'images/sign_up.svg',
                      width: (MediaQuery.of(context).size.width / 2) + 30,
                      height: (MediaQuery.of(context).size.width / 2) + 30,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // Center(
                  //   child: Image.asset(
                  //     'lottie/gifs/sign_up.gif',
                  //     width: (MediaQuery.of(context).size.width / 2) + 30,
                  //     height: (MediaQuery.of(context).size.width / 2) + 30 ,
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                  SizedBox(
                    height: 25,
                  ),




                  //////////////////////// * Subtitle * ////////////////////////
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: AutoSizeText(
                              AppLocalizations.of(context)!
                                  .translate('signUp_subtitle'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Theme.of(context).dividerColor),
                              minFontSize: 18,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,    //45
                  ),




                  //////////////////////// * Container to text fields etc * ////////////////////////
                  Container(
                    width: 450,
                    child: AutofillGroup(
                      child: Column(
                        children: [


                          //////////////////////// * Display Image * ////////////////////////
                          Center(
                              child: BlocProvider<SignUpPickImageBloc>.value(
                                value: pickedFileBloc,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    //Image item
                                    BlocBuilder<SignUpPickImageBloc , SignUpPickImageState>(
                                      buildWhen: (oldState,newState) => oldState != newState,
                                      builder: (context , state){


                                        globalPickImageContext = context;
                                        globalPickImageState = state;



                                        return WidgetCircularAnimator(
                                          innerColor: Theme.of(context).accentColor,
                                          outerColor: Theme.of(context).primaryColor,
                                          // size: ,  //Default is 200
                                          // outerAnimation: ,  //Default is Curve.linear
                                          // innerAnimation: ,  //Default is Curve.linear
                                          child: Container(
                                              decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).cardColor),
                                              child: state.isPicked ?
                                              ClipOval(
                                                child: Image.memory(
                                                    state.pickedImage,
                                                    filterQuality: FilterQuality.high,
                                                    fit: BoxFit.cover
                                                ),
                                              )
                                                  :
                                              Icon(
                                                Icons.person_outline,
                                                color: Theme.of(context).primaryColor,
                                                size: 60,
                                              )
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 15,),



                                    //Buttons items
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        //Pick Gallery
                                        MaterialButton(
                                          mouseCursor: SystemMouseCursors.basic,
                                          color: Theme.of(context).cardColor,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          elevation: 10,
                                          onPressed: () async{

                                            print('pick from gallery');
                                            await pickImage(context , ImageSource.gallery);

                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: AutoSizeText(
                                                AppLocalizations.of(context)!.translate('signUp_button_image_pickGallery'),
                                                style: Theme.of(context).textTheme.bodyText2!.copyWith(),
                                                minFontSize: 10,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis
                                            ),
                                          ),
                                        ),


                                        SizedBox(width: 12,),


                                        //Pick Camera
                                        MaterialButton(
                                          mouseCursor: SystemMouseCursors.basic,
                                          color: Theme.of(context).cardColor,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          elevation: 10,
                                          onPressed: () async{


                                            if(PlatformDetector.isAndroid || PlatformDetector.isIOS){
                                              print('pick from camera');
                                              await pickImage(context , ImageSource.camera);

                                            }
                                            else if(PlatformDetector.isWeb){

                                              print('pick from camera');
                                              final cameras = await availableCameras();


                                              print('available camera is finished , get first Camera');
                                              final firstCamera = cameras.first;
                                              CameraController cameraController = CameraController(firstCamera , ResolutionPreset.high);


                                              print('get first Camera is finished , start init to take a photo');
                                              cameraController.initialize().then((value){
                                                try{
                                                  cameraController.takePicture().then((image) async{
                                                    if(image == null){
                                                      print('image is null');
                                                      return;
                                                    }


                                                    //Crop Image
                                                    print('start crop image ');
                                                    ImageCropping.cropImage(
                                                      context,
                                                      await image.readAsBytes(),
                                                          () {
                                                        //Add flutter_easyloading: ^3.0.3 package
                                                        //EasyLoading.show(status: 'Loading...');
                                                      },
                                                          () {
                                                        //flutter_easyloading: ^3.0.3 package
                                                        //EasyLoading.dismiss();
                                                      },
                                                          (croppedImage) async {


                                                        print('image length is : ');
                                                        globalPickImageContext.read<SignUpPickImageBloc>().pickImage(croppedImage, image.path);  //await image.readAsBytes()

                                                        print('save image data in bloc');
                                                        pickedFile = croppedImage;  //await image.readAsBytes()
                                                        isPickedImage = true;
                                                        pathImage = image.path;


                                                        //Close camera



                                                      },
                                                      selectedImageRatio: ImageRatio.RATIO_1_1,
                                                      visibleOtherAspectRatios: true,
                                                      squareBorderWidth: 2,
                                                      squareCircleColor: Theme.of(context).primaryColor,
                                                      defaultTextColor: Theme.of(context).textTheme.subtitle1!.color as Color,
                                                      selectedTextColor: Theme.of(context).primaryColor,
                                                      colorForWhiteSpace: Theme.of(context).scaffoldBackgroundColor,
                                                    );


                                                  });
                                                }
                                                catch(e){
                                                  print('some error when take a photo ???\n $e');
                                                }

                                              });


                                            }
                                            //Version windows and macos is not ready




                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: AutoSizeText(
                                                AppLocalizations.of(context)!.translate('signUp_button_image_pickCamera'),
                                                style: Theme.of(context).textTheme.bodyText2!.copyWith(),
                                                minFontSize: 10,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                    SizedBox(height: 30,),



                                    //Drag and drop zone item
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 25),
                                      child: BlocProvider<AnimatedButtonBloc>.value(
                                        value: dropBloc,
                                        child: BlocBuilder<AnimatedButtonBloc , AnimatedButtonState>(
                                          buildWhen: (oldState , newState) => oldState != newState,
                                          builder: (contextDrop , stateDrop){

                                            return ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width/2,
                                                height: 320,
                                                padding: const EdgeInsets.all(10),
                                                color: !stateDrop.touched ? (darkMode ? Colors.green[300] : Colors.green[500]) : (darkMode? Colors.red[300] : Colors.red[500]) ,
                                                child: DottedBorder(
                                                  borderType: BorderType.RRect,
                                                  color: Colors.white,
                                                  strokeWidth: 3,
                                                  padding: EdgeInsets.zero,
                                                  dashPattern: [8 , 4],
                                                  radius: Radius.circular(10),
                                                  child: Stack(
                                                    children: [

                                                      //Drop widget
                                                      Container(
                                                        width: MediaQuery.of(context).size.width/2,
                                                        height: 320,
                                                        child: DropzoneView(
                                                          operation: DragOperation.copy,
                                                          cursor: CursorType.Default,
                                                          onError: (String? s) => print('error happened !!!!\n $s'),
                                                          onHover: () => contextDrop.read<AnimatedButtonBloc>().update(true),
                                                          onLeave: () => contextDrop.read<AnimatedButtonBloc>().update(false),
                                                          onLoaded: () => contextDrop.read<AnimatedButtonBloc>().update(false),
                                                          onCreated: (controller) => dropzoneViewController = controller,
                                                          onDrop: (dynamic event) async{


                                                            //Test the file
                                                            final name = event.name;
                                                            final mime = await dropzoneViewController.getFileMIME(event);
                                                            final bytes = await dropzoneViewController.getFileSize(event);
                                                            final url = await dropzoneViewController.createFileUrl(event);

                                                            print('Name: $name');
                                                            print('Mime: $mime');
                                                            print('Bytes: $bytes');
                                                            print('Url: $url');



                                                            //Also can pick files !!!
                                                            //dropzoneViewController.pickFiles();



                                                            //Crop Image
                                                            print('start crop image ');
                                                            ImageCropping.cropImage(
                                                              context,
                                                              await dropzoneViewController.getFileData(event),
                                                                  () {
                                                                //Add flutter_easyloading: ^3.0.3 package
                                                                //EasyLoading.show(status: 'Loading...');
                                                              },
                                                                  () {
                                                                //flutter_easyloading: ^3.0.3 package
                                                                //EasyLoading.dismiss();
                                                              },
                                                                  (croppedImage) async {


                                                                //Change state
                                                                globalPickImageContext.read<SignUpPickImageBloc>().pickImage(croppedImage, url);  //await dropzoneViewController.getFileData(event)

                                                                pickedFile = croppedImage;  //await dropzoneViewController.getFileData(event)
                                                                isPickedImage = true;
                                                                pathImage = url;



                                                              },
                                                              selectedImageRatio: ImageRatio.RATIO_1_1,
                                                              visibleOtherAspectRatios: true,
                                                              squareBorderWidth: 2,
                                                              squareCircleColor: Theme.of(context).primaryColor,
                                                              defaultTextColor: Theme.of(context).textTheme.subtitle1!.color as Color,
                                                              selectedTextColor: Theme.of(context).primaryColor,
                                                              colorForWhiteSpace: Theme.of(context).scaffoldBackgroundColor,
                                                            );



                                                          },
                                                        ),
                                                      ),



                                                      //Upload image and text
                                                      Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(Icons.cloud_upload , color: Colors.white , size: 80),
                                                            SizedBox(height: 8),
                                                            Text(
                                                              AppLocalizations.of(context)!.translate('signUp_text_drop_upload_image'),
                                                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                                                              textAlign: TextAlign.center,
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                            )
                                                          ],
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30,),


                                  ],
                                ),
                              )),










                          //////////////////////// * Email TextField * ////////////////////////
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 2),
                            child: Row(
                              children: [
                                AutoSizeText(
                                    AppLocalizations.of(context)!.translate('signUp_TitleEmailTextField'),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                                    minFontSize: 18,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          emailTextField(_controllerEmail,context),
                          SizedBox(
                            height: 15,
                          ),



                          //////////////////////// * Password TextField * ////////////////////////
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 2),
                            child: Row(
                              children: [
                                AutoSizeText(
                                    AppLocalizations.of(context)!.translate('signUp_TitlePasswordTextField'),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                                    minFontSize: 18,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: BlocProvider<StrongPasswordBloc>.value(
                              value: strongPassword,
                              child: BlocBuilder<StrongPasswordBloc,StrongPasswordState>(
                                buildWhen: (oldState,newState) => oldState != newState,
                                builder: (context,state){
                                  return Column(

                                    children: [
                                      passwordTextField(context,state,_controllerPassword),
                                      SizedBox(
                                        height: 0,
                                      ),


                                      //////////////////////// * Generate strong password * ////////////////////////
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/2,
                                          height: 70,
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            // crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                              _generateButton(_controllerPassword,context,state),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Center(
                                                    child: AutoSizeText(
                                                        state.typeName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6!
                                                            .copyWith(color: state.colorName),
                                                        minFontSize: 10,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0,
                                      ),


                                      // Padding(
                                      //   padding: EdgeInsets.symmetric(horizontal: 12),
                                      //   child: StepProgressIndicator(
                                      //     totalSteps: 100,
                                      //     currentStep: state.setperValue,
                                      //     size: 8,
                                      //     padding: 0,
                                      //     selectedColor:  darkMode ? Colors.orange[300]! : Colors.orange[500]!,
                                      //     unselectedColor: Colors.white70,
                                      //     roundedEdges: Radius.circular(36),
                                      //     selectedGradientColor: LinearGradient(
                                      //       begin: Alignment.topLeft,
                                      //       end: Alignment.bottomRight,
                                      //       colors: [Colors.red , Colors.yellowAccent , Colors.blue, Colors.green],
                                      //     ),
                                      //     unselectedGradientColor: LinearGradient(
                                      //       begin: Alignment.topLeft,
                                      //       end: Alignment.bottomRight,
                                      //       colors: [Colors.grey, Colors.white12],
                                      //     ),
                                      //   ),
                                      // )

                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),






                          //////////////////////// * Username TextField * ////////////////////////
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 2),
                            child: Row(
                              children: [
                                AutoSizeText(
                                    AppLocalizations.of(context)!.translate('signUp_TitleUsernameTextField'),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                                    minFontSize: 18,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          nameTextField(_controllerName,context),
                          SizedBox(
                            height: 15,
                          ),






                          //////////////////////// * Phone TextField * ////////////////////////
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 2),
                            child: Row(
                              children: [
                                AutoSizeText(
                                    AppLocalizations.of(context)!.translate('signUp_TitlePhoneTextField'),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                                    minFontSize: 18,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          phoneTextField(_controllerPhone,context),
                          SizedBox(
                            height: 15,
                          ),





                          //////////////////////// * Address TextField * ////////////////////////
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 2),
                            child: Row(
                              children: [
                                AutoSizeText(
                                    AppLocalizations.of(context)!.translate('signUp_TitleAddressTextField'),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                                    minFontSize: 18,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          addressTextField(_controllerAddress,context),
                          SizedBox(
                            height: 30,
                          ),





                          //////////////////////// * Card of captcha * ////////////////////////
                          (PlatformDetector.isAndroid || PlatformDetector.isIOS) ?
                          //////////////////////// * reCaptcha to android/ios * ////////////////////////
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: CrossAnimationButton(50 , 140, 1.2, Curves.easeInOut, 400, Theme.of(context).primaryColor, Theme.of(context).primaryColor, Theme.of(context).cardColor, Theme.of(context).primaryColor, Theme.of(context).primaryColor, Theme.of(context).cardColor, AppLocalizations.of(context)!.translate('checkout_button_showCaptcha') ,
                                      () async {
                                    String tokenResult = await GCaptcha.reCaptcha('.........................................');
                                    print('tokenResult: $tokenResult');
                                    //Then send the token to backend and get the result (success ot not)

                                  })
                          )
                              :
                          //////////////////////// * reCaptcha to web * ////////////////////////
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child:  Container(
                                color: Theme.of(context).cardColor,
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                child: Builder(
                                  builder: (context) {

                                    String createdViewId = 'map_element';

                                    // ignore:undefined_prefixed_name
                                    ui.platformViewRegistry.registerViewFactory(
                                        createdViewId,
                                            (int viewId) => html.IFrameElement()
                                          ..width = MediaQuery.of(context).size.width.toString()
                                          ..height = 300.toString()
                                          ..srcdoc = """<!DOCTYPE html><html>
                                                                  <head>
                                                                    <title>reCAPTCHA</title>
                                                                    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
                                                                  </head>
                                                                  <body>
                                                                    <div style='height: 0px;'></div>
                                                                    <form action="?" method="POST">
                                                                      <div class="g-recaptcha" 
                                                                        data-sitekey="................................"
                                                                        data-callback="captchaCallback"></div>
                                                                
                                                                    </form>
                                                                    <script>
                                                                      function captchaCallback(response){
                                                                        //console.log(response);
                                                                        alert(response);
                                                                        if(typeof Captcha!=="undefined"){
                                                                          Captcha.postMessage(response);
                                                                        }
                                                                      }
                                                                    </script>
                                                                  </body>
                                                                </html>"""
                                          ..style.border = 'none');

                                    return  Container(
                                      color: Theme.of(context).cardColor,
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      child: HtmlElementView(
                                        viewType: createdViewId,
                                      ),
                                    );

                                  },
                                ),
                              )
                          ),






                          //////////////////////// * Sign up button * ////////////////////////
                          Link(
                            target: LinkTarget.self,
                            uri: Uri.parse(Routers.foodsRoute),
                            builder: (context , followLink) => AnimatedButton(Theme.of(context).primaryColor, AppLocalizations.of(context)!.translate('signUp_title'),
                                    () async{
                                  //Check if user picked a photo or not ?
                                  isPickedImage ?
                                  viewModel.signUp(context, _scaffoldKey, _controllerEmail.text, _controllerPassword.text, _controllerName.text , _controllerPhone.text , _controllerAddress.text , isChecked , pickedFile)
                                      :
                                  SnakBarBuilder.buildAwesomeSnackBar(
                                      context,
                                      AppLocalizations.of(context)!.translate('signUp_button_snackBar_pick_image'),
                                      Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                      AwesomeSnackBarType.error);
                                  // _scaffoldKey.currentState!.showSnackBar(
                                  //     SnakBarBuilder.build(
                                  //         context,
                                  //         SelectableText(
                                  //           AppLocalizations.of(context)!.translate('signUp_button_snackBar_pick_image'),
                                  //           cursorColor: Theme.of(context).primaryColor,
                                  //         ),
                                  //         AppLocalizations.of(context)!.translate('global_ok'),
                                  //             () {print('yes');})
                                  // );
                                }
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),






                          //////////////////////// * Privacy Policy etc * ////////////////////////
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [

                                //////////////////////// * CheckBox * ////////////////////////
                                BlocProvider<SignInCheckboxPrivcyBloc>(
                                  create: (context) => SignInCheckboxPrivcyBloc(),
                                  child: BlocBuilder<SignInCheckboxPrivcyBloc,SignInCheckboxPrivcyState>(
                                      buildWhen: (oldState,newState) => oldState != newState,
                                      builder: (context,state){

                                        isChecked = context.select((SignInCheckboxPrivcyBloc bloc) => bloc.state.isCheckedPrivcyConditions);

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
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Link(
                                          uri: Uri(path: '/privacy_policy'),
                                          target: LinkTarget.blank,
                                          builder: (context , followLink) => AutoSizeText(
                                            AppLocalizations.of(context)!.translate('signIn_privacy_2'),
                                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300,fontStyle: FontStyle.italic , decoration:  TextDecoration.underline,  decorationColor: Theme.of(context).primaryColor,
                                            ),
                                            minFontSize: 6,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
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
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Link(
                                          uri: Uri(path: '/conditions_terms'),
                                          target: LinkTarget.blank,
                                          builder: (context,followLink) => AutoSizeText(
                                            AppLocalizations.of(context)!.translate('signIn_privacy_4'),
                                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300,fontStyle: FontStyle.italic , decoration:  TextDecoration.underline,  decorationColor: Theme.of(context).primaryColor,),
                                            minFontSize: 6,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
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
                          Link(
                            target: LinkTarget.self,
                            uri: Uri.parse(Routers.foodsRoute),
                            builder: (context , followLink) => AnimatedIconButton(
                                320,
                                50,
                                darkMode ? Colors.purpleAccent : Colors.purple,
                                'images/socialMedia/google.svg',
                                'images/socialMedia/google.svg',
                                'signIn_google_title',
                                Theme.of(context).shadowColor.withOpacity(0.7),
                                darkMode ? Colors.purpleAccent : Colors.purple,
                                    () async{
                                  isPickedImage ?
                                  viewModel.signUpGoogleWeb(context, _scaffoldKey , pickedFile)
                                      :
                                  SnakBarBuilder.buildAwesomeSnackBar(
                                      context,
                                      AppLocalizations.of(context)!.translate('signUp_button_snackBar_pick_image'),
                                      Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                      AwesomeSnackBarType.error);
                                  // _scaffoldKey.currentState!.showSnackBar(
                                  //     SnakBarBuilder.build(
                                  //         context,
                                  //         SelectableText(
                                  //           AppLocalizations.of(context)!.translate('signUp_button_snackBar_pick_image'),
                                  //           cursorColor: Theme.of(context).primaryColor,
                                  //         ),
                                  //         AppLocalizations.of(context)!.translate('global_ok'),
                                  //             () {print('yes');})
                                  // );
                                }
                            ),
                          ),




                          //////////////////////// * Facebook Sign In * ////////////////////////
                          SizedBox(
                            height: 20,
                          ),
                          Link(
                            target: LinkTarget.self,
                            uri: Uri.parse(Routers.foodsRoute),
                            builder: (context,followLink) => AnimatedIconButton(
                                320,
                                50,
                                Color(0xFF005BFF),
                                'images/socialMedia/facebook_white.svg',
                                'images/socialMedia/facebook_white.svg',
                                'signIn_facebook_title',
                                Colors.white,
                                darkMode ? Color(0xFF005BFF) : Color(0xFF005BFF),
                                    () async{
                                  isPickedImage ?
                                  viewModel.signUpFacebookWeb(context, _scaffoldKey , pickedFile)
                                      :
                                  SnakBarBuilder.buildAwesomeSnackBar(
                                      context,
                                      AppLocalizations.of(context)!.translate('signUp_button_snackBar_pick_image'),
                                      Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                      AwesomeSnackBarType.error);
                                  // _scaffoldKey.currentState!.showSnackBar(
                                  //     SnakBarBuilder.build(
                                  //         context,
                                  //         SelectableText(
                                  //           AppLocalizations.of(context)!.translate('signUp_button_snackBar_pick_image'),
                                  //           cursorColor: Theme.of(context).primaryColor,
                                  //         ),
                                  //         AppLocalizations.of(context)!.translate('global_ok'),
                                  //             () {print('yes');})
                                  // );
                                }
                            ),
                          ),






                          //////////////////////// * Microsoft Sign In * ////////////////////////
                          SizedBox(
                            height: 20,
                          ),
                          Link(
                            target: LinkTarget.self,
                            uri: Uri.parse(Routers.foodsRoute),
                            builder: (context , followLink) => AnimatedIconButton(
                                320,
                                50,
                                darkMode ? Colors.lightGreen : Colors.green,
                                'images/socialMedia/microsoft.svg',
                                'images/socialMedia/microsoft.svg',
                                'signIn_microsoft_title',
                                Theme.of(context).shadowColor.withOpacity(0.7),
                                darkMode ? Colors.lightGreen : Colors.green,
                                    () async{
                                  isPickedImage ?
                                  viewModel.signUpMicrosoftWeb(context, _scaffoldKey , pickedFile)
                                      :
                                  SnakBarBuilder.buildAwesomeSnackBar(
                                      context,
                                      AppLocalizations.of(context)!.translate('signUp_button_snackBar_pick_image'),
                                      Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                      AwesomeSnackBarType.error);
                                  // _scaffoldKey.currentState!.showSnackBar(
                                  //     SnakBarBuilder.build(
                                  //         context,
                                  //         SelectableText(
                                  //           AppLocalizations.of(context)!.translate('signUp_button_snackBar_pick_image'),
                                  //           cursorColor: Theme.of(context).primaryColor,
                                  //         ),
                                  //         AppLocalizations.of(context)!.translate('global_ok'),
                                  //             () {print('yes');})
                                  // );

                                }
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),


                        ],
                      ),
                    ),
                  )




                ],
              ),
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
          )),
    );
  }

  Widget passwordTextField(BuildContext context , StrongPasswordState strongPasswordState , TextEditingController controllerPassword) {

    return BlocProvider<SignInPasswordBloc>(
      create: (context) => SignInPasswordBloc(),
      child: BlocBuilder<SignInPasswordBloc, SignInPasswordState>(
          buildWhen: (oldState,newState) => oldState != newState,
          builder: (context,state){
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
                    obscureText: !state.isPasswordVisible ,
                    cursorColor: Theme.of(context).primaryColor,
                    controller: controllerPassword,
                    onChanged: (value){
                      // controllerPassword.text = value;
                      _checkStrongPassword(context, strongPasswordState, controllerPassword.text, context);
                    },
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

  Widget nameTextField(TextEditingController controllerName , BuildContext context) {

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
            keyboardType: TextInputType.name,
            maxLines: 1,
            // maxLengthEnforced: true,
            // maxLength: 100,
            autofocus: false,
            autocorrect: true,
            cursorColor: Theme.of(context).primaryColor,
            controller: controllerName,
            autofillHints: [AutofillHints.username],
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.translate('signUp_hintUsernameTextField'),
                icon: Icon(
                  Icons.person_outline,
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
          )),
    );
  }

  Widget phoneTextField(TextEditingController controllerPhone, BuildContext context) {

    var box = Hive.box('foody');
    var darkMode = box.get('darkMode', defaultValue: false);

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
          child: IntlPhoneField(
            // enableSuggestions: true,
            readOnly: false,
            textInputAction: TextInputAction.next,
            // textAlign: AppLocalizations.of(context)!.isEnLocale
            //     ? TextAlign.start
            //     : TextAlign.end,
            // textDirection: AppLocalizations.of(context)!.isEnLocale
            //     ? TextDirection.ltr
            //     : TextDirection.rtl,
            keyboardType: TextInputType.phone,
            countryCodeTextColor: Theme.of(context).primaryColor,
            dropDownArrowColor: Theme.of(context).primaryColor,
            initialCountryCode: 'EN',
            keyboardAppearance: darkMode ? Brightness.dark : Brightness.light,
            onChanged: (phone) => controllerPhone.text = phone.completeNumber,
            // maxLines: 1,
            // maxLengthEnforced: true,
            // maxLength: 100,
            autofocus: false,
            // autocorrect: true,
            // cursorColor: Theme.of(context).primaryColor,
            // controller: controllerPhone,
            style: Theme.of(context).textTheme.bodyText1,
            // autofillHints: [AutofillHints.telephoneNumberCountryCode],
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.translate('signUp_hintPhoneTextField'),
              icon: Icon(
                Icons.phone,
                color: Theme.of(context).primaryColor,
              ),
              border: InputBorder.none,
            ),
          )),
    );
  }

  Widget addressTextField(TextEditingController controllerAddress , BuildContext context) {

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
            textInputAction: TextInputAction.done,
            // textAlign: AppLocalizations.of(context)!.isEnLocale
            //     ? TextAlign.start
            //     : TextAlign.end,
            // textDirection: AppLocalizations.of(context)!.isEnLocale
            //     ? TextDirection.ltr
            //     : TextDirection.rtl,
            keyboardType: TextInputType.streetAddress,
            maxLines: 1,
            // maxLengthEnforced: true,
            // maxLength: 100,
            autofocus: false,
            autocorrect: true,
            cursorColor: Theme.of(context).primaryColor,
            controller: controllerAddress,
            autofillHints: [AutofillHints.addressCityAndState],
            style: Theme.of(context).textTheme.bodyText1,
            onEditingComplete: () => TextInput.finishAutofillContext(),
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.translate('signUp_hintAddressTextField'),
                icon: Icon(
                  Icons.location_on_outlined,
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
          )),
    );
  }

  Widget _generateButton(TextEditingController _controllerPassword,BuildContext strongPasswordContext,StrongPasswordState strongPasswordState) {
    return BlocProvider<AnimatedButtonBloc>(
      create: (context) => AnimatedButtonBloc(),
      child: BlocBuilder<AnimatedButtonBloc, AnimatedButtonState>(

        buildWhen: (oldState, newState) => oldState != newState,
        builder: (context, state) => MouseRegion(
          onEnter: (value) {
            context.read<AnimatedButtonBloc>().update(true);
            // setState(() {
            //   touched = true;
            //   print(touched);
            // });
          },
          onExit: (value) {
            context.read<AnimatedButtonBloc>().update(false);
            // setState(() {
            //   touched = false;
            //   print(touched);
            // });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 180),
            curve: Curves.ease,
            height: state.touched ? 35 + 10 : 35,  //50 : 40
            width: state.touched ? 150 + 10 : 150,   //260 : 250
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: !state.touched
                ? [
                BoxShadow(
                  color:  Colors.orange,
                  offset: Offset(0.0, 3.0),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
                ]
                    : [
                BoxShadow(
                color: Colors.orange.withOpacity(0.7),
            offset: Offset(0.0, 3.0),
            blurRadius: 7.0,
            spreadRadius: 2.0,
          ),
          ],
        ),
        child: Material(
          color: darkMode ? Colors.orange[300] : Colors.orange[500], // state.touched ? widget.color : widget.color.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14.0),
            onTap: (){
              _controllerPassword.text = Util.generateStrongPassword();
              _checkStrongPassword(strongPasswordContext, strongPasswordState,  _controllerPassword.text , context);
            },
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Icon(Icons.whatshot_outlined,size: 20,color: Colors.white,),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: AutoSizeText(
                        AppLocalizations.of(context)!.translate('signUp_generatePasswordTitle'),
                        style: state.touched ?
                        Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white) :
                        Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                        minFontSize: 8,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    ),
    );
  }

  void _checkStrongPassword(BuildContext strongPasswordContext , StrongPasswordState strongPasswordState , String password,BuildContext context) {

    if (password.isEmpty){
      strongPasswordContext.read<StrongPasswordBloc>().updateStepValue(0);
      strongPasswordContext.read<StrongPasswordBloc>().updateTypeName(AppLocalizations.of(context)!.translate('signUp_generate_password_empty'));
      strongPasswordContext.read<StrongPasswordBloc>().updateColorName(Colors.blue);
    }
    else if (password.contains(' ')){
      strongPasswordContext.read<StrongPasswordBloc>().updateStepValue(0);
      strongPasswordContext.read<StrongPasswordBloc>().updateTypeName(AppLocalizations.of(context)!.translate('signUp_generate_password_remove_whitespaces'));
      strongPasswordContext.read<StrongPasswordBloc>().updateColorName(Colors.red);
    }
    else if (password.length < 8){
      strongPasswordContext.read<StrongPasswordBloc>().updateStepValue(25);
      strongPasswordContext.read<StrongPasswordBloc>().updateTypeName(AppLocalizations.of(context)!.translate('signUp_generate_password_bad'));
      strongPasswordContext.read<StrongPasswordBloc>().updateColorName(Colors.pink);
    }
    else {
      if (password.contains(RegExp(r"[a-z]")) || password.contains(RegExp(r"[A-Z]"))){
        strongPasswordContext.read<StrongPasswordBloc>().updateStepValue(50);
        strongPasswordContext.read<StrongPasswordBloc>().updateTypeName(AppLocalizations.of(context)!.translate('signUp_generate_password_good'));
        strongPasswordContext.read<StrongPasswordBloc>().updateColorName(Colors.amber);
      }
      if (password.contains(RegExp(r"[0-9]"))){
        strongPasswordContext.read<StrongPasswordBloc>().updateStepValue(50);
        strongPasswordContext.read<StrongPasswordBloc>().updateTypeName(AppLocalizations.of(context)!.translate('signUp_generate_password_good'));
        strongPasswordContext.read<StrongPasswordBloc>().updateColorName(Colors.amber);
      }
      if (password.contains(RegExp(r'[!@#\$%^&*(),.?:{}[]|<>]'))){
        strongPasswordContext.read<StrongPasswordBloc>().updateStepValue(50);
        strongPasswordContext.read<StrongPasswordBloc>().updateTypeName(AppLocalizations.of(context)!.translate('signUp_generate_password_good'));
        strongPasswordContext.read<StrongPasswordBloc>().updateColorName(Colors.amber);
      }
      if (
      (password.contains(RegExp(r"[a-z]")) || password.contains(RegExp(r"[A-Z]"))) &&
          password.contains(RegExp(r"[0-9]"))){

        strongPasswordContext.read<StrongPasswordBloc>().updateStepValue(75);
        strongPasswordContext.read<StrongPasswordBloc>().updateTypeName(AppLocalizations.of(context)!.translate('signUp_generate_password_excellent'));
        strongPasswordContext.read<StrongPasswordBloc>().updateColorName(Colors.greenAccent);
      }
      if (
      (password.contains(RegExp(r"[a-z]")) || password.contains(RegExp(r"[A-Z]"))) &&
          password.contains(RegExp(r'[!@#\$%^&*(),.?:{}[]|<>]'))){

        strongPasswordContext.read<StrongPasswordBloc>().updateStepValue(75);
        strongPasswordContext.read<StrongPasswordBloc>().updateTypeName(AppLocalizations.of(context)!.translate('signUp_generate_password_excellent'));
        strongPasswordContext.read<StrongPasswordBloc>().updateColorName(Colors.greenAccent);
      }
      if (
      password.contains(RegExp(r"[a-z]")) &&
          password.contains(RegExp(r'[!@#\$%^&*(),.?:{}[]|<>]'))){

        strongPasswordContext.read<StrongPasswordBloc>().updateStepValue(75);
        strongPasswordContext.read<StrongPasswordBloc>().updateTypeName(AppLocalizations.of(context)!.translate('signUp_generate_password_excellent'));
        strongPasswordContext.read<StrongPasswordBloc>().updateColorName(Colors.greenAccent);
      }
      if (
      (password.contains(RegExp(r"[a-z]")) || password.contains(RegExp(r"[A-Z]"))) &&
          password.contains(RegExp(r"[0-9]")) &&
          password.contains(RegExp(r'[!@#\$%^&*(),.?:{}[]|<>]'))){

        strongPasswordContext.read<StrongPasswordBloc>().updateStepValue(100);
        strongPasswordContext.read<StrongPasswordBloc>().updateTypeName(AppLocalizations.of(context)!.translate('signUp_generate_password_strong'));
        strongPasswordContext.read<StrongPasswordBloc>().updateColorName(Colors.green);
      }
    }
  }


  pickImage(BuildContext context, ImageSource source) async{

    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image == null)
        return;

      //Some times in android version crush because the file is save temporary, so use other approach
      // final imageTemporary = File(image.path);



      //Crop Image
      print('start crop image ');
      ImageCropping.cropImage(
        context,
        await image.readAsBytes(),
            () {
          //Add flutter_easyloading: ^3.0.3 package
          //EasyLoading.show(status: 'Loading...');
        },
            () {
          //flutter_easyloading: ^3.0.3 package
          //EasyLoading.dismiss();
        },
            (croppedImage) async {

          print('finish crop image');

          print('image path is : ${image.path}');
          globalPickImageContext.read<SignUpPickImageBloc>().pickImage(croppedImage , image.path);  //await image.readAsBytes()

          pickedFile = croppedImage;   //await image.readAsBytes();
          isPickedImage = true;
          pathImage = image.path;

          //This method can't use it because path_provider isn't supported in web so commented here //////////
          // final imagePermanent = await saveImagePermanently(image.path);
          // print('image path is : ${image.path}');
          //context.read<SignUpPickImageBloc>().pickImage(imagePermanent, image.path);


        },
        selectedImageRatio: ImageRatio.RATIO_1_1,
        visibleOtherAspectRatios: true,
        squareBorderWidth: 2,
        squareCircleColor: Theme.of(context).primaryColor,
        defaultTextColor: Theme.of(context).textTheme.subtitle1!.color as Color,
        selectedTextColor: Theme.of(context).primaryColor,
        colorForWhiteSpace: Theme.of(context).scaffoldBackgroundColor,
      );




    }
    on PlatformException catch(e){
      print('failed to pick image maybe because he maybe denied the permission : $e');
    }

  }
  Future<File> saveImagePermanently(String imagePath) async{

    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);

  }
}