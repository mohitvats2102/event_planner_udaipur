import 'package:event_planner_udaipur/screens/about_us.dart';
import 'package:event_planner_udaipur/screens/privacy_policy.dart';
import 'package:event_planner_udaipur/screens/user_bookings.dart';
import 'package:event_planner_udaipur/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:event_planner_udaipur/constant.dart';

class MainDrawer extends StatelessWidget {
  final String userName;
  final String imageUrl;
  final void Function(BuildContext context) logoutFun;
  final BuildContext ctx;

  MainDrawer({this.imageUrl, this.userName, this.logoutFun, this.ctx});

  Widget buildListTile(String text, IconData icon, Function onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: kdarkTeal,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: kdarkTeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 20),
            color: Color(0xFF033249),
            width: double.infinity,
            height: 150,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/ep.png'),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFFFF8038),
                      ),
                    ),
                    Text(
                      'Event Planner',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFFFF8038),
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          buildListTile(
            'Your Profile',
            Icons.account_circle,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(UserProfile.userProfileScreen,
                  arguments: userName);
            },
          ),
          SizedBox(height: 10),
          buildListTile('Your Bookings', Icons.book, () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(UserBookings.user_booking_route);
          }),
          SizedBox(height: 10),
          buildListTile(
            'User Privacy Policy',
            Icons.privacy_tip,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(PrivacyPolicy.privacyPolicy);
            },
          ),
          SizedBox(height: 10),
          buildListTile(
            'About Us',
            Icons.assignment,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AboutUs.aboutUs);
            },
          ),
          SizedBox(height: 10),
          buildListTile(
            'Logout',
            Icons.logout,
            () {
              Navigator.of(context).pop();
              logoutFun(ctx);
            },
          ),
        ],
      ),
    );
  }
}
