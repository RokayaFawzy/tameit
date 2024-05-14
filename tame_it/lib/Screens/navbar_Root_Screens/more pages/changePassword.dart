import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  bool _isNewPasswordVisible = false;
  bool _isConfirmNewPasswordVisible = false;
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _changePassword(String currentPassword, String newPassword,
      String confirmNewPassword) async {
    try {
      if (newPassword != confirmNewPassword) {
        // Show error message for password mismatch
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      String? authToken = await _getToken(); // Retrieve stored token
      if (authToken == null) {
        // Handle token not found (e.g., user not logged in)
        return;
      }

      var url = 'https://tameit.azurewebsites.net/api/auth/changePassword';
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'confirmNewPassword': confirmNewPassword,
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Password changed successfully
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password changed successfully'),
          backgroundColor: Colors.green,
        ));
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmNewPasswordController.clear();
        // You can navigate to another screen or perform other actions on success
      } else {
        // Password change failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to change password. Please try again.'),
          backgroundColor: Colors.red,
        ));
        // Handle other error scenarios based on response.statusCode
      }
    } catch (e) {
      print('Error changing password: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred while changing password.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: Text(
          'Change Password',
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
            SizedBox(height: Sizes.HEIGHT_14),
            SizedBox(
              height: Sizes.HEIGHT_50,
              child: TextField(
                controller: _currentPasswordController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(
                  fontSize: Sizes.TEXT_SIZE_14,
                ),
                decoration: InputDecoration(
                  hintText: ' Enter current password',
                  hintStyle: Styles.customTextStyle(
                    fontSize: Sizes.TEXT_SIZE_14,
                    color: Color.fromARGB(255, 137, 182, 177),
                  ),
                  enabled: true,
                  enabledBorder: const OutlineInputBorder(
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
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              height: Sizes.HEIGHT_50,
              child: TextField(
                controller: _newPasswordController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(
                  fontSize: Sizes.TEXT_SIZE_14,
                ),
                decoration: InputDecoration(
                  hintText: ' New password',
                  hintStyle: Styles.customTextStyle(
                    fontSize: Sizes.TEXT_SIZE_14,
                    color: Color.fromARGB(255, 137, 182, 177),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible
                          ? FeatherIcons.eye
                          : FeatherIcons.eyeOff,
                      size: Sizes.ICON_SIZE_22,
                      color: Color.fromARGB(255, 137, 182, 177),
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                  enabled: true,
                  enabledBorder: const OutlineInputBorder(
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
                obscureText: !_isNewPasswordVisible,
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              height: Sizes.HEIGHT_50,
              child: TextField(
                controller: _confirmNewPasswordController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(fontSize: Sizes.TEXT_SIZE_14),
                decoration: InputDecoration(
                  hintText: ' Confirm new password',
                  hintStyle: Styles.customTextStyle(
                    fontSize: Sizes.TEXT_SIZE_14,
                    color: Color.fromARGB(255, 137, 182, 177),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmNewPasswordVisible
                          ? FeatherIcons.eye
                          : FeatherIcons.eyeOff,
                      size: Sizes.ICON_SIZE_22,
                      color: Color.fromARGB(255, 137, 182, 177),
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmNewPasswordVisible =
                            !_isConfirmNewPasswordVisible;
                      });
                    },
                  ),
                  enabled: true,
                  enabledBorder: const OutlineInputBorder(
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
                obscureText: !_isConfirmNewPasswordVisible,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              width: widthOfScreen * 0.6,
              child: CustomButton(
                title: 'Save',
                color: AppColors.deepsea,
                textStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: () {
                  String currentPassword =
                      _currentPasswordController.text.trim();
                  String newPassword = _newPasswordController.text.trim();
                  String confirmNewPassword =
                      _confirmNewPasswordController.text.trim();
                  _changePassword(
                      currentPassword, newPassword, confirmNewPassword);
                },
              ),
            ),
            SizedBox(height: Sizes.HEIGHT_25),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }
}
