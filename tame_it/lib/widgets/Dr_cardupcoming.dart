import 'package:flutter/material.dart';
import '../values/values.dart';

class DrCardUpcoming extends StatelessWidget {
  const DrCardUpcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.only(left: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/123.jpg'),
            ),
          ),
          const SizedBox(width: 8), // Adjust spacing
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. Georgia Griffin",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.deepsea,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "ADHD",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.deepsea,
                  ),
                ),
                SizedBox(height: 14), // Adjust spacing
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.deepsea,
                ),
              ),
              const SizedBox(height: 20), // Adjust spacing
            ],
          ),
        ],
      ),
    );
  }
}
