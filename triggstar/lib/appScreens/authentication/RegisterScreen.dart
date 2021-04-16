import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triggstar/services/auth.dart';
import 'package:triggstar/services/database.dart';
import 'package:triggstar/shared/loading.dart';

class RegisterScreen extends StatelessWidget {
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
              child: CustomeForm(),
            )));
  }
}

class CustomeForm extends StatefulWidget {
  @override
  _CustomeFormState createState() => _CustomeFormState();
}

class _CustomeFormState extends State<CustomeForm> {
  final Color logoGreen = Color(0xff25bcbb);
  final Color secondaryColor = Color(0xff232c51);
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool _loading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final AuthService _auth = AuthService();
  final DatabaseService db = DatabaseService();
  String error = '';
  //string fields state
  String firstname = '';
  String lastname = '';
  String email = '';
  String number = '';
  String password = '';
  String confirmPassword = '';

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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign up to Triggstar Investment',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 30),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //code for the firstname
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTextField(firstnameController, Icons.account_box,
                        'firstname', TextInputType.text,
                        height: 50.0, width: 160.0),
                    _buildTextField(lastnameController, Icons.account_circle,
                        'lastname', TextInputType.text,
                        height: 50.0, width: 160.0),
                  ],
                ),
                SizedBox(height: 20),
                //this container is for the email
                _buildTextField(emailController, Icons.email, 'email',
                    TextInputType.emailAddress),
                //this for the number
                SizedBox(
                  height: 20,
                ),
                _buildTextField(numberController, Icons.phone_iphone,
                    'cellnumber', TextInputType.number),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(passwordController, Icons.lock_open_rounded,
                    'password', TextInputType.visiblePassword,
                    obscure: true),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(
                    confirmController,
                    Icons.admin_panel_settings_sharp,
                    'confirm password',
                    TextInputType.visiblePassword,
                    obscure: true),
                SizedBox(height: 30),
                //the submit button is here
                ElevatedButton(
                    child: Text(
                      "Sign up ",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => _loading = true);
                        if (password == confirmPassword) {
                          var num = int.parse(number);
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  firstname, lastname, email, number, password);
                          await db.updateUserData(
                              firstname, lastname, email, number, password);
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                              _loading = false;
                            });
                          }
                        } else {
                          return error = 'The passwords do not match';
                        }
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {
                    //will put the facebook details here
                  },
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.facebook),
                      SizedBox(width: 10),
                      Text('Sign-up using facebook',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                )
              ],
            ));
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
          validator: (value) => value.isEmpty ? "*Required" : null,
          onChanged: (value) {
            switch (labelText) {
              case 'firstname':
                setState(() => firstname = value);
                break;
              case 'lastname':
                setState(() => lastname = value);
                break;
              case 'email':
                setState(() => email = value);
                break;
              case 'cellnumber':
                setState(() => number = value);
                break;
              case 'password':
                setState(() => password = value);
                break;
              case 'confirm password':
                setState(() => confirmPassword = value);
                break;
              default:
                return error = "invalid";
            }
          },
        ));
  }
}
