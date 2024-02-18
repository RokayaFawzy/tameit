import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_button.dart';

class EditInformation extends StatefulWidget {
  EditInformation({super.key});

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  String? valueChoose;
  List ListItem = ['Female', 'male'];
  final TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '                  Edit profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 16,
              fontFamily: 'NunitoSans',
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
              CustomTextFormField(
                textInputType: TextInputType.text,
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.blackShade2,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
                hintText: 'User Name',
              ),
              const SizedBox(
                height: 9,
              ),
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
              const SizedBox(
                height: 9,
              ),
              const IntlPhoneField(
                decoration: InputDecoration(
                    labelText: "phoneNumber",
                    labelStyle: TextStyle(color: AppColors.deepsea),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    )),
              ),
              const SizedBox(
                height: 9,
              ),
              CustomTextFormField(
                textInputType: TextInputType.text,
                enabledBorder: Borders.customOutlineInputBorder(
                  color: AppColors.blackShade2,
                ),
                focusedBorder: Borders.customUnderlineInputBorder(
                  color: AppColors.orange,
                ),
                hintText: 'Place',
              ),
              const SizedBox(
                height: 9,
              ),
              //TODO:Dropdown
              Padding(
                padding: const EdgeInsets.only(left: 1, right: 1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    hint: Text("   select the Gender"),
                    dropdownColor: AppColors.whiteShade1,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    underline: SizedBox(),
                    style: TextStyle(
                        color: AppColors.deepsea,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    value: valueChoose,
                    onChanged: (newValue) {
                      setState(() {
                        valueChoose = newValue! as String?;
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
              const SizedBox(
                height: 9,
              ),
              //TODO:Dropdown
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _date,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: "Select Date",
                    labelStyle: TextStyle(
                        color: AppColors
                            .blackShade2), // Text style for "Select Date"
                  ),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2110),
                      //TODO:change color from berbal to appcolor
                    );
                    if (pickeddate != null) {
                      setState(() {
                        _date.text =
                            DateFormat('yyyy-MM-dd').format(pickeddate);
                      });
                    }
                  },
                ),
              ),

              SizedBox(
                height: 18,
              ),
              CustomButton(
                title: "Save Changes",
                textStyle: const TextStyle(
                  fontSize: 16, // Adjust the font size as needed
                  color: Colors.white, // Change the text color as needed
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
