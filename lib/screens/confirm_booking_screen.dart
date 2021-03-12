import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmBooking extends StatefulWidget {
  static const String confirmBookingScreen = "/confirm_booking_screen";

  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  DateTime _pickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF033249),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFFFF8038),
        ),
        title: Text(
          "Confirm Booking",
          style: TextStyle(
            color: Color(0xFFFF8038),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _pickedDate == null
                        ? 'No Date Choosen'
                        : 'Edit Choosen Date',
                    style: TextStyle(color: Color(0xFFFF8038), fontSize: 22),
                  ),
                  FlatButton(
                    textColor: Color(0xFFFF8038),
                    onPressed: () {
                      showDatePicker(
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: Color(0xFFFF8038),
                                onPrimary: Colors.white,
                                surface: Color(0xFF033249),
                                onSurface: Color(0xFFFF8038),
                              ),
                              dialogBackgroundColor: Color(0xFF033249),
                            ),
                            child: child,
                          );
                        },
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          Duration(
                            days: 45,
                          ),
                        ),
                      ).then((value) {
                        if (value == null) return;
                        setState(() {
                          _pickedDate = value;
                        });
                      });
                    },
                    child: Text(
                      _pickedDate == null
                          ? 'Choose a Date'
                          : DateFormat.yMd().format(_pickedDate),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose a Slot',
                    style: TextStyle(color: Color(0xFFFF8038), fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: DropdownButton(
                      dropdownColor: Color(0xFFFF8038).withOpacity(0.9),
                      icon: Icon(
                        Icons.arrow_drop_down_circle_sharp,
                        color: Color(0xFFFF8038),
                      ),
                      hint: Text(
                        'Slots',
                        style: TextStyle(
                          color: Color(0xFFFF8038),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      items: ['10-12 am', '1-3 pm', '4-6 pm', '7-10 pm'].map(
                        (slots) {
                          return DropdownMenuItem(
                            value: slots,
                            onTap: () {},
                            child: FlatButton(
                              child: Text(slots),
                              onPressed: () {},
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    'Enter no. of People',
                    style: TextStyle(color: Color(0xFFFF8038), fontSize: 22),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 120,
                    child: TextField(
                      cursorColor: Color(0xFFFF8038),
                      cursorHeight: 25,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Color(0xFFFF8038),
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF8038),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF8038),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(color: Color(0xFFFF8038), fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      '₹  50000',
                      style: TextStyle(color: Color(0xFFFF8038), fontSize: 22),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 150),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                color: Color(0xFFFF8038),
                textColor: Color(0xFF033428),
                onPressed: () {
                  showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Your Booking is Confirmed'),
                        actions: [
                          FlatButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ));
                },
                icon: Icon(Icons.calendar_today),
                label: Text(
                  'Confirm Booking',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                color: Color(0xFFFF8038),
                textColor: Color(0xFF033428),
                onPressed: () {},
                icon: Icon(Icons.call),
                label: Text(
                  'Call Manager',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
