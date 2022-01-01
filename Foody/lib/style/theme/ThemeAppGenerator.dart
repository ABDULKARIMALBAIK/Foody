import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/style/color/AppColor.dart';
import 'package:foody/style/platformDetect/PlatformDetector.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeAppGenerator{

  static ThemeData get lightTheme{
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.primaryColorLight,
      primaryColorBrightness: Brightness.light,
      primaryColorLight: AppColor.primaryColorLight,
      primaryColorDark: AppColor.primaryColorDark,
      accentColor: AppColor.accentColorLight,
      accentColorBrightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.backgroundColorLight,
      bottomAppBarColor: AppColor.cardColorLight,
      cardColor: AppColor.cardColorLight,
      dialogBackgroundColor: AppColor.cardColorLight,
      indicatorColor: AppColor.primaryColorLight,
      hintColor: AppColor.textBodyColorLight,
      dividerColor: AppColor.textBodyColorLight,
      textTheme: TextTheme(
        headline1: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        headline2: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        headline3: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        headline4: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        headline5: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        headline6: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        bodyText1: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        bodyText2: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        subtitle1: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        subtitle2: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        button: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        caption: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        overline: GoogleFonts.montserrat(color: AppColor.textTitleColorLight)
      ),
      tabBarTheme: TabBarTheme(
        labelColor: AppColor.cardColorLight,
        unselectedLabelColor: AppColor.primaryColorLight
      ),
      iconTheme: IconThemeData(
        color: AppColor.textTitleColorLight
      ),
      primaryIconTheme: IconThemeData(
          color: AppColor.primaryColorLight
      ),
      accentIconTheme: IconThemeData(
          color: AppColor.accentColorLight
      ),
      chipTheme: ChipThemeData(
        brightness: Brightness.light,
        backgroundColor: AppColor.cardColorLight,
        disabledColor: AppColor.backgroundColorLight,
        selectedColor: AppColor.primaryColorLight,
        checkmarkColor: AppColor.textTitleColorDark,
        deleteIconColor: AppColor.textTitleColorDark,
        shadowColor: AppColor.primaryColorLight,
        labelStyle: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.normal,
        ),
        secondaryLabelStyle: TextStyle(),
        padding: EdgeInsets.all(8),
        secondarySelectedColor: AppColor.primaryColorLight
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.cardColorLight,
        elevation: 6,
        brightness: Brightness.light,
        actionsIconTheme: IconThemeData(
          color: AppColor.textTitleColorLight
        ),
        centerTitle: PlatformDetector.isIOS ? true : false,
        shadowColor: AppColor.textTitleColorLight,
        titleTextStyle: GoogleFonts.montserrat(color: AppColor.textTitleColorLight),
        toolbarTextStyle: GoogleFonts.montserrat(color: AppColor.textTitleColorLight)
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColor.backgroundColorLight,
        elevation: 8,
        modalBackgroundColor: AppColor.backgroundColorLight,
        modalElevation: 9
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor:  MaterialStateProperty.all(AppColor.cardColorLight),
        splashRadius: 8,
        mouseCursor: MaterialStateProperty.all(MouseCursor.defer),
        fillColor: MaterialStateProperty.all(AppColor.primaryColorLight),
        overlayColor: MaterialStateProperty.all(Colors.red[100])
      ),
      radioTheme: RadioThemeData(
          splashRadius: 8,
          mouseCursor: MaterialStateProperty.all(MouseCursor.defer),
          fillColor: MaterialStateProperty.all(AppColor.primaryColorLight),
          overlayColor: MaterialStateProperty.all(Colors.red[100])
      ),
      switchTheme:SwitchThemeData(
          thumbColor: MaterialStateProperty.all(AppColor.primaryColorLight),
          trackColor: MaterialStateProperty.all(Colors.red[100]),
          splashRadius: 8,
          mouseCursor: MaterialStateProperty.all(MouseCursor.defer),
          overlayColor: MaterialStateProperty.all(Colors.red[100])
      )
    );
  }

  static ThemeData get darkTheme{
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.primaryColorDark,
        primaryColorBrightness: Brightness.dark,
        primaryColorLight: AppColor.primaryColorLight,
        primaryColorDark: AppColor.primaryColorDark,
        accentColor: AppColor.accentColorDark,
        accentColorBrightness: Brightness.dark,
        scaffoldBackgroundColor: AppColor.backgroundColorDark,
        bottomAppBarColor: AppColor.cardColorDark,
        cardColor: AppColor.cardColorDark,
        dialogBackgroundColor: AppColor.cardColorDark,
        indicatorColor: AppColor.primaryColorDark,
        hintColor: AppColor.textBodyColorDark,
        textTheme: TextTheme(
            headline1: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            headline2: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            headline3: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            headline4: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            headline5: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            headline6: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            bodyText1: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            bodyText2: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            subtitle1: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            subtitle2: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            button: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            caption: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            overline: GoogleFonts.montserrat(color: AppColor.textTitleColorDark)
        ),
        tabBarTheme: TabBarTheme(
            labelColor: AppColor.cardColorDark,
            unselectedLabelColor: AppColor.primaryColorDark
        ),
        iconTheme: IconThemeData(
            color: AppColor.textTitleColorDark
        ),
        primaryIconTheme: IconThemeData(
            color: AppColor.primaryColorDark
        ),
        accentIconTheme: IconThemeData(
            color: AppColor.accentColorDark
        ),
        chipTheme: ChipThemeData(
            brightness: Brightness.light,
            backgroundColor: AppColor.cardColorDark,
            disabledColor: AppColor.backgroundColorDark,
            selectedColor: AppColor.primaryColorDark,
            checkmarkColor: AppColor.textTitleColorDark,
            deleteIconColor: AppColor.textTitleColorDark,
            shadowColor: AppColor.primaryColorLight,
            labelStyle: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            secondaryLabelStyle: TextStyle(),
            padding: EdgeInsets.all(8),
            secondarySelectedColor: AppColor.primaryColorLight
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: AppColor.cardColorDark,
            elevation: 6,
            brightness: Brightness.dark,
            actionsIconTheme: IconThemeData(
                color: AppColor.textTitleColorDark
            ),
            centerTitle: PlatformDetector.isIOS ? true : false,
            shadowColor: AppColor.textTitleColorLight,
            titleTextStyle: GoogleFonts.montserrat(color: AppColor.textTitleColorDark),
            toolbarTextStyle: GoogleFonts.montserrat(color: AppColor.textTitleColorDark)
        ),
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: AppColor.backgroundColorDark,
            elevation: 8,
            modalBackgroundColor: AppColor.backgroundColorDark,
            modalElevation: 8
        ),
        checkboxTheme: CheckboxThemeData(
            checkColor:  MaterialStateProperty.all(AppColor.cardColorLight),
            splashRadius: 8,
            mouseCursor: MaterialStateProperty.all(MouseCursor.defer),
            fillColor: MaterialStateProperty.all(AppColor.primaryColorDark),
            overlayColor: MaterialStateProperty.all(Colors.red[100])
        ),
        radioTheme: RadioThemeData(
            splashRadius: 8,
            mouseCursor: MaterialStateProperty.all(MouseCursor.defer),
            fillColor: MaterialStateProperty.all(AppColor.primaryColorDark),
            overlayColor: MaterialStateProperty.all(Colors.red[100])
        ),
        switchTheme:SwitchThemeData(
            thumbColor: MaterialStateProperty.all(AppColor.primaryColorDark),
            trackColor: MaterialStateProperty.all(Colors.red[100]),
            splashRadius: 8,
            mouseCursor: MaterialStateProperty.all(MouseCursor.defer),
            overlayColor: MaterialStateProperty.all(Colors.red[100])
        )
    );
  }
}