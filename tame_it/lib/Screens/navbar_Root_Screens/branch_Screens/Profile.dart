import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../values/values.dart';
import '../../../widgets/custom_painters.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 27, 138, 125),
            title: const Center(
                child: Text('My Profile',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )))),
        body: Stack(children: <Widget>[
          drawCircles(),
          ListView(children: <Widget>[
            SizedBox(
              height: (heightOfScreen * 0.14),
            ),
            SizedBox(
              height: 400,
              child: _buildProfile(),
            )
          ])
        ]));
  }

  Widget drawCircles() {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Column(children: <Widget>[
      CustomPaint(
          painter: DrawCircle(
        offset: Offset(widthOfScreen * 0.5, heightOfScreen * -0.19),
        radius: widthOfScreen * 0.7,
        color: const Color.fromARGB(255, 27, 138, 125),
        hasShadow: true,
      ))
    ]);
  }

  Widget _buildProfile() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
        child: ListView(children: [
          Column(children: <Widget>[
            const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.black38,
                child: CircleAvatar(
                  radius: 39,
                  backgroundImage: AssetImage(''),
                )),
            const SizedBox(
              height: 12,
            ),
            const Text('Sylvia Huber',
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            const Text('Sylviahuber@mail.com',
                style: TextStyle(
                  color: AppColors.deepsea,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                )),
            const SizedBox(height: 40),
            Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.greyShade2, width: 0.1)),
                ),
                child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/EditInformation');
                    },
                    leading: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.grey,
                    ),
                    title: const Text('Personal info'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ))),
            Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.greyShade2, width: 0.1)),
                ),
                child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/');
                    },
                    leading: const Icon(
                      Icons.medical_services_outlined,
                      color: Colors.grey,
                    ),
                    title: const Text('My appointment'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ))),
            Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.greyShade2, width: 0.1)),
                ),
                child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/');
                    },
                    leading: const Icon(
                      Icons.personal_injury_outlined,
                      color: Colors.grey,
                    ),
                    title: const Text('My doctors'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ))),
          ])
        ]));
  }
}
