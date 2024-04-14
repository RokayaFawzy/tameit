import 'package:flutter/material.dart';
import '../../values/values.dart';
import 'package:http/http.dart' as http;

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

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
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          shape: const Border(
              bottom: BorderSide(
            color: AppColors.whiteShade4,
            width: 1,
          )),
          title: const Text('More',
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Profile');
                      },
                      child: const CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.black38,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundImage:
                                AssetImage('assets/images/123.jpg'),
                          ))))
            ])
          ]),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Center(
                child: Container(
                    width: width / 1.2,
                    height: height / 9,
                    child: Card(
                        color: Colors.white,
                        child: Row(children: [
                          Row(children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                //TODO: Circle Border
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.black38,
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          AssetImage('assets/images/123.jpg')),
                                )),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text('eman',
                                        style: TextStyle(
                                            color: AppColors.deepsea,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Text('era@gmail.com',
                                      style: TextStyle(fontSize: width / 25))
                                ])
                          ])
                        ])))),
            SizedBox(height: 15),
            Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.1)),
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
            Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.1)),
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
            Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.1)),
                ),
                child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/');
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
            Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.1)),
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
            Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.1)),
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
            GestureDetector(
              onTap: () =>
                  widget._logout(context), // Call widget._logout when tapped
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xFFED3725),
                      fontWeight: FontWeight.w500,
                      fontSize: width / 22,
                    ),
                  ),
                  Icon(
                    Icons.logout,
                    color: Color(0xFFED3725),
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
