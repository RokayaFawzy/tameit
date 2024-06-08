import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../values/values.dart';
import '../../widgets/custom_button.dart';

class SelectFreeTime extends StatefulWidget {
  const SelectFreeTime({super.key});

  @override
  State<SelectFreeTime> createState() => _SelectFreeTimeState();
}

class _SelectFreeTimeState extends State<SelectFreeTime> {
  final List<DateTime> _dates = [DateTime.now()];
  final List<List<String>> _availableTimes = [
    ["10:00 AM", "12:00 PM", "1:00 PM", "3:00 PM", "5:00 PM"]
  ];

  void _addDateTimeSection() {
    setState(() {
      _dates.add(DateTime.now());
      _availableTimes
          .add(["10:00 AM", "12:00 PM", "1:00 PM", "3:00 PM", "5:00 PM"]);
    });
  }

  void _updateDate(int index, DateTime date) {
    setState(() {
      _dates[index] = date;
    });
  }

  void _addTime(int index, String time) {
    setState(() {
      _availableTimes[index].add(time);
    });
  }

  void _removeTime(int index, String time) {
    setState(() {
      _availableTimes[index].remove(time);
    });
  }

  Widget _buildDateTimeSection(int index) {
    TextEditingController _dateController = TextEditingController();
    _dateController.text = DateFormat('yyyy-MM-dd').format(_dates[index]);

    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Row(
            children: [
              Text(
                "Choose Date",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepsea,
                  fontFamily: "Domine",
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _dateController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today_rounded),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dates[index],
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2110),
                  );
                  if (pickedDate != null) {
                    _updateDate(index, pickedDate);
                    _dateController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
              ),
              labelText: "Select Date",
            ),
            readOnly: true,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                "Available Time",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Domine",
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepsea,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.add, color: AppColors.deepsea),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController _timeController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text("Add Time"),
                        content: TextField(
                          controller: _timeController,
                          decoration: InputDecoration(
                            labelText: "Enter Time (e.g., 10:00 AM)",
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_timeController.text.isNotEmpty) {
                                _addTime(index, _timeController.text);
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text("Add"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 2.0,
          runSpacing: 2.0,
          children: _availableTimes[index].map((time) {
            return Chip(
              label: Text(time),
              onDeleted: () {
                _removeTime(index, time);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Select Free Time',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                            'assets/images/userimage.jpg'), // Replace with your image asset
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr. Georgia Griffin",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepsea,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Psychologist",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.deepsea,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  const Divider(
                    color: AppColors.deepsea,
                    thickness: 0.1,
                    height: 8,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          "Choose Available time and Date",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepsea,
                            fontFamily: "Domine",
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.add, color: AppColors.deepsea),
                          onPressed: _addDateTimeSection,
                        ),
                      ],
                    ),
                  ),
                  ..._dates.asMap().entries.map((entry) {
                    int index = entry.key;
                    return _buildDateTimeSection(index);
                  }).toList(),
                  SizedBox(
                    height: 190,
                  ),
                  Container(
                    width: 330,
                    child: CustomButton(
                      title: "Done",
                      color: AppColors.deepsea,
                      textStyle:
                          TextStyle(color: AppColors.white, fontSize: 19),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
