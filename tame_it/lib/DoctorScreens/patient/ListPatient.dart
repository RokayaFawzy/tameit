import 'package:flutter/material.dart';

import '../../values/values.dart'; // Ensure you have this file with the color definitions

class ListPatient extends StatefulWidget {
  const ListPatient({super.key});

  @override
  State<ListPatient> createState() => _ListPatientState();
}

class _ListPatientState extends State<ListPatient> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> patients = List.generate(
    10,
    (index) => {"name": "Doctor Name", "email": "doctor.email@example.com"},
  );
  List<Map<String, String>> filteredPatients = [];

  @override
  void initState() {
    super.initState();
    filteredPatients = patients;
  }

  void _filterPatients(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredPatients = patients;
      });
    } else {
      setState(() {
        filteredPatients = patients
            .where((patient) =>
                patient["name"]!.toLowerCase().contains(query.toLowerCase()) ||
                patient["email"]!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        backgroundColor: AppColors.whiteShade3,
        title: Text(
          'List Patients',
          style: TextStyle(
            color: AppColors.deepsea,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Find Patient',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: _filterPatients,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPatients.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon:
                                    Icon(Icons.close, color: AppColors.deepsea),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(
                                        'assets/images/userimage.jpg'), // Replace with your image asset
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filteredPatients[index]['name']!,
                                        style: TextStyle(
                                          color: AppColors.deepsea,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        filteredPatients[index]['email']!,
                                        style: TextStyle(
                                          color: AppColors.deepsea,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
