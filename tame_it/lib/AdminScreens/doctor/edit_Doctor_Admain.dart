import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/AdminScreens/adminhome.dart';
import '../../values/values.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';

class EditDoctorAdmin extends StatefulWidget {
  final int doctorId;

  const EditDoctorAdmin({Key? key, required this.doctorId}) : super(key: key);

  @override
  State<EditDoctorAdmin> createState() => _EditDoctorAdminState();
}

class _EditDoctorAdminState extends State<EditDoctorAdmin> {
  List<Widget> _clinicFields = [];
  List<Widget> _specializationFields = [];
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _yearsOfExperienceController =
      TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final List<TextEditingController> _specializationControllers = [];
  final List<Map<String, TextEditingController>> _clinicControllers = [];
  File? _selectedImage;

  String? _selectedGender;
  final List<String> _genderOptions = ['MALE', 'FEMALE'];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addSpecializationField();
    _addClinicField();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _priceController.dispose();
    _jobTitleController.dispose();
    _yearsOfExperienceController.dispose();
    _aboutController.dispose();
    for (var controller in _specializationControllers) {
      controller.dispose();
    }
    for (var clinic in _clinicControllers) {
      clinic['clinicName']?.dispose();
      clinic['address']?.dispose();
      clinic['phoneNumber']?.dispose();
    }
    super.dispose();
  }

  void _addSpecializationField() {
    final controller = TextEditingController();
    _specializationControllers.add(controller);
    _specializationFields.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: controller,
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
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _addSpecializationField();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addClinicField() {
    final clinic = {
      'clinicName': TextEditingController(),
      'address': TextEditingController(),
      'phoneNumber': TextEditingController(),
    };
    _clinicControllers.add(clinic);
    _clinicFields.add(
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Clinic',
                    style: const TextStyle(color: AppColors.deepsea),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _addClinicField();
                    });
                  },
                ),
              ],
            ),
          ),
          CustomTextFormField(
            controller: clinic['clinicName'],
            hintText: 'Clinic Name',
            enabledBorder: Borders.customOutlineInputBorder(
              color: AppColors.deepsea,
            ),
            focusedBorder: Borders.customUnderlineInputBorder(
              color: AppColors.orange,
            ),
          ),
          CustomTextFormField(
            controller: clinic['address'],
            hintText: 'Address',
            enabledBorder: Borders.customOutlineInputBorder(
              color: AppColors.deepsea,
            ),
            focusedBorder: Borders.customUnderlineInputBorder(
              color: AppColors.orange,
            ),
          ),
          CustomTextFormField(
            controller: clinic['phoneNumber'],
            hintText: 'Phone Number',
            enabledBorder: Borders.customOutlineInputBorder(
              color: AppColors.deepsea,
            ),
            focusedBorder: Borders.customUnderlineInputBorder(
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> editDoctor() async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    String url =
        'https://tameit.azurewebsites.net/api/admin/editDoctor/${widget.doctorId}';

    Map<String, dynamic> body = {};

    if (_firstNameController.text.isNotEmpty) {
      body['firstName'] = _firstNameController.text;
    }
    if (_lastNameController.text.isNotEmpty) {
      body['lastName'] = _lastNameController.text;
    }
    if (_phoneNumberController.text.isNotEmpty) {
      body['phoneNumber'] = _phoneNumberController.text;
    }
    if (_ratingController.text.isNotEmpty) {
      body['rating'] = int.parse(_ratingController.text);
    }
    if (_priceController.text.isNotEmpty) {
      body['price'] = int.parse(_priceController.text);
    }
    if (_yearsOfExperienceController.text.isNotEmpty) {
      body['yearsOfExperience'] = int.parse(_yearsOfExperienceController.text);
    }
    if (_jobTitleController.text.isNotEmpty) {
      body['jobTitle'] = _jobTitleController.text;
    }
    if (_selectedGender != null) {
      body['gender'] = _selectedGender;
    }
    if (_specializationControllers.isNotEmpty) {
      body['specializations'] = _specializationControllers
          .map((controller) => controller.text)
          .toList();
    }
    if (_clinicControllers.isNotEmpty) {
      body['clinics'] = _clinicControllers.map((clinic) {
        return {
          'clinicName': clinic['clinicName']?.text,
          'address': clinic['address']?.text,
          'phoneNumber': clinic['phoneNumber']?.text,
        };
      }).toList();
    }
    if (_aboutController.text.isNotEmpty) {
      body['about'] = _aboutController.text;
    }

    print(
        'Edit Doctor Request Body: ${jsonEncode(body)}'); // Add this line to print the request body

    var request = http.MultipartRequest('PATCH', Uri.parse(url))
      ..headers['Authorization'] = 'Bearer $token';

    if (_selectedImage != null) {
      request.files
          .add(await http.MultipartFile.fromPath('file', _selectedImage!.path));
    }

    request.fields['json'] = jsonEncode(body);

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Doctor edited successfully');
        _showSuccessDialog();
      } else {
        String responseBody = await response.stream.bytesToString();
        print('Failed to edit doctor. Status code: ${response.statusCode}');
        print('Response body: $responseBody');
        _showFailureDialog();
      }
    } catch (e) {
      print('Error editing doctor: $e');
      _showFailureDialog();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _selectedImage = File(pickedFile.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Doctor information updated successfully.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showFailureDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failure'),
          content: const Text('Failed to update doctor information.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Doctor',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.70,
          ),
        ),
        shadowColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black38,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : AssetImage('assets/images/userimage.jpg')
                                  as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 1,
                        left: 3,
                        child: Align(
                          alignment: const Alignment(0.2, 0),
                          child: GestureDetector(
                            onTap: () => _showImageSourceActionSheet(context),
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _firstNameController,
                    hintText: 'First Name',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _lastNameController,
                    hintText: 'Last Name',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _phoneNumberController,
                    hintText: 'Phone Number',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _priceController,
                    hintText: 'Price',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _jobTitleController,
                    hintText: 'Job Title',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _yearsOfExperienceController,
                    hintText: 'Years of Experience',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _ratingController,
                    hintText: 'Rating',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    items: _genderOptions
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Select Gender',
                      enabledBorder: Borders.customOutlineInputBorder(
                        color: AppColors.deepsea,
                      ),
                      focusedBorder: Borders.customUnderlineInputBorder(
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _aboutController,
                    hintText: 'About',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._specializationFields,
                  const SizedBox(height: 16),
                  ..._clinicFields,
                  const SizedBox(height: 32),
                  CustomButton(
                    onPressed: editDoctor,
                    title: 'Submit',
                    textStyle: const TextStyle(color: Colors.white),
                    color: AppColors.OrangePeel,
                  ),
                ],
              ),
              if (_isLoading)
                Center(
                  child:
                      CircularProgressIndicator(), // Display loading indicator
                ),
            ],
          ),
        ),
      ),
    );
  }
}
