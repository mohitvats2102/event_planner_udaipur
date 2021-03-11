import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_planner_udaipur/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/event_builder.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String homeScreen = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  int _currentName = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (int i = 0; i < list.length; i++) result.add(handler(i, list[i]));

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF033249),
      drawer: Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(
            0xFFFF8038,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Color(0xFFFF8038)),
            onPressed: () {
              logout(context);
            },
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Event Planner',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: SafeArea(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      items: venueImgList.map(
                        (imgUrl) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 230,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      imgUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 60,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                    padding: EdgeInsets.all(5),
                                    width: 200,
                                    child: Text(
                                      venueImgName[_currentName],
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
                          setState(() {
                            _currentIndex = index;
                            _currentName = index;
                          });
                        },
                        initialPage: 0,
                        enlargeCenterPage: true,
                        height: 230,
                        autoPlay: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: map(
                        venueImgList,
                        (index, url) {
                          return Container(
                            height: 5,
                            width: 5,
                            margin: EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Color(0xFFFF8038)
                                  : Color(0xFFFFFFFF),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: GridView.builder(
                    itemCount: eventList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.39,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (ctx, index) {
                      return EventBuilder(eventList, index, eventName);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
