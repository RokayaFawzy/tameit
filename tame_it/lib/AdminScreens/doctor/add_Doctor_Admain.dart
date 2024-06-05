import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class AddDoctorAdmain extends StatefulWidget {
  const AddDoctorAdmain({super.key});

  @override
  State<AddDoctorAdmain> createState() => _AddDoctorAdmainState();
}

class _AddDoctorAdmainState extends State<AddDoctorAdmain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '                      ADD Doctor',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.70,
            ),
          ),
          shadowColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.deepsea)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Stack(children: [
                const Align(
                  alignment: AlignmentDirectional.center,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black38,
                    child: CircleAvatar(
                      radius: 49,
                      backgroundImage: AssetImage('assets/images/123.jpg'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 1,
                  left: 3,
                  child: Align(
                    alignment: const Alignment(0.2, 0),
                    child: Container(
                      width: 30,
                      height: 30,
                      color: AppColors.deepsea,
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'First Name',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              CustomTextFormField(
                hintText: 'First Name',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Last Name',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              CustomTextFormField(
                hintText: 'Last Name',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Location',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              CustomTextFormField(
                hintText: 'Location',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'price',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              CustomTextFormField(
                hintText: 'price',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Phone number',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              CustomTextFormField(
                hintText: 'Phone number',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Job Title',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              CustomTextFormField(
                hintText: 'Job Title',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'year of experience',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              CustomTextFormField(
                hintText: 'year of experience',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Specialization',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              CustomTextFormField(
                hintText: 'Specialization',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Clinic',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              CustomTextFormField(
                hintText: 'Clinic',
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.deepsea,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
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
                      title: "ADD",
                      onPressed: () {},
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
