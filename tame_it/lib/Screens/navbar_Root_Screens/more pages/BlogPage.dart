import 'package:flutter/material.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/more%20pages/Blogs/mostread.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/list_row.dart';

import 'Blogs/articals.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: Text(
          'Blog Page',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
        backgroundColor: AppColors.whiteShade3,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Welcome to Our Blog',
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/Blogwelcome.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Our Categories',
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  child: const ListRow(),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Our Articles',
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  child: const Articles(),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Most Read ',
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  child: const MostRead(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
