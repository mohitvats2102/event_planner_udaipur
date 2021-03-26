import 'package:flutter/material.dart';

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
        color: Color(0xFFFF8038),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Color(0xFFFF8038),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF033249),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 70),
              color: Color(0xFF033249),
              width: double.infinity,
              height: 200,
              child: SafeArea(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(55),
                    child: imageUrl != ''
                        ? FadeInImage(
                            height: 58,
                            width: 56,
                            fit: BoxFit.fill,
                            placeholder:
                                AssetImage('assets/images/user_avatar.PNG'),
                            image: NetworkImage(imageUrl),
                          )
                        : AssetImage('assets/images/user_avatar.PNG'),
                  ),

                  // CircleAvatar(
                  //   backgroundColor: Colors.white,
                  //   radius: 28,
                  //   backgroundImage: imageUrl != ''
                  //       ? FadeInImage(
                  //           placeholder: AssetImage('assets/images/logo.jpg'),
                  //           image: NetworkImage(imageUrl),
                  //         )
                  //       : AssetImage('assets/images/ee.PNG'),
                  // ),
                  title: Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFFF8038),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  subtitle: Text(
                    userName,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFFF8038),
                      letterSpacing: 1.5,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            buildListTile(
              'Your Profile',
              Icons.account_circle,
              () {
                Navigator.of(context).pop();
                //   Navigator.of(context).pushNamed(UserProfile.userProfileScreen,
                //       arguments: userName);
              },
            ),
            SizedBox(height: 10),
            buildListTile(
              'User Privacy Policy',
              Icons.privacy_tip,
              () {},
            ),
            SizedBox(height: 10),
            buildListTile(
              'About Us',
              Icons.assignment,
              () {},
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
      ),
    );
  }
}
