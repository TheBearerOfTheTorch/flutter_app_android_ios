import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'RegisterScreen.dart';
import 'package:triggstar/appScreens/authentication/forgotPassword.dart';
import 'package:triggstar/services/auth.dart';
import 'package:triggstar/shared/loading.dart';

class LoginScreen extends StatelessWidget {
  final Color primaryColor = Color(0xff18203d);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: MyLoginForm(),
          )),
    );
  }
}

class MyLoginForm extends StatefulWidget {
  @override
  _MyLoginFormState createState() => _MyLoginFormState();
}

class _MyLoginFormState extends State<MyLoginForm> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoGreen = Color(0xff25bcbb);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _loading = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  //submitting the form
  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return null;
    }
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign in to Triggstar Investment',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your email and password below to continue to triggstar investment and let the cleaning begin!',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(
                  height: 110,
                ),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //this is the email field
                _buildTextField(emailController, Icons.email, 'enter email',
                    TextInputType.emailAddress),
                SizedBox(height: 20),
                //password
                _buildTextField(passwordController, FontAwesomeIcons.lock,
                    'enter password', TextInputType.emailAddress,
                    obscure: true),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _builtGestureDector("sign up"),
                    _builtGestureDector("forgot password"),
                  ],
                ),
                SizedBox(height: 50),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => _loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Could not sign in with those credentials';
                          _loading = false;
                        });
                      }
                    }
                  },
                  color: logoGreen,
                  child: Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {},
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.facebook),
                      SizedBox(width: 10),
                      Text('Sign-in using facebook',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
              ],
            ),
          );
  }

  _builtGestureDector(String label) {
    return GestureDetector(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return label == "sign up" ? RegisterScreen() : ForgotPassword();
        }));
      },
    );
  }

  _buildTextField(TextEditingController controller, IconData icon,
      String labelText, TextInputType inputType,
      {obscure = false, height, width, emailRegExp}) {
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: secondaryColor, border: Border.all(color: Colors.blue)),
        child: TextFormField(
          obscureText: obscure,
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          validator: (value) => value.isEmpty ? '*Required' : null,
          onChanged: (val) => setState(
              () => labelText == "enter email" ? email = val : password = val),
        ));
  }
}
