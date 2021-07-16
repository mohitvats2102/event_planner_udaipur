import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const String aboutUs = '/about_us';
  @override
  Widget build(BuildContext context) {
    Widget buildRow(String p1, String p2, String n1, String n2, double r,
        [String p3 = '', String n3 = '']) {
      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(p1),
                  radius: r,
                ),
                SizedBox(height: 10),
                FittedBox(
                  child: Text(
                    n1,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(p2),
                  radius: r,
                ),
                SizedBox(height: 10),
                FittedBox(
                  child: Text(
                    n2,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (p3 != '' && n3 != '')
            Expanded(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(p3),
                    radius: r,
                  ),
                  SizedBox(height: 10),
                  FittedBox(
                    child: Text(
                      n3,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage('assets/images/ep.png'),
                ),
                SizedBox(height: 20),
                Text(
                  'Event Planner is a New Gen recognised startup.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Event Planner is an initiative to provide you with a convenient '
                  'way to plan your personal events with much more ease than '
                  'what is traditionally being followed. With Event Planner, '
                  'you can compare different venues based upon several aspects, '
                  'including but not limited to, price, rating, space, visuals, '
                  'and a lot more. Now you do not actually need to visit them '
                  'personally to check your needs. All you gotta do is take '
                  'your phone, open Our application and select a venue from '
                  'a list of multiple high class and verified venues. And boom, '
                  'you just did a very tedious task with much ease just '
                  'sitting in the comfort zones of your home.',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'We are a bunch of enthusiasts from College of Technology and '
                  'Engineering, Udaipur, who thought about this, and worked '
                  'to bring it to life. This Initiative was also selected for '
                  'funding in the New Gen Department of our college.',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Divider(height: 1, color: Colors.black),
                SizedBox(height: 20),
                Text(
                  'Our Team',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                buildRow(
                    'assets/images/1.jpg',
                    'assets/images/3.jpeg',
                    'Sneha Jain',
                    'Himanshu Panday',
                    50,
                    'assets/images/2.jpg',
                    'Bhuresh Soni'),
                SizedBox(height: 20),
                Divider(height: 1, color: Colors.black),
                SizedBox(height: 20),
                Text(
                  'Developer Contact',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                buildRow(
                  'assets/images/2.PNG',
                  'assets/images/4.jpg',
                  'Mohit Vats',
                  'Swaraj Kumar',
                  40,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'E-mail : ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'appdeveloper2127@gmail.com',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Contact : ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '9660223279',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(height: 1, color: Colors.black),
                SizedBox(height: 20),
                Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'E-mail :',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Text(
                        'eventplannerofudaipur@gmail.com',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
