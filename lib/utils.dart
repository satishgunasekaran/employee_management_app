import 'package:flutter/material.dart';

// Themedata for login page

ThemeData themeData = ThemeData(
    primarySwatch: Colors.blue,
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(46, 49, 140, 1))),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(46, 49, 140, 1))),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(46, 49, 140, 1))),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(46, 49, 140, 1))),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(46, 49, 140, 1))),
    ));

// copyright icon
const IconData copyright = IconData(0xe198, fontFamily: 'MaterialIcons');

//footer

Padding footer = Padding(
  padding: EdgeInsets.all(8.0),
  child: Row(
    children: [
      Text(
        "                      Auto irrigation mobile app       ",
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
      // Icon(
      //   copyright,
      //   size: 20,
      // ),
      // Text(
      //   " All rights reserved",
      //   style: TextStyle(
      //     fontSize: 15.0,
      //   ),
      // )
    ],
  ),
);
