import 'package:core_exam_two/utils/colors.dart';
import 'package:core_exam_two/view/screens/home%20screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CoreExamApp());
}

class CoreExamApp extends StatefulWidget {
  const CoreExamApp({super.key});

  @override
  State<CoreExamApp> createState() => _CoreExamAppState();
}

class _CoreExamAppState extends State<CoreExamApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        appBarTheme: AppBarTheme(
          color: secondaryColor,
          foregroundColor: primaryColor,
        )
      ),
      home: const HomeScreen(),


    );
  }
}
