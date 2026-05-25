import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xff181818),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(primaryContainer: Color(0xff282828)),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff181818),
    titleTextStyle: TextStyle(color: Color(0xfffffcfc), fontSize: 20),
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
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
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xffFFFCFC)),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xffFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color(0xffFFFCFC),
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: 16),

    labelLarge: TextStyle(color: Colors.white, fontSize: 24),
    titleMedium: TextStyle(
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: Color(0xffC6C6C6),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    titleLarge: TextStyle(
      color: Color(0xffA0A0A0),
      fontWeight: FontWeight.w400,
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xffA0A0A0),
      overflow: TextOverflow.ellipsis,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xff6D6D6D)),
    filled: true,
    fillColor: Color(0xFF282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4),
    ),
    side: BorderSide(color: Color(0xff6E6E6E), width: 2),
  ),
  iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xffFFFCFC),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  dividerTheme: DividerThemeData(color: Color(0xff6E6E6E)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionHandleColor: Colors.white,
    selectionColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xff181818),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xffC6C6C6),
    selectedItemColor: Color(0xff15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xff181818),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
      side: BorderSide(color: Color(0xff15B86C), width: 1),
    ),
    elevation: 2,
    shadowColor: Color(0xff15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Color(0xffFFFCFC),
      ),
    ),
  ),
);
