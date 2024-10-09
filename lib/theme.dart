import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';


var colorGrid = <Color>[
  const Color(0xFFF77545), // Pantone 16-1546 Living Coral
  const Color(0xFFDD4132), // Pantone 17-1564 Fiesta
  const Color(0xFFDC793A), // Pantone 15-1263 Mango Mojito
  const Color(0xFF5F4B8B), // Pantone 18-3838 Ultra Violet
  const Color(0xFF0F4C81), // Pantone 19-4052 Classic Blue
  const Color(0xFF57A773), // Pantone 14-5711 Forest Biome
  const Color(0xFFCF3E53), // Pantone 18-1662 Cherry Tomato
  const Color(0xFFF6E05E), // Pantone 13-0647 Meadowlark
  const Color(0xFF6DAEDB), // Pantone 16-4132 Little Boy Blue
  const Color(0xFFE03F8A) // Pantone 18-2045 Pink Peacock
];

var mainTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.black,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 24,
      color: Colors.white,
    ),
  ),
  // primaryTextTheme: TextTheme(),
  // This is the theme of your application.
  //
  // TRY THIS: Try running your application with "flutter run". You'll see
  // the application has a purple toolbar. Then, without quitting the app,
  // try changing the seedColor in the colorScheme below to Colors.green
  // and then invoke "hot reload" (save your changes or press the "hot
  // reload" button in a Flutter-supported IDE, or press "r" if you used
  // the command line to start the app).
  //
  // Notice that the counter didn't reset back to zero; the application
  // state is not lost during the reload. To reset the state, use hot
  // restart instead.
  //
  // This works for code too, not just values: Most code changes can be
  // tested with just a hot reload.
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
);