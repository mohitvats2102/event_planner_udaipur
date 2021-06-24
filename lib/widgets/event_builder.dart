import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/event_venues_list.dart';

class EventBuilder extends StatelessWidget {
  final List<QueryDocumentSnapshot> _eventList;
  final String eventDocID;
  final int index;
  EventBuilder(
    this._eventList,
    this.index,
    this.eventDocID,
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(VenueList.venueScreen,
            //change here
            arguments: [
              _eventList[index].id,
              index,
              _eventList[index].data()['image'],
              eventDocID,
            ]);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        elevation: 10,
        child: GridTile(
          footer: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            child: FittedBox(
              child: Text(
                _eventList[index].id,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            alignment: Alignment.center,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Hero(
              tag: index,
              child: FadeInImage(
                fit: BoxFit.fill,
                placeholder: AssetImage('assets/images/fade.png'),
                image: NetworkImage(
                  _eventList[index].data()['image'],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
