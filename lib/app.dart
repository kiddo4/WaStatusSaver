import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/Provider/bottom_nav_provider.dart';
import 'package:myapp/Provider/getStatusProvider.dart';
import 'package:myapp/Ui/Screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => GetStatusProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}