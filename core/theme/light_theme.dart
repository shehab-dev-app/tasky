import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(primaryContainer: Color(0xffFFFFFF)),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF6F7F9),
    titleTextStyle: TextStyle(color: Color(0xff161F1B), fontSize: 20),
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xff9E9E9E);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xff15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xffFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.black)),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color(0xff161F1B),
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),

    labelLarge: TextStyle(color: Colors.black, fontSize: 24),

    titleSmall: TextStyle(
      color: Color(0xff3A4640),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    titleMedium: TextStyle(
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    titleLarge: TextStyle(
      color: Color(0xff6A6A6A),
      fontWeight: FontWeight.w400,
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454F),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xff9E9E9E)),
    filled: true,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    fillColor: Color(0xFFFFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4),
    ),
    side: BorderSide(color: Color(0xffD1DAD6), width: 2),
  ),
  iconTheme: IconThemeData(color: Color(0xff161F1B)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xffFFFCFC),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  dividerTheme: DividerThemeData(color: Color(0xffD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionHandleColor: Colors.black,
    selectionColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xffF6F7F9),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xff3A4640),
    selectedItemColor: Color(0xff14A662),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xffF6F7F9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
    ),
    elevation: 2,
    shadowColor: Color(0xff15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Color(0xff161F1B),
      ),
    ),
  ),
);
