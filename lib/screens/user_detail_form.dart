import 'dart:io';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UserDetailForm extends StatefulWidget {
  static const String workerDetailForm = '/user_detail_form';

  @override
  _UserDetailFormState createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  bool _isUploadingStarted = false;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _currentUserUID;
  bool doesRun = true;

  File _pickedImage;
  String _userName;
  String _userContact;
  String _userAddress;

  final _formKey = GlobalKey<FormState>();

  void onSave() async {
    if (_pickedImage == null) {
      await showDialog(
        context: context,
        builder: (ctx) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: AlertDialog(
              title: Text('Please Pick an image'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                )
              ],
            ),
          );
        },
      );
      return;
    }
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      setState(() {
        _isUploadingStarted = true;
      });
      _currentUserUID = _auth.currentUser.uid;
      String _userImageUrl;
      try {
        final ref = _firebaseStorage
            .ref()
            .child('users_image')
            .child('$_currentUserUID.jpg');
        await ref.putFile(_pickedImage).whenComplete(
          () async {
            _userImageUrl = await ref.getDownloadURL();
          },
        );

        await _firestore.collection('users').doc(_currentUserUID).set(
          {
            'address': _userAddress,
            'contact': _userContact,
            'image': _userImageUrl,
            'name': _userName,
            'totalBookings': 0,
            'bookings': [],
          },
        );

        setState(() {
          _isUploadingStarted = false;
        });
        Navigator.of(context).pushReplacementNamed(HomeScreen.homeScreen);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void pickImage() {
    showDialog(
      context: context,
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                onWantToTakePic(ImageSource.camera);
              },
              child: Text(
                'Open Camera',
              ),
            ),
            SizedBox(height: 10),
            SimpleDialogOption(
              onPressed: () {
                onWantToTakePic(ImageSource.gallery);
              },
              child: Text(
                'Pick From Gallery',
              ),
            ),
            SizedBox(height: 10),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
              child: Text(
                'Cancel',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onWantToTakePic(ImageSource imageSource) async {
    final picker = ImagePicker();
    final image = await picker.getImage(
      source: imageSource,
      imageQuality: 100,
      maxWidth: 150,
    );
    if (image == null) return;
    setState(() {
      _pickedImage = File(image.path);
    });
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please fill your details'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isUploadingStarted,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFF033249),
                    backgroundImage: _pickedImage == null
                        ? AssetImage('assets/images/image.png')
                        : FileImage(_pickedImage),
                  ),
                  TextButton.icon(
                    onPressed: pickImage,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Color(0xFFFF8038),
                    ),
                    label: Text(
                      'Add photo',
                      style: TextStyle(color: Color(0xFFFF8038)),
                    ),
                  ),
                  TextFormField(
                    key: ValueKey('name'),
                    keyboardType: TextInputType.name,
                    decoration: klogininput.copyWith(labelText: 'Name'),
                    validator: (value) {
                      if (value.length < 4) {
                        return 'Atleast 4 char long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('Contact'),
                    keyboardType: TextInputType.phone,
                    decoration: klogininput.copyWith(
                      labelText: 'Contact',
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color(0xFFFF8038),
                      ),
                    ),
                    validator: (value) {
                      if (value.length < 10) {
                        return 'Provide right number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userContact = value;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('address'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: klogininput.copyWith(
                      labelText: 'Address',
                      prefixIcon: Icon(
                        Icons.home,
                        color: Color(0xFFFF8038),
                      ),
                    ),
                    validator: (value) {
                      if (value.length < 10) {
                        return 'Provide full address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userAddress = value;
                    },
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      doesRun = false;
                      onSave();
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
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
