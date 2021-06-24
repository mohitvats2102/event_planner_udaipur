import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_udaipur/constant.dart';
import 'package:flutter/material.dart';

import '../screens/venue_detail_screen.dart';

class VenueList extends StatefulWidget {
  static const String venueScreen = '/venue_screen';

  @override
  _VenueListState createState() => _VenueListState();
}

class _VenueListState extends State<VenueList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List _routeArgs;
  List _venueArray = [];
  bool _isVenueArrayEmpty;
  @override
  void didChangeDependencies() async {
    _routeArgs = ModalRoute.of(context).settings.arguments as List;
    String _eventDocID = _routeArgs[3];
    DocumentSnapshot _selectedEventDoc =
        await _firestore.collection('events').doc(_eventDocID).get();
    _venueArray = _selectedEventDoc.data()['venueArray'];

    if (_venueArray.length == 0)
      _isVenueArrayEmpty = true;
    else
      _isVenueArrayEmpty = false;

    setState(() {});

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size _deviceSize = MediaQuery.of(context).size;
    _routeArgs = ModalRoute.of(context).settings.arguments as List;
    var themeCtx = Theme.of(context);
    String _eventName = _routeArgs[0];
    int _index = _routeArgs[1];
    String _eventImage = _routeArgs[2];

    return Scaffold(
      backgroundColor: themeCtx.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(
          right: 5,
          left: 5,
          bottom: 5,
          top: 5,
        ),
        child: Stack(
          children: [
            Container(),
            Container(
              height: _deviceSize.height * 0.35,
              width: _deviceSize.width,
              child: Hero(
                tag: _index,
                child: Image.network(
                  _eventImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(right: 10),
                color: Colors.black26,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, size: 25),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: themeCtx.accentColor,
                    ),
                    Text(
                      _eventName,
                      style: TextStyle(
                          color: themeCtx.accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                  color: Color(0xFF033249),
                ),
                height: _deviceSize.height * 0.67,
                width: _deviceSize.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        bottom: 10,
                      ),
                      child: Text(
                        'Venues',
                        style: TextStyle(
                          color: themeCtx.accentColor,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    _isVenueArrayEmpty != null
                        ? _isVenueArrayEmpty
                            ? Center(
                                child: Text('Coming Soon...'),
                              )
                            : FutureBuilder<QuerySnapshot>(
                                future: _firestore
                                    .collection('venues')
                                    .orderBy('name')
                                    .get(),
                                builder: (ctx, asynSnapshot) {
                                  if (asynSnapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (asynSnapshot.hasData) {
                                      List<QueryDocumentSnapshot> venuesList =
                                          asynSnapshot.data.docs.where((docId) {
                                        return _venueArray.contains(docId.id);
                                      });

                                      return Expanded(
                                        child: Container(
                                          child: ListView.builder(
                                            itemCount: venuesList.length,
                                            itemBuilder: (ctx, i) {
                                              return Card(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                                elevation: 30,
                                                color: themeCtx.primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    15,
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: Hero(
                                                        child: ClipRRect(
                                                          child: Image.network(
                                                            venuesList[i]
                                                                    .data()[
                                                                'image'],
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                                        ),
                                                        tag: venuesList[i]
                                                            .data()['image'],
                                                      ),
                                                      width: double.infinity,
                                                      height: 200,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        right: 10,
                                                        left: 10,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            child: FittedBox(
                                                              child: Text(
                                                                venuesList[i]
                                                                        .data()[
                                                                    'name'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: themeCtx
                                                                      .accentColor,
                                                                ),
                                                              ),
                                                            ),
                                                            width: _deviceSize
                                                                    .width *
                                                                0.41,
                                                          ),
                                                          RaisedButton.icon(
                                                            elevation: 0,
                                                            textColor: themeCtx
                                                                .accentColor,
                                                            color: themeCtx
                                                                .primaryColor,
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                VenueDetailScreen
                                                                    .venueDetailScreen,
                                                                arguments: [
                                                                  i,
                                                                  venuesList[i],
                                                                  venuesList[i].id,
                                                                ],
                                                              );
                                                            },
                                                            label: Text(
                                                              'View Details',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            icon: Icon(Icons
                                                                .arrow_forward),
                                                          )
                                                        ],
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
