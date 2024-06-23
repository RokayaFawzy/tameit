import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:http/http.dart' as http;
import 'package:tame_it/Screens/Login.dart';
import 'package:tame_it/Screens/forgot_Password/SuccessPage.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_button.dart';

class ResetPassword extends StatefulWidget {
  final String username;

  const ResetPassword({Key? key, required this.username}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> resetPassword(String newPassword, String confirmPassword) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final apiUrl =
        'https://tameit.azurewebsites.net/api/auth/forgotPassword/resetPassword/${widget.username}';
    final Map<String, String> requestBody = {
      'newPassword': newPassword,
      'confirmNewPassword': confirmPassword,
    };

    print('API URL: $apiUrl');
    print('Request Body: $requestBody');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Password reset successful
        print('Password reset successful.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Successpage()),
        );
      } else if (response.statusCode == 417) {
        // Password reset failed due to a conflict
        print('Password reset failed. Status code: ${response.statusCode}');
        // Display error dialog to the user
        showErrorDialog(
            'Password reset failed due to a conflict. Please try again later.');
      } else {
        // Password reset failed
        print('Password reset failed. Status code: ${response.statusCode}');
        // Display error dialog to the user
        showErrorDialog(
            'Password reset failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or server errors
      print('Error resetting password: $e');
      // Display error dialog to the user
      showErrorDialog('Error resetting password. Please try again.');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
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

    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
        backgroundColor: AppColors.whiteShade3,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter a new password",
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontSize: Sizes.TEXT_SIZE_20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              controller: _newPasswordController,
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                fontSize: Sizes.TEXT_SIZE_14,
              ),
              decoration: InputDecoration(
                hintText: 'New password',
                hintStyle: TextStyle(
                  fontSize: Sizes.TEXT_SIZE_14,
                  color: Color.fromARGB(255, 137, 182, 177),
                ),
                suffixIcon: Icon(
                  FeatherIcons.eyeOff,
                  size: Sizes.ICON_SIZE_22,
                  color: Color.fromARGB(255, 137, 182, 177),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Sizes.RADIUS_14)),
                  borderSide: BorderSide(
                    color: AppColors.grey,
                    width: Sizes.WIDTH_1,
                    style: BorderStyle.solid,
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(94, 200, 201, 205),
              ),
              obscureText: true,
            ),
            SizedBox(height: 25),
            TextField(
              controller: _confirmPasswordController,
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                fontSize: Sizes.TEXT_SIZE_14,
              ),
              decoration: InputDecoration(
                hintText: 'Confirm password',
                hintStyle: TextStyle(
                  fontSize: Sizes.TEXT_SIZE_14,
                  color: Color.fromARGB(255, 137, 182, 177),
                ),
                suffixIcon: Icon(
                  FeatherIcons.eyeOff,
                  size: Sizes.ICON_SIZE_22,
                  color: Color.fromARGB(255, 137, 182, 177),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Sizes.RADIUS_14)),
                  borderSide: BorderSide(
                    color: AppColors.grey,
                    width: Sizes.WIDTH_1,
                    style: BorderStyle.solid,
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(94, 200, 201, 205),
              ),
              obscureText: true,
            ),
            SizedBox(height: 35),
            Container(
              width: widthOfScreen * 0.6,
              child: CustomButton(
                title: 'Change Password',
                color: AppColors.deepsea,
                textStyle: TextStyle(
                  fontSize: Sizes.TEXT_SIZE_16,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: () {
                  String newPassword = _newPasswordController.text.trim();
                  String confirmPassword =
                      _confirmPasswordController.text.trim();

                  if (newPassword.isEmpty || confirmPassword.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all fields.'),
                      ),
                    );
                    return; // Stop execution if fields are empty
                  }

                  if (newPassword != confirmPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Passwords do not match.'),
                      ),
                    );
                    return; // Stop execution if passwords don't match
                  }

                  // If all validations pass, proceed to reset password
                  resetPassword(newPassword, confirmPassword);
                },
              ),
            ),
            SizedBox(height: Sizes.HEIGHT_25),
            if (_isLoading)
              CircularProgressIndicator(), // Show loading indicator if _isLoading is true
          ],
        ),
      ),
    );
  }
}
