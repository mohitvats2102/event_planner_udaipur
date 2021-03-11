import 'package:event_planner_udaipur/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import './screens/event_venues_list.dart';
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
      home: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapShot) {
          if (userSnapShot.hasData) {
            return HomeScreen();
          }
          return LoginScreen();
        },
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomeScreen.homeScreen:
            return PageTransition(
              child: HomeScreen(),
              curve: Curves.linear,
              type: PageTransitionType.bottomToTop,
            );
            break;
          case LoginScreen.loginScreen:
            return PageTransition(
              child: LoginScreen(),
              curve: Curves.linear,
              type: PageTransitionType.topToBottom,
            );
            break;
          case VenueList.venueScreen:
            return PageTransition(
              settings: settings,
              child: VenueList(),
              curve: Curves.linear,
              type: PageTransitionType.rightToLeft,
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}
