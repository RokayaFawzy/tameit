import 'package:flutter/material.dart';

import '../values/values.dart';

class SettingAdmin extends StatelessWidget {
  const SettingAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          title: Text('Setting',
              style: TextStyle(
                color: AppColors.deepsea,
                fontWeight: FontWeight.w400,
              )),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
        ),
        body: SafeArea(
            child: Column(children: [
          SizedBox(height: 20),
          Center(
            child: Container(
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
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
        ])));
  }

}
