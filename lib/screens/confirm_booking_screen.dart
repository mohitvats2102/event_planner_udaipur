import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ConfirmBooking extends StatefulWidget {
  static const String confirmBookingScreen = "/confirm_booking_screen";

  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isBookingStart = false;

  DateTime _startingDate;
  DateTime _endingDate;
  TimeOfDay _startTime;
  TimeOfDay _endTime;
  String _numberOfPeople;
  String _totalPrice;
  TextEditingController _controller = TextEditingController();

  bool isSlotPicked = false;

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
      body: ModalProgressHUD(
        inAsyncCall: _isBookingStart,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            _startingDate == null
                                ? 'Choose Starting date'
                                : 'Edit Choosen Date',
                            style: TextStyle(color: Color(0xFFFF8038)),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: FittedBox(
                          child: FlatButton(
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
                                    days: 3,
                                  ),
                                ),
                              ).then((value) {
                                if (value == null) return;
                                setState(() {
                                  _startingDate = value;
                                });
                              });
                            },
                            child: Text(
                              _startingDate == null
                                  ? 'Choose a Date'
                                  : DateFormat.yMd().format(_startingDate),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            _endingDate == null
                                ? 'Choose end date'
                                : 'Edit Choosen Date',
                            style: TextStyle(color: Color(0xFFFF8038)),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: FittedBox(
                          child: FlatButton(
                            textColor: Color(0xFFFF8038),
                            onPressed: () {
                              if (_startingDate != null) {
                                showDatePicker(
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return Theme(
                                        data: ThemeData.dark().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: Color(0xFFFF8038),
                                            onPrimary: Colors.white,
                                            surface: Color(0xFF033249),
                                            onSurface: Color(0xFFFF8038),
                                          ),
                                          dialogBackgroundColor:
                                              Color(0xFF033249),
                                        ),
                                        child: child,
                                      );
                                    },
                                    context: context,
                                    initialDate: _startingDate,
                                    firstDate: _startingDate,
                                    lastDate: _startingDate.add(
                                      Duration(
                                        days: 5,
                                      ),
                                    )).then((value) {
                                  if (value == null) return;
                                  setState(() {
                                    _endingDate = value;
                                  });
                                });
                              }
                            },
                            child: Text(
                              _endingDate == null
                                  ? 'Choose a Date'
                                  : DateFormat.yMd().format(_startingDate),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            _startTime == null
                                ? 'Choose start time'
                                : 'Edit Choosen time',
                            style: TextStyle(color: Color(0xFFFF8038)),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: FittedBox(
                          child: FlatButton(
                            textColor: Color(0xFFFF8038),
                            onPressed: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _startTime = value;
                                });
                              });
                            },
                            child: Text(
                              _startTime == null
                                  ? 'Choose time'
                                  : _startTime.format(context).toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            _endTime == null
                                ? 'Choose end time'
                                : 'Edit Choosen time',
                            style: TextStyle(color: Color(0xFFFF8038)),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: FittedBox(
                          child: FlatButton(
                            textColor: Color(0xFFFF8038),
                            onPressed: () {
                              if (_startTime != null) {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    _endTime = value;
                                  });
                                });
                              }
                            },
                            child: Text(
                              _endTime == null
                                  ? 'Choose time'
                                  : _endTime.format(context).toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            'Enter no. of People',
                            style: TextStyle(color: Color(0xFFFF8038)),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: TextField(
                          maxLength: 5,
                          onChanged: (_) {
                            setState(() {});
                          },
                          controller: _controller,
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
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            'Total Amount',
                            style: TextStyle(
                                color: Color(0xFFFF8038), fontSize: 22),
                          ),
                        ),
                      ),
                      Spacer(),
                      FittedBox(
                        child: Text(
                          _controller.text.trim() == ''
                              ? '0'
                              : '${int.parse(_controller.text.trim()) * 100}',
                          style:
                              TextStyle(color: Color(0xFFFF8038), fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    color: Color(0xFFFF8038),
                    textColor: Color(0xFF033428),
                    onPressed: () {
                      setState(() {
                        _isBookingStart = true;
                      });
                      _firestore.collection('bookings').doc().set({
                        'date': Timestamp.fromDate(_startingDate),
                        'peoples': _controller.text.trim() == ''
                            ? 0
                            : int.parse(_controller.text.trim()),
                        'totalAmount': int.parse(_controller.text.trim()) * 100,
                      }).then(
                        (value) {
                          setState(() {
                            _isBookingStart = false;
                          });
                          return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Your Booking is Confirmed'),
                              actions: [
                                //TextButton in place of FlatButton
                                TextButton(
                                  child: Text('Close'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.calendar_today),
                    label: Text(
                      'Confirm Booking',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChooseDateOrTime extends StatelessWidget {
  final String iconText;
  final String endText;
  final Function onTap;

  ChooseDateOrTime({
    this.endText,
    this.iconText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          onPressed: onTap,
          child: Text(
            iconText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Color(0xFFFF8038),
            ),
          ),
        ),
        Text(
          endText,
          style: TextStyle(
            fontSize: 17,
            color: Color(0xFFFF8038),
          ),
        ),
      ],
    );
  }
}

//slots logic

// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: FittedBox(
// child: Text(
// 'Choose a Slot',
// style: TextStyle(
// color: Color(0xFFFF8038), fontSize: 22),
// ),
// ),
// ),
// Spacer(),
// Expanded(
// child: DropdownButton(
// dropdownColor: Color(0xFFFF8038),
// icon: Icon(
// Icons.arrow_drop_down_circle_sharp,
// color: Color(0xFFFF8038),
// size: 17,
// ),
// hint: Text(
// isSlotPicked ? _pickedSlots : 'Slots',
// style: TextStyle(
// color: Color(0xFFFF8038),
// fontSize: 15,
// fontWeight: FontWeight.bold,
// ),
// ),
// items: ['10-12 am ', '1-3 pm ', '4-6 pm ', '7-10 pm ']
// .map(
// (slots) {
// return DropdownMenuItem(
// value: slots,
// onTap: () {
// setState(() {
// isSlotPicked = true;
// _pickedSlots = slots;
// });
// },
// child: Text(slots),
// );
// },
// ).toList(),
// onChanged: (value) {},
// ),
// ),
// ],
// ),
