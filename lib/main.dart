import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_app_with_api/provider/auth/sing_in_provider.dart';
import 'package:sport_app_with_api/provider/auth/sing_up_provider.dart';
import 'package:sport_app_with_api/provider/home/home_provider.dart';
import 'package:sport_app_with_api/view/screens/get_start_screen.dart';
import 'package:sport_app_with_api/view/screens/splash_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SingUpProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SingInProvider(),
      ),
       ChangeNotifierProvider(
        create: (context) => HomeProvider(),),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
