import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Event Planner'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Text('Welcome To our New Project'),
        ),
      ),
    );
  }
}
