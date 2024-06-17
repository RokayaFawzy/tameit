import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:tame_it/values/values.dart';

// User class definition
class User {
  final int id;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  final String gender;
  final String city;
  final String country;
  final String birthDate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.city,
    required this.country,
    required this.birthDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    int id = json['id']?.toInt() ?? 0;
    return User(
      id: id,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      birthDate: json['birthDate'] ?? '',
    );
  }
}

// ListUsers widget
class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  final TextEditingController _searchController = TextEditingController();
  List<User> users = [];
  List<User> filteredUsers = [];
  late String token;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    Uri apiUrl =
        Uri.parse('https://tameit.azurewebsites.net/api/admin/getAllPatients');
    try {
      final response = await http.get(
        apiUrl,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        List<dynamic> fetchedUsers = json.decode(response.body);
        setState(() {
          users = fetchedUsers.map((user) => User.fromJson(user)).toList();
          filteredUsers = users;
          isLoading = false;
        });
      } else {
        _showErrorDialog(
            'Failed to fetch users. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('Error fetching users: $e');
    }
  }

  Future<void> searchUsers(String query) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://tameit.azurewebsites.net/api/auth/byName'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "firstName": query,
          "lastName": query,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          filteredUsers =
              responseData.map((json) => User.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage =
              'Failed to search users. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error searching users: $e';
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                user.firstName.toLowerCase().contains(query.toLowerCase()) ||
                user.lastName.toLowerCase().contains(query.toLowerCase()) ||
                user.email.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('List Users', style: TextStyle(color: AppColors.deepsea)),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.deepsea),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Find user',
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchUsers(_searchController.text);
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterUsers('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: (query) {
                _filterUsers(query);
                if (query.isNotEmpty) {
                  searchUsers(query);
                }
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage != null
                      ? Center(child: Text(errorMessage!))
                      : ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            ImageProvider<Object>? avatarImage;
                            if (filteredUsers[index].imageUrl.isNotEmpty) {
                              avatarImage =
                                  NetworkImage(filteredUsers[index].imageUrl);
                            } else {
                              avatarImage =
                                  AssetImage('assets/images/userimage.jpg');
                            }

                            return Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: avatarImage,
                                  ),
                                  title: Text(
                                    '${filteredUsers[index].firstName} ${filteredUsers[index].lastName}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.deepsea),
                                  ),
                                  subtitle: Text(
                                    filteredUsers[index].email,
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
