import 'package:event_planner_udaipur/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VenueList extends StatelessWidget {
  static const String venueScreen = '/venue_screen';
  @override
  Widget build(BuildContext context) {
    Size _deviceSize = MediaQuery.of(context).size;
    List _routeArgs = ModalRoute.of(context).settings.arguments as List;
    var themeCtx = Theme.of(context);
    String _eventName = _routeArgs[0];
    int _index = _routeArgs[1];
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
                  eventList[_index],
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
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: venueImgList1.length,
                          itemBuilder: (ctx, i) {
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              elevation: 30,
                              color: themeCtx.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      child: Image.network(
                                        venueImgList1[i],
                                        fit: BoxFit.fitWidth,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                      left: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            child: Text(
                                              venueImgName1[i],
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: themeCtx.accentColor,
                                              ),
                                            ),
                                          ),
                                          width: _deviceSize.width * 0.41,
                                        ),
                                        RaisedButton.icon(
                                          elevation: 0,
                                          textColor: themeCtx.accentColor,
                                          color: themeCtx.primaryColor,
                                          onPressed: () {},
                                          label: Text(
                                            'View Details',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          icon: Icon(Icons.arrow_forward),
                                        )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
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