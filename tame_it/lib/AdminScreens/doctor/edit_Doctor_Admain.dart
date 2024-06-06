import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class EditDoctorAdmain extends StatefulWidget {
  const EditDoctorAdmain({super.key});

  @override
  State<EditDoctorAdmain> createState() => _EditDoctorAdmainState();
}

class _EditDoctorAdmainState extends State<EditDoctorAdmain> {
  // List to keep track of clinic fields
  List<Widget> _clinicFields = [];
  // List to keep track of specialization fields
  List<Widget> _specializationFields = [];

  @override
  void initState() {
    super.initState();
    // Add initial specialization field
    _specializationFields.add(_buildSpecializationField());
    // Add initial clinic field
    _clinicFields.add(_buildClinicField());
  }

  // Function to build a specialization field
  Widget _buildSpecializationField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              hintText: 'Specialization',
              enabledBorder: Borders.customOutlineInputBorder(
                color: AppColors.deepsea,
              ),
              focusedBorder: Borders.customUnderlineInputBorder(
                color: AppColors.orange,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _specializationFields.add(_buildSpecializationField());
              });
            },
          ),
        ],
      ),
    );
  }

  // Function to build a clinic field
  Widget _buildClinicField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Clinic',
                  style: TextStyle(color: AppColors.deepsea),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _clinicFields.add(_buildClinicField());
                  });
                },
              ),
            ],
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '                     Edit Doctor',
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

              Column(
                children: _specializationFields,
              ),
              const SizedBox(
                height: 9,
              ),

              // Add clinic fields here
              Column(
                children: _clinicFields,
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
                      title: "Edit",
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
