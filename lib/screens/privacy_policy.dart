import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  static const String privacyPolicy = '/privacy_policy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
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
                  'Information we collect',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'The Platform seeks to provide the customers with information '
                  'and details of prospective nearest venues located in the '
                  'vicinity of the Customer\'s Search location. For the '
                  'aforementioned to be possible, it is essential for the '
                  'Platform to collect and use certain information from the '
                  'Customers. The Platform may collect Personal Identification '
                  'information as well as non-personal identification '
                  'information from the Customers.'
                  'The personal identification information includes, but it not '
                  'limited to, your email address, name, telephone number, '
                  'and other appropriate details that would help the Platformin '
                  'ensuring you get connected with the nearest venues around your '
                  'search locality and avail all the services being offered '
                  'by the Platform, and also in verifying your Identity, to '
                  'make sure someone else doesn’t use the platform in your '
                  'identity. This information is collected by the Platform '
                  'only if it is submitted by the Customers & allowed access '
                  'to by the Customers. The objective behind collecting your '
                  'personal information is to provide the services you are '
                  'seeking and to perform various site related activities '
                  'with greater convenience and efficiency when you place an '
                  'order. The Platform may collect personal identification '
                  'information in order to register Customers on the Platform, '
                  'keep a record of the services sought by the Customers and '
                  'for performing other website-related activities which helps '
                  'the Platform in serving you better. Due to the nature of '
                  'services provided by the app, the Platform may disclose '
                  'your personal information to third parties, with your explicit '
                  'consent, in order to provide you with the best information '
                  'for which you accessed the Platform’s services.'
                  'The Platform may also disclose information in response to a '
                  'court order or government request, or when it would be '
                  'reasonably necessary to disclose the said information to '
                  'protect the rights of the Platform, third parties, or the '
                  'public at large. The Platform May disclose information to '
                  'comply with legal process, to enforce their Terms of Use, '
                  'to protect their Operations and rights, privacy and safety '
                  'of the properties and to pursue any available legal remedies.',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 40),
                Text(
                  'Changes to this Privacy Policy',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'This Privacy Policy is current as of the effective date set '
                  'forth above. The Platform Has the discretion to make '
                  'amendments in the privacy policy as it may deem fit, '
                  'without any prior notice. The Customers will be sent an '
                  'email in order to notify them of the changes being made. '
                  'Continued use of the app, even after the changes made, shall '
                  'constitute your acceptance of the change. Therefore, the '
                  'Platform encourages to review this Privacy Policy frequently '
                  'and stay aware of changes',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
