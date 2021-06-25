import 'package:flutter/material.dart';
import 'package:inventory_v1/constants.dart';
import 'package:inventory_v1/widgets/add_products_text_field.dart';
import 'landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _fireauth = FirebaseAuth.instance;
TextEditingController userIdController = TextEditingController();

Widget showEditableUserIDField() {
  return AddProductsTextField(
    lableTextForTextField: 'User ID',
    textInputType: TextInputType.emailAddress,
    onChangeFunction: (value) {
      userIdController.text = value;
    },
  );
}

Widget showNonEditableUserIDField(String emailId) {
  return Text(
    emailId,
    style: TextStyle(
      color: Colors.black,
    ),
  );
}

class LoginBottomsheet extends StatefulWidget {
  final String emailId;
  final String password;
  final bool alreadyLoggedIn;

  LoginBottomsheet({
    this.emailId,
    this.password,
    this.alreadyLoggedIn,
  });

  @override
  _LoginBottomsheetState createState() => _LoginBottomsheetState();
}

class _LoginBottomsheetState extends State<LoginBottomsheet> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userIdController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: userIdController.text.length,
      ),
    );
    passwordController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: passwordController.text.length,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: kbottomSheetBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      // height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.all(20.0),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Please enter the registered User ID and Password to login. If not registered please Contact Us',
              style: TextStyle(color: kCardColor, fontSize: 12),
            ),
            SizedBox(
              height: 15,
            ),
            widget.alreadyLoggedIn == false
                ? showEditableUserIDField()
                : showNonEditableUserIDField(widget.emailId),
            SizedBox(
              height: 15,
            ),
            AddProductsTextField(
              lableTextForTextField: 'Password',
              textInputType: TextInputType.emailAddress,
              obscureText: true,
              maxLines: 1,
              onChangeFunction: (value) {
                passwordController.text = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 50,
              elevation: 8,
              child: Text(
                'LOGIN',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                final loginUser = await _fireauth.signInWithEmailAndPassword(
                  email: widget.alreadyLoggedIn == true
                      ? widget.emailId
                      : userIdController.text,
                  password: passwordController.text,
                );
                if (loginUser != null) {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('alreadyLoggedIn', true);
                  prefs.setString('emailId', userIdController.text);
                  prefs.setString('password', passwordController.text);

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LandingScreen().id,
                    (r) => false,
                  );
                } else {
                  print('Check your creds');
                }
              },
              color: kCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
