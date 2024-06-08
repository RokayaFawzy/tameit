import 'package:flutter/material.dart';

import '../../values/values.dart'; // Ensure you have this file with the color definitions

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> users = List.generate(
    10,
    (index) => {"name": "User Name", "email": "user.email@example.com"},
  );
  List<Map<String, String>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
  }

  void _filterUsers(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredUsers = users;
      });
    } else {
      setState(() {
        filteredUsers = users
            .where((user) =>
                user["name"]!.toLowerCase().contains(query.toLowerCase()) ||
                user["email"]!.toLowerCase().contains(query.toLowerCase()))
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
          title: Text('List Users',
              style: TextStyle(
                color: AppColors.deepsea,
                fontWeight: FontWeight.w400,
              )),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    labelText: 'Find user',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
                onChanged: _filterUsers,
              ),
              SizedBox(height: 16),
              Expanded(
                  child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: Icon(Icons.close,
                                        color: AppColors.deepsea),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage: AssetImage(
                                                'assets/images/userimage.jpg'), // Replace with your image asset
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    filteredUsers[index]
                                                        ['name']!,
                                                    style: TextStyle(
                                                      color: AppColors.deepsea,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                SizedBox(height: 5),
                                                Text(
                                                    filteredUsers[index]
                                                        ['email']!,
                                                    style: TextStyle(
                                                      color: AppColors.deepsea,
                                                      fontSize: 14,
                                                    ))
                                              ])
                                        ]))
                              ])),
                          Divider(),
                        ]);
                      }))
            ])));
  }
}
