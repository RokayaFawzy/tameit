import 'package:flutter/material.dart';

import '../values/values.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(10),
      child: Container(
          color: AppColors.deepsea,
          child: const Column(
            children: [
              SizedBox(height: 4),
              Text(
                'January',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    height: 1.50,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),
              Text(
                '21',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    height: 1.50,
                    fontFamily: "Domine",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'at ' + '4:30 pm',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    height: 1.50,
                    fontWeight: FontWeight.w600),
              )
            ],
          )),
    );
  }
}
