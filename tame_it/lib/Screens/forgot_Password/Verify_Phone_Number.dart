import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tame_it/Screens/forgot_Password/verification_code.dart';
import 'package:tame_it/widgets/custom_button.dart';
import '../../values/values.dart';

class PhoneVerify extends StatefulWidget {
  const PhoneVerify({super.key});

  @override
  State<PhoneVerify> createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  String? phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar:AppBar(
          title: Center(
              child: Text('Verify Your phone number',
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ))),
          iconTheme: const IconThemeData(color: AppColors.deepsea),
          backgroundColor: AppColors.whiteShade3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    " We have sent your SMS with code to your Phone number",
                    style: TextStyle(
                      color: AppColors.Bermuda,
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                      // letterSpacing: 1,
                      wordSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // CustomTextField(
              //     inputType: TextInputType.number,
              //     onChange: (data) {
              //       phone = data;
              //     },
              //     hintText: 'phone number'),
              const IntlPhoneField(
                decoration: InputDecoration(
                  labelText: "phoneNumber",
                  labelStyle: TextStyle(
                      color: AppColors.deepsea), // Using a predefined color

                  // hintStyle:TextStyle(fontStyle: FontStyle.italic),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: "Next",
                color: AppColors.deepsea,
                textStyle: const TextStyle(
                  fontSize: 16, // Adjust the font size as needed
                  color: Colors.white, // Change the text color as needed
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CodePhone(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
