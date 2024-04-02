import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../values/values.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_painters.dart';
import '../widgets/custom_text_form_field.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  late String _userName = '';
  late String _password = '';
  late String _confirmPassword = '';
  late String _email = '';

  bool _usernameExists = false;
  String? _passwordError;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteShade2,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          children: <Widget>[
            drawCircles(heightOfScreen, widthOfScreen),
            Center(
              child: SingleChildScrollView(
                child: _buildRegiserForm(widthOfScreen),
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget drawCircles(double heightOfScreen, double widthOfScreen) {
    return Column(
      children: <Widget>[
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.50, heightOfScreen * -0.05),
            radius: widthOfScreen * 0.35,
            color: const Color.fromARGB(255, 27, 138, 125),
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.14, heightOfScreen * 0.04),
            radius: widthOfScreen * 0.4,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.9, heightOfScreen * 0.95),
            radius: widthOfScreen * 0.170,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.66, heightOfScreen * 0.91),
            radius: widthOfScreen * 0.05,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
      ],
    );
  }

  Widget _buildRegiserForm(double widthOfScreen) {
    var doRegister = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        if (_userName.isEmpty ||
            _password.isEmpty ||
            _confirmPassword.isEmpty ||
            _email.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Please fill in all the fields."),
            duration: Duration(seconds: 2),
          ));
          return;
        }
        if (_userName.contains(' ')) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Please enter username with no spaces."),
            duration: Duration(seconds: 2),
          ));
          return;
        }
        if (_password != _confirmPassword) {
          setState(() {
            _passwordError = "Passwords do not match.";
          });
          return;
        } else {
          setState(() {
            _passwordError = null;
          });
        }
        if (_usernameExists) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Username already exists. Please choose a different one."),
            duration: Duration(seconds: 2),
          ));
          return;
        }
        _registerUser();
      }
    };

    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widthOfScreen * 0.05),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: widthOfScreen * 0.05),
            Text(
              "Sign Up",
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: widthOfScreen * 0.08,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: widthOfScreen * 0.04),
            CustomTextFormField(
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              onSaved: (value) => _email = value ?? '',
              onChanged: (data) {
                _email = data;
              },
              hasTitle: false,
              hasPrefixIcon: true,
              prefixIcon: Icon(
                FeatherIcons.mail,
                color: AppColors.greyShade7,
                size: widthOfScreen * 0.06,
              ),
              hintTextStyle: TextStyle(
                fontSize: widthOfScreen * 0.04,
                color: AppColors.greyShade7,
              ),
              enabledBorder: Borders.customUnderlineInputBorder(
                color: AppColors.blackShade2,
              ),
              focusedBorder: Borders.customUnderlineInputBorder(
                color: AppColors.orange,
              ),
              textStyle: TextStyle(
                fontSize: widthOfScreen * 0.04,
                color: AppColors.blackShade10,
              ),
              hintText: 'Email',
            ),
            SizedBox(height: widthOfScreen * 0.02),
            CustomTextFormField(
              textInputType: TextInputType.name,
              hasTitle: false,
              onSaved: (value) => _userName = value ?? '',
              hasPrefixIcon: true,
              prefixIcon: Icon(
                FeatherIcons.user,
                color: AppColors.greyShade7,
                size: widthOfScreen * 0.06,
              ),
              hintTextStyle: TextStyle(
                fontSize: widthOfScreen * 0.04,
                color: AppColors.greyShade7,
              ),
              enabledBorder: Borders.customUnderlineInputBorder(
                color: AppColors.blackShade2,
              ),
              focusedBorder: Borders.customUnderlineInputBorder(
                color: AppColors.orange,
              ),
              textStyle: TextStyle(
                fontSize: widthOfScreen * 0.04,
                color: AppColors.blackShade10,
              ),
              hintText: 'Username',
              validator: (value) {
                if (value!.contains(' ')) {
                  return 'Username should not contain spaces';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _usernameExists = false;
                });
              },
            ),
            SizedBox(height: widthOfScreen * 0.02),
            CustomTextFormField(
              textInputType: TextInputType.text,
              obscured: true,
              hasTitle: false,
              validator: (value) =>
                  value!.isEmpty ? "Please enter password" : null,
              onSaved: (value) => _password = value ?? '',
              hasPrefixIcon: true,
              prefixIcon: Icon(
                FeatherIcons.lock,
                color: AppColors.greyShade7,
                size: widthOfScreen * 0.06,
              ),
              hasSuffixIcon: true,
              suffixIcon: Icon(
                FeatherIcons.eyeOff,
                color: AppColors.deepsea,
                size: widthOfScreen * 0.06,
              ),
              hintTextStyle: TextStyle(
                fontSize: widthOfScreen * 0.04,
                color: AppColors.greyShade7,
              ),
              enabledBorder: Borders.customUnderlineInputBorder(
                color: AppColors.blackShade2,
              ),
              focusedBorder: Borders.customUnderlineInputBorder(
                color: AppColors.orange,
              ),
              textStyle: TextStyle(
                fontSize: widthOfScreen * 0.04,
                color: AppColors.blackShade10,
              ),
              hintText: 'Password',
            ),
            SizedBox(height: widthOfScreen * 0.02),
            CustomTextFormField(
              textInputType: TextInputType.text,
              obscured: true,
              validator: (value) =>
                  value!.isEmpty ? "Your password is required" : null,
              onSaved: (value) => _confirmPassword = value ?? '',
              hasTitle: false,
              hasPrefixIcon: true,
              prefixIcon: Icon(
                FeatherIcons.lock,
                color: AppColors.greyShade7,
                size: widthOfScreen * 0.06,
              ),
              hasSuffixIcon: true,
              suffixIcon: Icon(
                FeatherIcons.eyeOff,
                color: AppColors.deepsea,
                size: widthOfScreen * 0.06,
              ),
              hintTextStyle: TextStyle(
                fontSize: widthOfScreen * 0.04,
                color: AppColors.greyShade7,
              ),
              enabledBorder: Borders.customUnderlineInputBorder(
                color: AppColors.blackShade2,
              ),
              focusedBorder: Borders.customUnderlineInputBorder(
                color: AppColors.orange,
              ),
              textStyle: TextStyle(
                fontSize: widthOfScreen * 0.04,
                color: AppColors.blackShade10,
              ),
              hintText: 'Confirm Password',
            ),
            if (_passwordError != null)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  _passwordError!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: widthOfScreen * 0.07),
            CustomButton(
              title: 'Register',
              color: AppColors.deepsea,
              textStyle: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.white,
                fontSize: widthOfScreen * 0.04,
                fontWeight: FontWeight.w600,
              ),
              onPressed: doRegister,
            ),
            SizedBox(height: widthOfScreen * 0.05),
            Align(
              alignment: Alignment.center,
              child: SelectableText.rich(
                TextSpan(
                  text: 'Already Have An Account?',
                  style: TextStyle(
                    color: AppColors.greyShade8,
                    fontWeight: FontWeight.bold,
                    fontSize: widthOfScreen * 0.04,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Sign In',
                      style: TextStyle(color: AppColors.deepsea),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => Navigator.of(context).pushNamed('/Login'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: widthOfScreen * 0.001),
          ],
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final url =
          Uri.parse('https://tameit.azurewebsites.net/api/auth/register');
      final response = await http.post(
        url,
        body: json.encode({
          'userName': _userName,
          'password': _password,
          'confirmPassword': _confirmPassword,
          'email': _email,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        var token = responseData['token'];
        print('Registration successful. Token: $token');
        Navigator.of(context).pushNamed('/NavBarRoot');
      } else if (response.statusCode == 400) {
        setState(() {
          _usernameExists = true;
        });
      } else {
        print('Registration failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred during registration: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
