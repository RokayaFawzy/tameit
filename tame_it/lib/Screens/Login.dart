import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/navbar_root.dart';
import 'package:tame_it/utility/validator.dart';
import '../values/values.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_painters.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Data model class for login details
class LoginDetails {
  final String userName;
  final String password;

  LoginDetails({
    required this.userName,
    required this.password,
  });

  // Convert LoginDetails object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _rememberMe = true;
  String? _errorMessage;

  // Future to retrieve token
  Future<String?> _getTokenFuture = _getToken();

  static Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Method to store token securely
  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Method to handle login button press
  Future<void> _loginUser(String userName, String password) async {
    // Clear previous error message
    setState(() {
      _errorMessage = null;
    });

    if (userName.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Please enter both email and password.";
      });
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Logging in..."),
            ],
          ),
        );
      },
    );

    // Create LoginDetails object with the entered data
    LoginDetails loginDetails =
        LoginDetails(userName: userName, password: password);

    try {
      // Send login data to the authentication API
      final url = Uri.parse('https://tameit.azurewebsites.net/api/auth/login');
      final response = await http.post(
        url,
        body: json.encode(loginDetails.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Login successful, extract and store token
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['token'];

        // Store token securely
        await storeToken(token);

        // Close loading indicator
        Navigator.pop(context);

        // Navigate to home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavBarRoot()),
        );
      } else {
        // Login failed, handle error
        setState(() {
          _errorMessage = "Invalid username or password. Please try again.";
        });

        // Close loading indicator
        Navigator.pop(context);
      }
    } catch (e) {
      // Error occurred during login process
      setState(() {
        _errorMessage =
            "An error occurred while logging in. Please try again later.";
      });
      print('Error occurred during login: $e');

      // Close loading indicator
      Navigator.pop(context);
    }
  }

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
                child: FutureBuilder<String?>(
                  future: _getTokenFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading indicator while retrieving token
                      return CircularProgressIndicator();
                    } else {
                      // Once token is retrieved, show login form
                      return _buildLoginForm(widthOfScreen);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to draw decorative circles on the background
  Widget drawCircles(double heightOfScreen, double widthOfScreen) {
    return Column(
      children: <Widget>[
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.60, heightOfScreen * -0.05),
            radius: widthOfScreen * 0.35,
            color: const Color.fromARGB(255, 27, 138, 125),
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.94, heightOfScreen * 0.04),
            radius: widthOfScreen * 0.4,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.1, heightOfScreen * 0.95),
            radius: widthOfScreen * 0.170,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
        CustomPaint(
          painter: DrawCircle(
            offset: Offset(widthOfScreen * 0.33, heightOfScreen * 0.91),
            radius: widthOfScreen * 0.05,
            color: AppColors.deepsea,
            hasShadow: true,
            shadowColor: AppColors.deepsea1,
          ),
        ),
      ],
    );
  }

  // Widget to build the login form
  Widget _buildLoginForm(double widthOfScreen) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Welcome Back!",
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: Sizes.TEXT_SIZE_30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "   We're Glad You're Here.",
              style: TextStyle(
                color: AppColors.black,
                fontSize: Sizes.TEXT_SIZE_16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            validator: validateEmail,
            controller: userNameController,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                FeatherIcons.user,
                color: AppColors.greyShade7,
                size: Sizes.ICON_SIZE_20,
              ),
              hintText: 'User Name',
              errorText: _errorMessage, // Display error message here
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.blackShade2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.orange),
              ),
              hintStyle: TextStyle(
                fontSize: Sizes.TEXT_SIZE_20,
                color: AppColors.greyShade7,
              ),
              labelStyle: TextStyle(
                fontSize: Sizes.TEXT_SIZE_20,
                color: AppColors.blackShade10,
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            obscureText: true,
            validator: (value) =>
                value!.isEmpty ? "Please enter password" : null,
            controller: passwordController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                FeatherIcons.lock,
                color: AppColors.greyShade7,
                size: Sizes.ICON_SIZE_20,
              ),
              suffixIcon: const Icon(
                FeatherIcons.eyeOff,
                color: AppColors.deepsea,
              ),
              hintText: 'Password',
              errorText: _errorMessage, // Display error message here
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.blackShade2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.orange),
              ),
              hintStyle: TextStyle(
                fontSize: Sizes.TEXT_SIZE_20,
                color: AppColors.greyShade7,
              ),
              labelStyle: TextStyle(
                fontSize: Sizes.TEXT_SIZE_20,
                color: AppColors.blackShade10,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Remember me ',
                    style: TextStyle(
                      color: AppColors.blueHorizon,
                    ),
                  ),
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/ForgotPassword');
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          CustomButton(
            title: 'Login',
            color: AppColors.deepsea,
            textStyle: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
              fontSize: Sizes.TEXT_SIZE_16,
              fontWeight: FontWeight.w600,
            ),
            onPressed: () {
              _loginUser(userNameController.text, passwordController.text);
            },
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/SignUp');
            },
            child: Text.rich(
              TextSpan(
                text: 'Not Registered Yet?',
                style: const TextStyle(
                  color: AppColors.greyShade8,
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.TEXT_SIZE_18,
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text: ' Sign Up',
                    style: TextStyle(color: AppColors.deepsea),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}
