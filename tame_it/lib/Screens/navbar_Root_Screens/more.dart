import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../values/values.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'more pages/Profile.dart';

class UserDetails {
  final String userName;
  final String email;
  final String? imageUrl;

  UserDetails({
    required this.userName,
    required this.email,
    this.imageUrl,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }
}

class MorePage extends StatefulWidget {
  MorePage({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://tameit.azurewebsites.net/api/auth/logout'),
        // Optionally, add headers or body parameters here
      );

      if (response.statusCode == 204) {
        // Logout successful, navigate to the login screen
        Navigator.of(context).pushReplacementNamed('/Login');
      } else {
        // Handle other status codes (e.g., 401 for unauthorized)
        print('Logout failed with status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Logout failed with status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during logout: $e'),
        ),
      );
    }
  }

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  late Future<UserDetails> userDetails;

  var size, height, width;

  @override
  void initState() {
    super.initState();
    userDetails = fetchUserDetails();
  }

  Future<UserDetails> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('https://tameit.azurewebsites.net/api/auth/userDetails'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        return UserDetails.fromJson(responseData);
      } else {
        print(
            'Failed to load user details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception(
            'Failed to load user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      throw Exception('Error fetching user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetails>(
      future: userDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.data != null) {
            final imageProvider = snapshot.data!.imageUrl != null
                ? NetworkImage(snapshot.data!.imageUrl!)
                : const AssetImage('assets/images/newlogo.jpg');
            return buildUI(
                snapshot.data!, imageProvider as ImageProvider<Object>);
          } else {
            return Text('User details not available');
          }
        }
      },
    );
  }

  Widget buildUI(UserDetails userDetails, ImageProvider imageProvider) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          shape: const Border(
            bottom: BorderSide(
              color: AppColors.whiteShade4,
              width: 1,
            ),
          ),
          title: const Text(
            'More',
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Profile');
                    },
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.black38,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: imageProvider,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: SafeArea(
            child: Column(children: [
          SizedBox(height: 10),
          Center(
            child: Container(
              width: width / 1.2,
              height: height / 9,
              child: Card(
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.black38,
                        child: CircleAvatar(
                            radius: 25, backgroundImage: imageProvider),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            userDetails.userName,
                            style: TextStyle(
                              color: AppColors.deepsea,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          userDetails.email,
                          style: TextStyle(fontSize: width / 25),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
              decoration: const BoxDecoration(
                // color: Colors.white,
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0.1)),
              ),
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Profile');
                  },
                  leading: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.grey,
                  ),
                  title: const Text('Profile'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ))),
          SizedBox(height: 10),
          Container(
              decoration: const BoxDecoration(
                // color: Colors.white,
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0.1)),
              ),
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/ChangePassword');
                  },
                  leading: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  title: const Text('Change Password'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ))),
          SizedBox(height: 10),
          Container(
              decoration: const BoxDecoration(
                // color: Colors.white,
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0.1)),
              ),
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/BlogPage');
                  },
                  leading: const Icon(
                    Icons.public,
                    color: Colors.grey,
                  ),
                  title: const Text('Blog'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ))),
          SizedBox(height: 10),
          Container(
              decoration: const BoxDecoration(
                // color: Colors.white,
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0.1)),
              ),
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  leading: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.grey,
                  ),
                  title: const Text('My Wallet'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ))),
          SizedBox(height: 10),
          Container(
              decoration: const BoxDecoration(
                // color: Colors.white,
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0.1)),
              ),
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  leading: const Icon(
                    Icons.payment,
                    color: Colors.grey,
                  ),
                  title: const Text('Payment'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ))),
          SizedBox(height: 25),
          GestureDetector(
              onTap: () =>
                  widget._logout(context), // Call widget._logout when tapped
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xFFED3725),
                    fontWeight: FontWeight.w500,
                    fontSize: width / 22,
                  ),
                ),
                SizedBox(width: 3),
                Icon(Icons.logout, color: Color(0xFFED3725))
              ]))
        ])));
  }
}
