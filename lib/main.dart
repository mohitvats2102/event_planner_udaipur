import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_udaipur/providers/events.dart';
import 'package:event_planner_udaipur/screens/home_screen.dart';
import 'package:event_planner_udaipur/screens/user_detail_form.dart';
import 'package:event_planner_udaipur/screens/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './screens/event_venues_list.dart';
import './screens/venue_detail_screen.dart';
import 'screens/confirm_booking_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  User _firebaseUser = FirebaseAuth.instance.currentUser;
  if (_firebaseUser != null) {
    bool _doesContain = false;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot _usersCollection = await _firestore.collection('users').get();
    List<QueryDocumentSnapshot> _usersCollectionDOC = _usersCollection.docs;

    for (int i = 0; i < _usersCollectionDOC.length; i++) {
      if (_usersCollectionDOC[i].id == _firebaseUser.uid) {
        _doesContain = true;
      }
    }
    runApp(MyApp(doesContain: _doesContain));
  } else
    runApp(MyApp(doesContain: null));
}

class MyApp extends StatelessWidget {
  bool doesContain;
  MyApp({this.doesContain});
  User _firebaseUser = FirebaseAuth.instance.currentUser;
  Widget _firstWidget;
  @override
  Widget build(BuildContext context) {
    if (doesContain == null) {
      if (_firebaseUser == null) {
        _firstWidget = LoginScreen();
      } else {
        _firstWidget = HomeScreen();
      }
    } else {
      if (!doesContain) {
        _firstWidget = UserDetailForm();
      } else {
        _firstWidget = HomeScreen();
      }
    }
    return ChangeNotifierProvider(
      create: (ctx) => EventsData(),
      child: MaterialApp(
        title: 'Event Planner',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Color(0xFFFF8038),
          primaryColor: Color(0xFF033249),
          fontFamily: 'Montserrat',
        ),
        home: _firstWidget,
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
            case VenueDetailScreen.venueDetailScreen:
              return PageTransition(
                settings: settings,
                child: VenueDetailScreen(),
                curve: Curves.linear,
                type: PageTransitionType.rightToLeft,
              );
              break;
            case ConfirmBooking.confirmBookingScreen:
              return PageTransition(
                settings: settings,
                child: ConfirmBooking(),
                curve: Curves.linear,
                type: PageTransitionType.rightToLeft,
              );
              break;
            case UserProfile.userProfileScreen:
              return PageTransition(
                settings: settings,
                child: UserProfile(),
                curve: Curves.linear,
                type: PageTransitionType.rightToLeft,
              );
              break;
            case UserDetailForm.workerDetailForm:
              return PageTransition(
                settings: settings,
                child: UserDetailForm(),
                curve: Curves.linear,
                type: PageTransitionType.rightToLeft,
              );
              break;
            default:
              return null;
          }
        },
      ),
    );
  }
}

// StreamBuilder<User>(
// stream: FirebaseAuth.instance.authStateChanges(),
// builder: (ctx, userSnapShot) {
// if (userSnapShot.hasData) {
// return HomeScreen();
// }
// return LoginScreen();
// },
// )
