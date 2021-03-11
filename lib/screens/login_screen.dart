import 'package:event_planner_udaipur/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shimmer/shimmer.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String loginScreen = '/loginscreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isStartRegister = false;

  Future<void> onTapSignInWithGoogle() async {
    setState(() {
      _isStartRegister = true;
    });
    try {
      await signInWithGoogle();
      setState(() {
        _isStartRegister = false;
      });
      Navigator.pushReplacementNamed(context, HomeScreen.homeScreen);
    } on NoSuchMethodError catch (e) {
      print('in Catch.....');
      setState(() {
        _isStartRegister = false;
      });
      print(e.toString());
    } catch (e) {
      print(e.message);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  // Future<void> _tryLoginUser(
  //     {String email,
  //     String password,
  //     String username,
  //     bool islogin,
  //     BuildContext ctx}) async {
  //   UserCredential authUser;
  //   try {
  //     if (this.mounted) {
  //       setState(() {
  //         _isStartRegister = true;
  //       });
  //     }
  //     if (islogin) {
  //       authUser = await _auth.signInWithEmailAndPassword(
  //           email: email, password: password);
  //       // authUser.user.providerData[1].providerId;
  //
  //       Navigator.of(context)
  //           .pushReplacementNamed(CategoryScreen.categoryScreen);
  //     } else {
  //       await _auth.createUserWithEmailAndPassword(
  //           email: email, password: password);
  //
  //       Navigator.of(context)
  //           .pushReplacementNamed(CategoryScreen.categoryScreen);
  //     }
  //   } on PlatformException catch (err) {
  //     if (this.mounted) {
  //       setState(() {
  //         _isStartRegister = false;
  //       });
  //     }
  //     String msg = 'Something went wrong please try again later';
  //     if (err.message != null) {
  //       msg = err.message;
  //     }
  //     print(err.message);
  //     Scaffold.of(ctx).showSnackBar(
  //       SnackBar(
  //         content: Text(msg),
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   } catch (err) {
  //     if (this.mounted) {
  //       setState(() {
  //         _isStartRegister = false;
  //       });
  //     }
  //     Scaffold.of(ctx).showSnackBar(
  //       SnackBar(
  //         content: Text(err.message),
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ModalProgressHUD(
        inAsyncCall: _isStartRegister,
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF033249),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/bgImage.PNG'),
                    colorFilter: ColorFilter.mode(
                        Color(0xFF033249).withOpacity(0.25), BlendMode.dstATop),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 70),
                  Row(
                    children: [
                      SizedBox(width: 130),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Color(0xFFFF8038),
                            highlightColor: Colors.amber.shade300,
                            child: Text(
                              '  Event\nPlanner',
                              style: kloginText.copyWith(
                                fontSize: 50,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.only(
                      right: 70,
                      left: 20,
                      top: 7,
                      bottom: 7,
                    ),
                    textColor: Color(0xFF033249),
                    color: Colors.white,
                    onPressed: () {},
                    icon: Icon(
                      Icons.phone,
                      color: Color(0xFF033249),
                    ),
                    label: Text(
                      'Sign in using phone',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    highlightElevation: 15,
                  ),
                  SizedBox(height: 20),
                  Shimmer.fromColors(
                    baseColor: Color(0xFFFF8038),
                    highlightColor: Colors.amber.shade300,
                    child: Text(
                      'Or',
                      style: TextStyle(
                          color: Color(0xFFFF8038),
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 20),
                  SignInButton(
                    Buttons.Google,
                    onPressed: onTapSignInWithGoogle,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  ),
                  SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Shimmer.fromColors(
                      baseColor: Color(0xFFFF8038),
                      highlightColor: Colors.amber.shade300,
                      child: Text(
                        'Your Choices Our Plan!',
                        style: TextStyle(
                          color: Color(0xFFFF8038),
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
