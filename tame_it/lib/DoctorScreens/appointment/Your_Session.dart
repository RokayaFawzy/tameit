import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';

class YourSessionPage extends StatefulWidget {
  final String sessionTime;

  const YourSessionPage({Key? key, required this.sessionTime})
      : super(key: key);

  @override
  State<YourSessionPage> createState() => _YourSessionPageState();
}

class _YourSessionPageState extends State<YourSessionPage> {
  String _sessionType = 'offline'; // Default selected session type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Your Session',
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
                  const SizedBox(height: 10),
                  const Divider(
                    color: AppColors.deepsea,
                    thickness: 0.1,
                    height: 8,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Your Session Is At ${widget.sessionTime}',
                          style: const TextStyle(
                            color: AppColors.OrangePeel,
                            fontFamily: "Domine",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Type Of Session',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.deepsea,
                              fontFamily: "Domine",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'online',
                            groupValue: _sessionType,
                            onChanged: (value) {
                              setState(() {
                                _sessionType = value!;
                              });
                            },
                          ),
                          const Text(
                            'Online',
                            style: TextStyle(
                                fontSize: 18, color: AppColors.OrangePeel),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'offline',
                            groupValue: _sessionType,
                            onChanged: (value) {
                              setState(() {
                                _sessionType = value!;
                              });
                            },
                          ),
                          const Text(
                            'Offline',
                            style: TextStyle(
                                fontSize: 18, color: AppColors.OrangePeel),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Price',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.deepsea,
                              fontFamily: "Domine",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$34',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.deepsea,
                              fontFamily: "Domine",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
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
