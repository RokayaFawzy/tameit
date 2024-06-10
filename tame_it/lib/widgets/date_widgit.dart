import 'package:flutter/material.dart';
import '../values/values.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double containerSize = MediaQuery.of(context).size.width * 0.3;

    return Container(
      width: containerSize,
      height: containerSize,
      padding: const EdgeInsets.all(5),
      child: Container(
        color: AppColors.deepsea,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 3),
            const Flexible(
              child: Text(
                'January',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  height: 1.50,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 2),
            const Flexible(
              child: Text(
                '21',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  height: 1.50,
                  fontFamily: "Domine",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 9),
            Flexible(
              child: Text(
                'at ' + '4:30 pm',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  height: 1.50,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
