import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_udaipur/providers/events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../widgets/event_builder.dart';
import '../widgets/main_drawer.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String homeScreen = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoadingDone = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userImageUrl = '';
  String _userName = '';
  void logout(BuildContext context) async {
    if (_auth.currentUser.providerData != null) {
      if (_auth.currentUser.providerData[0].providerId == 'google.com') {
        print('In If BLOCK');
        await GoogleSignIn().disconnect();
      }
    }
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.loginScreen);
  }

  int _currentIndex = 0;

  List<QueryDocumentSnapshot> venueDoc;

  // List<T> map<T>(List list, Function handler) {
  //   List<T> result = [];
  //   for (int i = 0; i < list.length; i++) result.add(handler(i, list[i]));
  //
  //   return result;
  // }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    QuerySnapshot _collectionSnap =
        await _firestore.collection('trendingvenues').get();
    venueDoc = _collectionSnap.docs;
    setState(() {
      _isLoadingDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _userImageUrl = _auth.currentUser.photoURL ?? '';
    _userName = _auth.currentUser.displayName ?? '';
    return Scaffold(
      backgroundColor: Color(0xFF033249),
      drawer: MainDrawer(
        userName: _userName,
        imageUrl: _userImageUrl,
        logoutFun: logout,
        ctx: context,
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(
            0xFFFF8038,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Event Planner',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: _isLoadingDone
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Trending Venues',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Container(
                      child: Consumer<EventsData>(
                        builder: (ctx, event, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CarouselSlider(
                                items: venueDoc.map(
                                  (docSnap) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 230,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                docSnap.data()['image'],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 60,
                                            bottom: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                              ),
                                              padding: EdgeInsets.all(5),
                                              width: 200,
                                              child: Text(
                                                docSnap.data()['name'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.fade,
                                                softWrap: true,
                                              ),
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                                options: CarouselOptions(
                                  autoPlayInterval: Duration(seconds: 3),
                                  onPageChanged: (index, _) {
                                    //print('OUTPUT :- $index');
                                    // setState(() {
                                    //   _currentIndex = index;
                                    // });
                                    event.updateCarousel(_currentIndex, index);
                                  },
                                  initialPage: 0,
                                  enlargeCenterPage: true,
                                  height: 230,
                                  autoPlay: true,
                                ),
                              ),
                              SizedBox(height: 20),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: map(
                              //     venueDoc,
                              //     (index, url) {
                              //       return Container(
                              //         height: 5,
                              //         width: 5,
                              //         margin: EdgeInsets.symmetric(
                              //           horizontal: 2,
                              //           vertical: 10,
                              //         ),
                              //         decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: _currentIndex == index
                              //               ? Color(0xFFFF8038)
                              //               : Color(0xFFFFFFFF),
                              //         ),
                              //       );
                              //     },
                              //   ),
                              // ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Choose Your Event',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    GridOfEvents(_firestore),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(color: Color(0xFFFF8038)),
            ),
    );
  }
}

class GridOfEvents extends StatelessWidget {
  final FirebaseFirestore _firestore;

  GridOfEvents(this._firestore);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore.collection('events').get(),
      builder: (ctx, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.done) {
          if (asyncSnapshot.hasData) {
            List<QueryDocumentSnapshot> eventList = asyncSnapshot.data.docs;
            return Expanded(
              child: Container(
                child: GridView.builder(
                  itemCount: eventList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.39,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (ctx, index) {
                    return EventBuilder(eventList, index, eventList[index].id);
                  },
                ),
              ),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(color: Color(0xFFFF8038)),
        );
      },
    );
  }
}

// Expanded(
// child: Container(
// padding: EdgeInsets.only(bottom: 5),
// child: GridView.builder(
// itemCount: eventList.length,
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// childAspectRatio: 1.39,
// crossAxisSpacing: 5,
// mainAxisSpacing: 5,
// ),
// itemBuilder: (ctx, index) {
// return EventBuilder(eventList, index);
// },
// ),
// ),
// );
