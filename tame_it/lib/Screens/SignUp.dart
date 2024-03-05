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
  // late String _userName, _password, _confirmPassword, _email;
  late String _userName = ''; // Initialize with an empty string
  late String _password = ''; // Initialize with an empty string
  late String _confirmPassword = ''; // Initialize with an empty string
  late String _email = ''; // Initialize with an empty string

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
              textInputType: TextInputType.text,
              // validator: validateEmail,
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
            SizedBox(height: widthOfScreen * 0.05), // Add the SizedBox here
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
        // Registration successful
        var responseData = json.decode(response.body);
        var token = responseData['token']; // Assuming the token key is 'token'
        print('Registration successful. Token: $token');
        // Navigate to another screen or show a success message
        Navigator.of(context).pushNamed('/Home');
      } else {
        // Registration failed, handle error (e.g., show error message)
        print('Registration failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred during registration process
      print('Error occurred during registration: $e');
    }
  }
}
