import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:event_planner_udaipur/constant.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class UserBookings extends StatefulWidget {
  static const String user_booking_route = '/user_booking_route';

  @override
  _UserBookingsState createState() => _UserBookingsState();
}

class _UserBookingsState extends State<UserBookings> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userUID;
  DocumentSnapshot _userDoc;
  List userBookingsIDs = [];
  bool _isNull = false;

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('can\'t make call');
    }
  }

  @override
  void didChangeDependencies() async {
    _isNull = false;
    // TODO: implement didChangeDependencies
    try {
      userUID = _auth.currentUser.uid;
      _userDoc = await _firestore.collection('users').doc(userUID).get();
      userBookingsIDs = _userDoc.data()['bookings'];
      if (userBookingsIDs.length == 0) _isNull = true;
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookings'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: _isNull
          ? Center(
              child: Text(
                'No bookings yet!!',
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('bookings')
                  .orderBy('startDate')
                  .snapshots(),
              builder: (ctx, asyncSnap) {
                if (asyncSnap.hasError) {
                  return Center(
                    child: Text('Something went Wrong'),
                  );
                }
                if (asyncSnap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kdarkTeal,
                    ),
                  );
                }
                List<QueryDocumentSnapshot> _userBookings = [];
                _userBookings = asyncSnap.data.docs.where((bookingId) {
                  return userBookingsIDs.contains(bookingId.id);
                }).toList();

                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Venue : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Owner : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _userBookings[i].data()['venue_name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: kdarkTeal,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _userBookings[i]
                                          .data()['VP_name']
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: kdarkTeal,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Divider(height: 1.5, color: kdarkTeal),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                    'FROM :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'TO :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat.yMd().format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                        (_userBookings[i].data()['startDate']
                                                as Timestamp)
                                            .microsecondsSinceEpoch,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: kdarkTeal,
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMd().format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                        (_userBookings[i].data()['endDate']
                                                as Timestamp)
                                            .microsecondsSinceEpoch,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: kdarkTeal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _userBookings[i].data()['startTime'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: kdarkTeal,
                                    ),
                                  ),
                                  Text(
                                    _userBookings[i].data()['endTime'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: kdarkTeal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Divider(height: 1.5, color: kdarkTeal),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Status : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: kdarkTeal,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _userBookings[i]
                                          .data()['status']
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color:
                                            _userBookings[i].data()['status'] ==
                                                    'pending'
                                                ? Colors.orange
                                                : _userBookings[i]
                                                            .data()['status'] ==
                                                        'accepted'
                                                    ? Colors.green
                                                    : Colors.red,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    primary: kdarkTeal),
                                onPressed: () {
                                  customLaunch('tel:+91 ' +
                                      _userBookings[i].data()['VP_contact']);
                                },
                                child: Text(
                                  'Call',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _userBookings.length,
                );
              },
            ),
    );
  }
}
