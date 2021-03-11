import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  List<String> _imgList = [
    'https://www.holidify.com/blog/wp-content/uploads/2014/09/oberoi_udaivilas.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw9mnXXuzDOVJJpDLSRnsxOfPoxSV2ekV4Og&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmt0suRUymhkVqUiQ611Nr32z3SA26__0vOA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa-_ia1TGvY8gx72772Is4rNM3iKD-CJfPkQ&usqp=CAU',
  ];

  List<String> _eventList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_7fDZlJG3PI2xTGheTivTascs_zyT8U0ojg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzmQqyTj-NUh4nClx8dY-ZOBcjQgkkGyKwCg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlWuG4Y990Jd2p_jxurikSOXIGb52QgIM31g&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6t3AvBmwE-yakDSLOlaWW-L-_WndyNTAMfg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_-ruSk5N9omSfRSqxCp9CKKFfZm4KsoCC3g&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4U-BmDfpMue-4qgKxB1AFO-ijHc5DOWE31A&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSL_BBXjSEP8ZDGxxvBZkNywATF2rQXEPO9EA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRx9T18H95YIj5PxyBuNX3ZW6I1JCXEe-axtA&usqp=CAU',
  ];

  List<String> _imgName = [
    'Sundaram Garden',
    'Ashoka Garden',
    'Taquilla Restaurent',
    'GreenLand Hotel',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (int i = 0; i < list.length; i++) result.add(handler(i, list[i]));

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout(context);
            },
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Event Planner'),
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
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      items: _imgList.map(
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
                                      _imgName[_currentName],
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
                        _imgList,
                        (index, url) {
                          return Container(
                            height: 7,
                            width: 7,
                            margin: EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Color(0xFFFF8038)
                                  : Color(0xFF033249),
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
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: GridView.builder(
                    itemCount: _eventList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.39,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (ctx, index) {
                      return EventBuilder(_eventList, index);
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
