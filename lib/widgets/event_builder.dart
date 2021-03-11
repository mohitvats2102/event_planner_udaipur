import 'package:flutter/material.dart';

class EventBuilder extends StatelessWidget {
  List<String> _eventList;
  int index;
  EventBuilder(this._eventList, this.index);
  @override
  Widget build(BuildContext context) {
    return Card(
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
              )),
          padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
          ),
          child: Text(
            'Images',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          alignment: Alignment.center,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            _eventList[index],
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
