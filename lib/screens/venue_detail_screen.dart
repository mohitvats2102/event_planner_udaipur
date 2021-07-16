import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_udaipur/screens/confirm_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class VenueDetailScreen extends StatelessWidget {
  static const String venueDetailScreen = '/venue_detail_screen';

  @override
  Widget build(BuildContext context) {
    ThemeData _themeCtx = Theme.of(context);
    Size _deviceSize = MediaQuery.of(context).size;
    List<dynamic> _dataFromPreviousScreen =
        ModalRoute.of(context).settings.arguments as List<dynamic>;
    int _index = _dataFromPreviousScreen[0];
    QueryDocumentSnapshot _doc = _dataFromPreviousScreen[1];
    String _venueDocId = _dataFromPreviousScreen[2];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(
            0xFFFF8038,
          ),
        ),
        title: Text(
          _doc.data()['name'],
          style: TextStyle(
            color: Color(
              0xFFFF8038,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: _themeCtx.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            height: _deviceSize.height * 0.27,
            child: Hero(
              tag: _doc.data()['image'],
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image.network(
                  _doc.data()['image'],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: Text(
              'More Views',
              style: TextStyle(
                color: Color(0xFFFF8038),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          if (_doc.data()['moreVenueImages'] != null)
            Container(
              width: double.infinity,
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: (_doc.data()['moreVenueImages'] as List<dynamic>).map(
                  (imgUrl) {
                    return Container(
                      width: _deviceSize.width * 0.35,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 0.5,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          SizedBox(height: 10),
          Expanded(
            child: Card(
              //margin: EdgeInsets.symmetric(horizontal: 10),
              elevation: 30,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: _themeCtx.accentColor.withOpacity(0.9),
              //color: Colors.white,
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 10,
                  right: 10,
                ),
                height: _deviceSize.height * 0.4,
                width: double.infinity,
                child: ListView(
                  children: [
                    Text(
                      'Available Rooms : ${_doc.data()['rooms'].toString()}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _themeCtx.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 2,
                      // endIndent: 20,
                      color: _themeCtx.primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ratings : ${_doc.data()['rating'].toString()} ⭐',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _themeCtx.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 2,
                      //endIndent: 20,
                      color: _themeCtx.primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Address : ${_doc.data()['address']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _themeCtx.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 2,
                      // endIndent: 20,
                      color: _themeCtx.primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description : ${_doc.data()['description']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _themeCtx.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 2,
                      // endIndent: 20,
                      color: _themeCtx.primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Charges for 1 day : ${_doc.data()['charges24']} ₹',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _themeCtx.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 2,
                      // endIndent: 20,
                      color: _themeCtx.primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Catering Charges : ${_doc.data()['cateringCharge']} ₹',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _themeCtx.primaryColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Text(
                        'Note : Additional charges may apply.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: _themeCtx.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              color: _themeCtx.accentColor,
              textColor: _themeCtx.primaryColor,
              onPressed: () {
                Navigator.pushNamed(
                    context, ConfirmBooking.confirmBookingScreen,
                    arguments: [
                      _venueDocId,
                      _doc.data()['charges24'],
                      _doc.data()['cateringCharge'],
                    ]);
              },
              icon: Icon(Icons.calendar_today),
              label: Text(
                'Schedule Booking',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
