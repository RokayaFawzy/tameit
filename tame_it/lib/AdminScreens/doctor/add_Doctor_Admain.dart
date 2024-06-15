import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../values/values.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import '../adminhome.dart';

class AddDoctorAdmin extends StatefulWidget {
  const AddDoctorAdmin({super.key});

  @override
  State<AddDoctorAdmin> createState() => _AddDoctorAdminState();
}

class _AddDoctorAdminState extends State<AddDoctorAdmin> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _priceController = TextEditingController();
  final _ratingController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _yearsOfExperienceController = TextEditingController();
  final _aboutController = TextEditingController();

  String? _selectedGender;
  final List<String> _genderOptions = ['MALE', 'FEMALE'];

  List<TextEditingController> _specializationControllers = [];
  List<Map<String, TextEditingController>> _clinicControllers = [];

  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addSpecializationField();
    _addClinicField();
  }

  void _addSpecializationField() {
    setState(() {
      _specializationControllers.add(TextEditingController());
    });
  }

  void _addClinicField() {
    setState(() {
      _clinicControllers.add({
        'clinicName': TextEditingController(),
        'address': TextEditingController(),
        'phoneNumber': TextEditingController(),
      });
    });
  }

  Widget _buildSpecializationField(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: _specializationControllers[index],
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
            onPressed: _addSpecializationField,
          ),
        ],
      ),
    );
  }

  Widget _buildClinicField(int index) {
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
                onPressed: _addClinicField,
              ),
            ],
          ),
        ),
        CustomTextFormField(
          controller: _clinicControllers[index]['clinicName'],
          hintText: 'Clinic Name',
          enabledBorder: Borders.customOutlineInputBorder(
            color: AppColors.deepsea,
          ),
          focusedBorder: Borders.customUnderlineInputBorder(
            color: AppColors.orange,
          ),
        ),
        CustomTextFormField(
          controller: _clinicControllers[index]['address'],
          hintText: 'Address',
          enabledBorder: Borders.customOutlineInputBorder(
            color: AppColors.deepsea,
          ),
          focusedBorder: Borders.customUnderlineInputBorder(
            color: AppColors.orange,
          ),
        ),
        CustomTextFormField(
          controller: _clinicControllers[index]['phoneNumber'],
          hintText: 'Phone Number',
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

  Future<void> _submitData() async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      _showErrorDialog('Token not found. Please login again.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url = 'https://tameit.azurewebsites.net/api/admin/addDoctor';

    final specializations = _specializationControllers
        .map((controller) => controller.text)
        .toList();
    final clinics = _clinicControllers.map((clinic) {
      return {
        'clinicName': clinic['clinicName']!.text,
        'address': clinic['address']!.text,
        'phoneNumber': clinic['phoneNumber']!.text,
      };
    }).toList();

    final Map<String, dynamic> body = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'phoneNumber': _phoneNumberController.text,
      'rating': _ratingController.text.isEmpty
          ? 'Not provided'
          : int.parse(_ratingController.text),
      'price': _priceController.text.isEmpty
          ? 'Not provided'
          : int.parse(_priceController.text),
      'yearsOfExperience': _yearsOfExperienceController.text.isEmpty
          ? 'Not provided'
          : int.parse(_yearsOfExperienceController.text),
      'jobTitle': _jobTitleController.text.isEmpty
          ? 'Not provided'
          : _jobTitleController.text,
      'gender': _selectedGender ?? 'Not provided',
      'registerRequest': {
        'userName': _userNameController.text.isEmpty
            ? 'Not provided'
            : _userNameController.text,
        'email': _emailController.text.isEmpty
            ? 'Not provided'
            : _emailController.text,
      },
      'specializations': specializations,
      'clinics': clinics,
      'about': _aboutController.text.isEmpty
          ? 'Not provided'
          : _aboutController.text,
    };

    print('Data to be sent: ${jsonEncode(body)}');

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers['Authorization'] = 'Bearer $token';

    if (_selectedImage != null) {
      request.files
          .add(await http.MultipartFile.fromPath('file', _selectedImage!.path));
    }

    request.fields.addAll({'json': jsonEncode(body)});

    print('Request headers: ${request.headers}');
    print('Request fields: ${request.fields}');
    if (_selectedImage != null) {
      print('Request files: ${request.files.first.filename}');
    }

    try {
      var response = await request.send();

      if (response.statusCode == 201) {
        print('Data sent successfully');
        setState(() {
          _isLoading = false;
        });
        _showSuccessDialog();
      } else {
        String responseBody = await response.stream.bytesToString();
        print('Failed to send data: ${response.statusCode}');
        print('Response body: $responseBody');
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog('Failed to submit data. Error: $responseBody');
      }
    } catch (e) {
      print('Error occurred while sending data: $e');
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(
          'Error occurred while submitting data. Please try again.');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Data submitted successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  // Navigate to AdminHomePage
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomePage()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String s) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to submit data. Please try again later.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Future<void> _pickImage() async {
  //   PermissionStatus status = await Permission.photos.request();

  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _selectedImage = File(pickedFile.path);
  //     }
  //   });
  // }
  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
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
              // ListTile(
              //   leading: Icon(Icons.camera_alt),
              //   title: Text('Camera'),
              //   onTap: () async {
              //     Navigator.of(context).pop();
              //     final pickedFile =
              //         await ImagePicker().pickImage(source: ImageSource.camera);
              //     if (pickedFile != null) {
              //       setState(() {
              //         _selectedImage = File(pickedFile.path);
              //       });
              //     }
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.whiteShade3,
          appBar: AppBar(
              backgroundColor: AppColors.whiteShade3,
              title: const Text('ADD Doctor',
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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black38,
                          child: CircleAvatar(
                            radius: 49,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : AssetImage('assets/images/userimage.jpg')
                                    as ImageProvider,
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
                            child: IconButton(
                              icon: Icon(Icons.camera_alt_outlined),
                              color: Colors.white,
                              iconSize: 17,
                              onPressed: () {
                                _showImageSourceActionSheet(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'First Name',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
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
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Last Name',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
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
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'registerRequest',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
                  CustomTextFormField(
                    controller: _userNameController,
                    hintText: 'userName',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'email',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'price',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
                  CustomTextFormField(
                    controller: _priceController,
                    hintText: 'price',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Phone number',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
                  CustomTextFormField(
                    controller: _phoneNumberController,
                    hintText: 'Phone number',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'rating',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
                  CustomTextFormField(
                    controller: _ratingController,
                    hintText: 'rating',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Job Title',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
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
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'year of experience',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
                  CustomTextFormField(
                    controller: _yearsOfExperienceController,
                    hintText: 'year of experience',
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'About',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
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
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Gender',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: Borders.customOutlineInputBorder(
                        color: AppColors.deepsea,
                      ),
                      focusedBorder: Borders.customUnderlineInputBorder(
                        color: AppColors.orange,
                      ),
                    ),
                    hint: Text('Select Gender'),
                    value: _selectedGender,
                    items: _genderOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Specialization',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
                  // Add specialization fields here
                  Column(
                    children: List.generate(_specializationControllers.length,
                        (index) => _buildSpecializationField(index)),
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Clinics',
                      style: TextStyle(color: AppColors.deepsea),
                    ),
                  ),
                  // Add clinic fields here
                  Column(
                    children: List.generate(_clinicControllers.length,
                        (index) => _buildClinicField(index)),
                  ),
                  const SizedBox(height: 12),
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
                        onPressed: _isLoading ? null : _submitData,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading) // Show loading indicator if _isLoading is true
          Container(
            color: Colors.black.withOpacity(0.5), // Opacity 0.5
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
