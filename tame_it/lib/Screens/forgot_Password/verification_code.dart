import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:tame_it/Screens/forgot_Password/Resetpassword.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_button.dart';

class CodePhone extends StatefulWidget {
  final String username;
  final Function(String) sendVerificationEmail;

  const CodePhone(
      {Key? key, required this.sendVerificationEmail, required this.username})
      : super(key: key);

  @override
  _CodePhoneState createState() => _CodePhoneState();
}

class _CodePhoneState extends State<CodePhone> {
  late TextEditingController _usernameController;

  bool _isResendAgain = false;
  bool _isLoading = false;

  String _code = '';
  late Timer _timer;
  int _start = 60;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void resend() {
    setState(() {
      _isResendAgain = true;
      _start = 60; // Reset timer
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  Future<void> verifyOTP() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });
    if (_code.length == 4) {
      String apiUrl =
          'https://tameit.azurewebsites.net/api/auth/forgotPassword/verifyOtp/$_code/${widget.username}';

      try {
        final response = await http.post(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          // Verification successful, navigate to ResetPassword screen
          // Navigator.pushNamed(context, '/ResetPassword');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPassword(username: widget.username),
            ),
          );
        } else {
          // Handle other status codes or errors
          final errorMessage = response.body;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('Failed to verify OTP: $errorMessage'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        // Handle network or server errors
        print('Error verifying OTP: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to verify OTP. Server error occurred.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Display error dialog if OTP is not complete
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a valid OTP.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false; // Set loading state back to false
    });
  }

  void resetOTP() {
    // Reset the entered code and trigger resend functionality
    setState(() {
      _code = '';
      _start = 60;
      _isResendAgain = true;
    });
    widget.sendVerificationEmail(widget.username);
    resend();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // Set loading state back to false after resend
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: Text(
          'Verification code',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 16,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'Please enter the verification code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'We have sent a verification code to your email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.Bermuda,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: VerificationCode(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    color: AppColors.Bermuda,
                  ),
                  length: 4,
                  onCompleted: (value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (value) {},
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive the OTP?',
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_isResendAgain) return;
                      resetOTP();
                    },
                    child: Text(
                      _isResendAgain
                          ? "Try Again in" + _start.toString()
                          : ' Resend',
                      style: TextStyle(
                        color: AppColors.deepsea,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              CustomButton(
                title: 'Next',
                color: AppColors.deepsea,
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                onPressed: _isLoading
                    ? null
                    : verifyOTP, // Disable button when loading
              ),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
