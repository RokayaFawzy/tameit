import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../widgets/custom_button.dart';

class EditInformation extends StatefulWidget {
  EditInformation({super.key});

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  String? valueChoose;
  List ListItem = ['FEMALE', 'MALE'];
  final TextEditingController _date = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _getImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
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
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromCamera();
                },
              ),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
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
                        backgroundImage: _image != null
                            ? FileImage(File(_image!.path))
                            : AssetImage('assets/images/123.jpg')
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
                          onPressed: () => _showImageSourceActionSheet(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                textInputType: TextInputType.text,
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.blackShade2,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
                hintText: 'First Name',
              ),
              const SizedBox(height: 9),
              CustomTextFormField(
                textInputType: TextInputType.text,
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.blackShade2,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
                hintText: 'Last Name',
              ),
              const SizedBox(height: 9),
              CustomTextFormField(
                textInputType: TextInputType.text,
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.blackShade2,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
                hintText: 'Email',
              ),
              const SizedBox(height: 9),
              const IntlPhoneField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(color: AppColors.deepsea),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              CustomTextFormField(
                textInputType: TextInputType.text,
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.blackShade2,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
                hintText: 'Country',
              ),
              const SizedBox(height: 9),
              CustomTextFormField(
                textInputType: TextInputType.text,
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.blackShade2,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
                hintText: 'City',
              ),
              const SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.only(left: 1, right: 1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    hint: Text("   Select the Gender"),
                    dropdownColor: AppColors.whiteShade1,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    underline: SizedBox(),
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    value: valueChoose,
                    onChanged: (newValue) {
                      setState(() {
                        valueChoose = newValue as String?;
                      });
                    },
                    items: ListItem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _date,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: "Birth Date",
                    labelStyle: TextStyle(
                      color: AppColors.blackShade2,
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2110),
                    );
                    if (pickeddate != null) {
                      setState(() {
                        _date.text =
                            DateFormat('dd-MM-yyyy').format(pickeddate);
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 18),
              CustomButton(
                title: "Save Changes",
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                color: AppColors.deepsea,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
