import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'router/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: const Color(0xFFa91145),
        statusBarIconBrightness: Brightness.light, 
        statusBarBrightness: Brightness.dark,       
      ),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TVK Grievance',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      routerConfig: appRouter,
      builder: (context, child) {
        return Container(
          color: const Color(0xFFa91145),
          child: SafeArea(
            bottom: false,
            child: child ?? const SizedBox(),
          ),
        );
      },
    );
  }
}