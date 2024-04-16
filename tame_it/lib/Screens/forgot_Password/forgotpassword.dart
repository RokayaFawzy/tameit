import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:http/http.dart' as http;
import 'package:tame_it/Screens/forgot_Password/verification_code.dart';
import 'package:tame_it/values/values.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();

  static void sendVerificationEmail() {}
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController _usernameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> sendVerificationEmail(String username) async {
    setState(() {
      _isLoading = true;
    });

    final apiUrl =
        'https://tameit.azurewebsites.net/api/auth/forgotPassword/verifyEmail/$username';

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Handle success response
        print('Verification email sent successfully.');

        // Navigate to CodePhone screen upon successful email sending
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CodePhone(
                    username: username,
                    sendVerificationEmail: sendVerificationEmail,
                  )),
        );
      } else {
        // Handle other status codes or errors
        print(
            'Failed to send verification email. Status code: ${response.statusCode}');
        showErrorDialog('Failed to send verification email. Please try again.');
      }
    } catch (e) {
      // Handle network or server errors
      print('Error sending verification email: $e');
      showErrorDialog('Error sending verification email. Please try again.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.deepsea),
        backgroundColor: AppColors.whiteShade3,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
        child: Column(
          children: <Widget>[
            Text(
              "Enter Your Username",
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: Sizes.TEXT_SIZE_24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Enter your username to reset your password",
              style: TextStyle(
                color: AppColors.Bermuda,
                fontSize: Sizes.TEXT_SIZE_16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _usernameController,
              style: TextStyle(
                fontSize: Sizes.TEXT_SIZE_14,
              ),
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(
                  fontSize: Sizes.TEXT_SIZE_14,
                  color: AppColors.greyShade7,
                ),
                suffixIcon: Icon(
                  FeatherIcons.user,
                  size: Sizes.ICON_SIZE_22,
                  color: AppColors.greyShade7,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Sizes.RADIUS_14)),
                  borderSide: BorderSide(
                      color: AppColors.grey,
                      width: Sizes.WIDTH_1,
                      style: BorderStyle.solid),
                ),
                filled: true,
                fillColor: Color.fromARGB(94, 200, 201, 205),
              ),
            ),
            SizedBox(height: 40.0),
            Center(
              child: Text(
                'A verification code will be sent to your email:',
                style: TextStyle(
                  color: AppColors.blackShade3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                _usernameController.text,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Container(
                      width: widthOfScreen * 0.6,
                      child: ElevatedButton(
                        onPressed: () {
                          String enteredUsername =
                              _usernameController.text.trim();
                          if (enteredUsername.isNotEmpty) {
                            sendVerificationEmail(enteredUsername);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Error'),
                                content: Text('Please enter your username.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: Sizes.TEXT_SIZE_16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.deepsea),
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 25.0),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/Verify_Phone_Number');
                },
                child: Text(
                  'Use phone number to reset password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepsea,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
