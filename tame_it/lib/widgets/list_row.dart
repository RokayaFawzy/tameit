import 'package:flutter/material.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/more%20pages/Blogs/OurCatigory/SleepDisorderBlog.dart';
import 'package:tame_it/values/values.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/MemoryBlog.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/NeuroticBlog.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/OCDBlog.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/ADHD.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/Anxiety.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/DepressionBlog.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/PTSDblog.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/PanicDisorderBlog.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/PersonalityBlog.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/StressRelatedBlob.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/eatdisorder.dart';
import '../Screens/navbar_Root_Screens/more pages/Blogs/OurCatigory/schizophreniablog.dart';

class ListRow extends StatelessWidget {
  const ListRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 15),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -0.38),
                  child: IconButton(
                    icon: Image.asset("assets/images/o1.jpg"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ADHDBlog()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 13),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -1.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o2.jpg"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GADBlog()),
                      );
                    },
                    iconSize: 80, // Adjust the size of the icon/image as needed
                  ),
                ),
                const Positioned(
                  top:
                      80, // Adjust the top position to place the text below the image
                  left:
                      20, // Adjust the left position to align the text as needed
                  child: Text(
                    'Anxiety',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 13),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -2.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o3.jpg"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PTSDArticle()),
                      );
                    },
                    iconSize: 80, // Adjust the size of the icon/image as needed
                  ),
                ),
                const Positioned(
                  top:
                      80, // Adjust the top position to place the text below the image
                  left:
                      25, // Adjust the left position to align the text as needed

                  child: Text(
                    'PTSD',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 13),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -1.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o4.jpg"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepressionArticle()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
                const Positioned(
                  top:
                      80, // Adjust the top position to place the text below the image
                  left: 11,
                  child: Text(
                    'Depression',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -2.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o5.jpg"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OCDBlog()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
                const Positioned(
                  top:
                      76, // Adjust the top position to place the text below the image
                  left: 30,
                  child: Text(
                    'OCD',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -2.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o6.jpg"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EatingDisordersBlog()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
                const Positioned(
                  top: 78,
                  left: 0,
                  child: Text(
                    'Eating Disorders',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -2.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o7.jpg"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BorderlinePersonalityDisorderBlog()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
                const Positioned(
                  top:
                      65, // Adjust the top position to place the text below the image
                  left: 10,
                  child: Column(
                    children: [
                      Text(
                        'Personality',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Disorders',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  // child: Text(
                  //   'Personality Disorders',
                  //   style: TextStyle(
                  //     fontSize: 10,
                  //     color: AppColors.OrangePeel,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -2.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o8.jpg"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SchizophreniaBlog()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
                const Positioned(
                  top:
                      76, // Adjust the top position to place the text below the image
                  left: 4,
                  child: Text(
                    'Schizophrenia',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -2.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o9.jpg"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SleepDisorders()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
                const Positioned(
                  top: 76,
                  left: 0,
                  child: Text(
                    'Sleep Disorders',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.deepsea,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -2.4),
                  child: IconButton(
                    icon: Image.asset("assets/images/o10.jpg"),
                    onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PanicDisorder()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
                const Positioned(
                  top:
                      69, // Adjust the top position to place the text below the image
                  left: 20,
                  child: Column(
                    children: [
                      Text(
                        'Panic',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Disorders',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -2.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o11.jpg"),
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StressRelatedDisorders()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
                const Positioned(
                  top:
                      66, // Adjust the top position to place the text below the image
                  left: 5,
                  child: Column(
                    children: [
                      Text(
                        'Stress-related',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Disorders',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -2.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o12.jpg"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MemoryDisorders()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
                const Positioned(
                  top:
                      66, // Adjust the top position to place the text below the image
                  left: 18,
                  child: Column(
                    children: [
                      Text(
                        'Memory',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Disorders',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Container(
            color: AppColors.white,
            width: 88,
            height: 88,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.03, -2.7),
                  child: IconButton(
                    icon: Image.asset("assets/images/o13.jpg"),
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NeurologicalFunctionalDisorder()),
                      );
                    },
                    iconSize: 1,
                  ),
                ),
                const Positioned(
                  top:
                      67, // Adjust the top position to place the text below the image
                  left: 17,
                  child: Column(
                    children: [
                      Text(
                        'Neurotic',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Disorders',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.deepsea,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 13,
          ),
        ],
      ),
    );
  }
}
