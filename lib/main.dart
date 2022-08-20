// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanstonks/configs/instancebinding.dart';
import 'package:scanstonks/constants/color_code.dart';
import 'package:scanstonks/routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Scan Stonks',
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: kTitleTextColorDarkMode,
          ),
          bodySmall: GoogleFonts.openSans(
            fontSize: 14,
            height: 1.2,
            color: kTitleTextColorDarkMode,
          ),
          headlineMedium: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kTitleTextColorDarkMode,
          ),
        ),
      ),
      initialRoute: '/HOME',
      initialBinding: InstanceBinding(),
      getPages: routers,
    );
  }
}
