import 'package:flutter/material.dart';
import '../../values/values.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class DoctorSessionScreen extends StatefulWidget {
  @override
  _DoctorSessionScreenState createState() => _DoctorSessionScreenState();
}

class _DoctorSessionScreenState extends State<DoctorSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
            backgroundColor: AppColors.whiteShade3,
            title: const Text('Doctor Session',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.70,
                )),
            shadowColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.deepsea)),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      // backgroundImage: ,
                    ),
                    title: Text(
                      'abc',
                      style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: AppColors.deepsea),
                    ),
                    subtitle: Text('-------@gmail.com',
                        style:
                            TextStyle(fontSize: 18, color: AppColors.deepsea)),
                  ),
                  Divider(),
                ],
              ),
              SizedBox(height: 20),
              Text('Him/His Session At 10:00am',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 20),
              Text('Type Of Session',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 8),
              CustomTextFormField(
                hintText: 'Online',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              SizedBox(height: 20),
              Text('Price',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 8),
              CustomTextFormField(
                hintText: '\$24',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              Spacer(),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 226,
                      child: CustomButton(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        color: AppColors.deepsea,
                        title: "Done",
                        onPressed: () {},
                      )))
            ])));
  }
}
