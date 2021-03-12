import 'package:event_planner_udaipur/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class VenueDetailScreen extends StatelessWidget {
  static const String venueDetailScreen = '/venue_detail_screen';

  @override
  Widget build(BuildContext context) {
    ThemeData _themeCtx = Theme.of(context);
    Size _deviceSize = MediaQuery.of(context).size;
    int _index = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.call,
              size: 30,
            ),
            onPressed: () {},
            padding: EdgeInsets.only(right: 20),
          ),
        ],
        iconTheme: IconThemeData(
          color: Color(
            0xFFFF8038,
          ),
        ),
        title: Text(
          venueImgName1[_index],
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
            height: _deviceSize.height * 0.30,
            child: Hero(
              tag: venueImgList1[_index],
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image.network(
                  venueImgList1[_index],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
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
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: venueImgList.map(
                (imgUrl) {
                  return Container(
                    width: _deviceSize.width * 0.35,
                    margin: EdgeInsets.symmetric(horizontal: 5),
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
          SizedBox(height: 20),
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
                  left: 20,
                  top: 20,
                  right: 20,
                ),
                height: _deviceSize.height * 0.4,
                width: double.infinity,
                child: ListView(
                  children: [
                    Text(
                      'Available Rooms : 10',
                      style: TextStyle(
                        fontSize: 25,
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
                      'Ratings : ⭐⭐⭐⭐⭐',
                      style: TextStyle(
                        fontSize: 25,
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
                      'Address : NSCB Hostel Third Year CTAE Udaipur',
                      style: TextStyle(
                        fontSize: 25,
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
                      'Description : All Facilities Available alongwith Catering,AC/NON-AC Rooms',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: _themeCtx.primaryColor,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              color: _themeCtx.accentColor,
              textColor: _themeCtx.primaryColor,
              onPressed: () {},
              icon: Icon(Icons.calendar_today),
              label: Text(
                'Schedule Booking',
                style: TextStyle(
                  fontSize: 20,
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
