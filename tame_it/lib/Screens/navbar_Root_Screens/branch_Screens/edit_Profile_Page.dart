import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_text_form_field.dart';
import '../../../widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditInformation extends StatefulWidget {
  EditInformation({Key? key}) : super(key: key);

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  List<String> listItem = ['FEMALE', 'MALE'];
  late TextEditingController _date;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _valueChoose;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool _isLoading = false;
  String? _storedImagePath;

  @override
  void initState() {
    super.initState();
    _date = TextEditingController();
    _getImagePath();
  }

  Future<void> _getImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedImagePath = prefs.getString('userImagePath');
    });
  }

  Future<void> _getImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _changeUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (_image == null || token == null) return;

    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse('https://tameit.azurewebsites.net/api/user/changeUserImage'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
    request.fields['name'] = 'image';

    var response = await request.send();
    if (response.statusCode == 200) {
      print('User image updated successfully.');
      var imagePath =
          json.decode(await response.stream.bytesToString())['data'];
      prefs.setString('userImagePath', imagePath);
      setState(() {
        _storedImagePath = imagePath;
      });
    } else {
      print('Failed to update user image.');
    }
  }

  Future<void> _editPatientDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) return;
    final url = Uri.parse(
        'https://tameit.azurewebsites.net/api/patient/editPatientDetails');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, dynamic> requestBody = {};

    if (_firstNameController.text.isNotEmpty) {
      requestBody['firstName'] = _firstNameController.text;
    }
    if (_lastNameController.text.isNotEmpty) {
      requestBody['lastName'] = _lastNameController.text;
    }
    if (_emailController.text.isNotEmpty) {
      requestBody['email'] = _emailController.text;
    }
    if (_phoneNumberController.text.isNotEmpty) {
      requestBody['phoneNumber'] = _phoneNumberController.text;
    }
    if (_valueChoose != null) {
      requestBody['gender'] = _valueChoose?.toUpperCase();
    }
    if (_cityController.text.isNotEmpty) {
      requestBody['city'] = _cityController.text;
    }
    if (_countryController.text.isNotEmpty) {
      requestBody['country'] = _countryController.text;
    }
    if (_date.text.isNotEmpty) {
      requestBody['birthDate'] = _date.text;
    }

    final body = json.encode(requestBody);

    final response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Patient details updated successfully.');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Patient details updated successfully.'),
            actions: [
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
    } else {
      print('Failed to update patient details. Response: ${response.body}');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update patient details.'),
            actions: [
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
  }

  Future<void> _saveChanges() async {
    // if (_firstNameController.text.isEmpty ||
    //     _lastNameController.text.isEmpty ||
    //     _emailController.text.isEmpty ||
    //     _phoneNumberController.text.isEmpty ||
    //     _valueChoose == null ||
    //     _cityController.text.isEmpty ||
    //     _countryController.text.isEmpty ||
    //     _date.text.isEmpty) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text('Error'),
    //         content: Text('Please fill in all fields.'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    //   return;
    // }

    setState(() {
      _isLoading = true;
    });
    await _changeUserImage();
    await _editPatientDetails();
    setState(() {
      _isLoading = false;
    });
  }

  void _storeSelectedGender(String? gender) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('gender', gender ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: const Text(
          'Edit profile',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 16,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w700,
            height: 1.70,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.white,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
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
                            backgroundImage: _storedImagePath != null
                                ? CachedNetworkImageProvider(_storedImagePath!)
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
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 17,
                              ),
                              onPressed: () =>
                                  _showImageSourceActionSheet(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    controller: _firstNameController,
                    textInputType: TextInputType.text,
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                    hintText: 'First Name',
                  ),
                  const SizedBox(height: 9),
                  CustomTextFormField(
                    controller: _lastNameController,
                    textInputType: TextInputType.text,
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                    hintText: 'Last Name',
                  ),
                  const SizedBox(height: 9),
                  CustomTextFormField(
                    controller: _emailController,
                    textInputType: TextInputType.text,
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 9),
                  IntlPhoneField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyle(color: AppColors.deepsea),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  CustomTextFormField(
                    controller: _countryController,
                    textInputType: TextInputType.text,
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                    hintText: 'Country',
                  ),
                  const SizedBox(height: 9),
                  CustomTextFormField(
                    controller: _cityController,
                    textInputType: TextInputType.text,
                    enabledBorder: Borders.customOutlineInputBorder(
                      color: AppColors.deepsea,
                    ),
                    focusedBorder: Borders.customUnderlineInputBorder(
                      color: AppColors.orange,
                    ),
                    hintText: 'City',
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Gender',
                      ),
                      value: _valueChoose,
                      items: listItem.map((String? valueItem) {
                        return DropdownMenuItem<String>(
                          value: valueItem,
                          child: Text(
                            valueItem!,
                            style: TextStyle(
                              color: AppColors.deepsea,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valueChoose = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _date,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "Birth Date",
                        labelStyle: TextStyle(
                          color: AppColors.deepsea,
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2110),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _date.text =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  CustomButton(
                    title: "Save Changes",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    color: AppColors.deepsea,
                    onPressed: () async {
                      await _saveChanges();
                    },
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: FutureBuilder(
                    future: Future.delayed(Duration(seconds: 20)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        _isLoading = false;
                        return Text(
                            'Loading timeout it will Loading soon go on',
                            style: TextStyle(color: Colors.white));
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
