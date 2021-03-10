import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xFFFF8038),
        primaryColor: Color(0xFF033249),
        fontFamily: 'Montserrat',
      ),
      home: LoginScreen(),
      // Scaffold(
      //   appBar: AppBar(
      //     title: Text('Event Planner'),
      //     backgroundColor: Color(0xFF033249),
      //   ),
      //   body: Center(
      //     child: Text('Welcome To our New Project'),
      //   ),
      // ),
    );
  }
}
