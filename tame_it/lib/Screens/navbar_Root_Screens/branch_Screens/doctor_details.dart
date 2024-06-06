import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  List<String> clinicNames = ['Naser city clinic'];
  List<String> clinicLocation = ['Naser city clinic'];
  List<String> clinicNumber = ['Naser city clinic'];

  void _addClinicName() {
    setState(() {
      clinicNames.add('New clinic name');
      clinicLocation.add('New clinic Location');
      clinicNumber.add('New clinicNumber');
    });
  }

  // Define a method to build Clinic Details section
  Widget _buildClinicDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildClinicNamesSection(),
        _buildClinicLocationSection(),
        _buildClinicNumberSection(),
      ],
    );
  }

  // Define a method to build Clinic Names section
  Widget _buildClinicNamesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Clinic Names',
          style: TextStyle(
            color: AppColors.deepsea,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 15),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: clinicNames
              .map((name) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      color: AppColors.greyShade5,
                    ),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: AppColors.deepsea,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  // Define a method to build Clinic Location section
  Widget _buildClinicLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Clinic Location',
          style: TextStyle(
            color: AppColors.deepsea,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 15),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: clinicLocation
              .map((name) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      color: AppColors.greyShade5,
                    ),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: AppColors.deepsea,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  // Define a method to build Clinic Number section
  Widget _buildClinicNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Clinic Number',
          style: TextStyle(
            color: AppColors.deepsea,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 15),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: clinicNumber
              .map((name) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      color: AppColors.greyShade5,
                    ),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: AppColors.deepsea,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
          title: Text(
            'Therapist Profile',
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
        ),
        body: Stack(children: [
          CustomScrollView(slivers: [
            SliverPersistentHeader(
              delegate: _MySliverAppBar(expandedHeight: 250.0),
              floating: false,
              pinned: true,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.only(top: 16.0, left: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              'Dr. Georgia Griffin',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: AppColors.deepsea,
                              ),
                            ),
                            Expanded(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                  IconButton(
                                      onPressed: () {
                                        // Call the method to show clinic details
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _buildClinicDetailsSection();
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.chat,
                                        color: AppColors.deepsea,
                                      ))
                                ]))
                          ]),
                          Text('Sr. Psychologist'),
                          SizedBox(height: 25),
                          Row(children: [
                            Text('Patients'),
                            SizedBox(width: 45),
                            Text('Experience'),
                            SizedBox(width: 45),
                            Text('Rating'),
                          ]),
                          SizedBox(height: 15),
                          Row(children: [
                            Text('1.4K',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 90),
                            Text('5 yr',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 70),
                            Text('4.0',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                          SizedBox(height: 10),
                          Text('Specialties',
                              style: TextStyle(
                                  color: AppColors.deepsea,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          SizedBox(height: 7),
                          Column(children: [
                            Row(children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    color: AppColors.greyShade5,
                                  ),
                                  child: Text("OCD",
                                      style: TextStyle(
                                        color: AppColors.deepsea,
                                        fontWeight: FontWeight.bold,
                                      ))),
                              SizedBox(width: 10),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    color: AppColors.greyShade5,
                                  ),
                                  child: Text("ADHD",
                                      style: TextStyle(
                                        color: AppColors.deepsea,
                                        fontWeight: FontWeight.bold,
                                      ))),
                              SizedBox(width: 10),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    color: AppColors.greyShade5,
                                  ),
                                  child: Text("PTSD",
                                      style: TextStyle(
                                        color: AppColors.deepsea,
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ]),
                            SizedBox(height: 10),
                            Row(children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    color: AppColors.greyShade5,
                                  ),
                                  child: Text("Anxiety",
                                      style: TextStyle(
                                        color: AppColors.deepsea,
                                        fontWeight: FontWeight.bold,
                                      ))),
                              SizedBox(width: 10),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    color: AppColors.greyShade5,
                                  ),
                                  child: Text("Mood Disorders",
                                      style: TextStyle(
                                        color: AppColors.deepsea,
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ]),
                            SizedBox(height: 10),
                            Row(children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    color: AppColors.greyShade5,
                                  ),
                                  child: Text("Stress Scale",
                                      style: TextStyle(
                                        color: AppColors.deepsea,
                                        fontWeight: FontWeight.bold,
                                      ))),
                              SizedBox(width: 10),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    color: AppColors.greyShade5,
                                  ),
                                  child: Text("Depression",
                                      style: TextStyle(
                                        color: AppColors.deepsea,
                                        fontWeight: FontWeight.bold,
                                      )))
                            ])
                          ]),
                          SizedBox(height: 30),
                          Text(
                            'About',
                            style: TextStyle(
                                color: AppColors.deepsea,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                                'I am a licensed psychotherapist from the Egyptian Ministry of Health and the Qatar Supreme Council of Health. \n\n'
                                'I obtained my Phd in Psychology from Ain Shams University and have attended training courses, including cognitive-behavioural '
                                'therapy (CBT) in depression and anxiety from Beck Institute, personality disorders, and obsessive-compulsive disorder (OCD).'
                                ' I am also licensed and certified to diagnose and treat Autism Spectrum Disorder with ADI-R and ADOS 2016-2018. \n\n'
                                'I am also the head of the Administration of Prep Middle East Academy for Psychological Services.',
                                maxLines: null),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Clinic',
                                style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: AppColors.deepsea),
                                onPressed: _addClinicName,
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          _buildClinicDetailsSection(),
                          SizedBox(height: 200)
                        ]));
              },
              childCount: 1,
            ))
          ]),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  width: double.infinity,
                  color: AppColors.whiteShade3,
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/AppointmentBooking');
                                },
                                child: Text('Book Appointment',
                                    style: TextStyle(color: AppColors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.deepsea,
                                ))
                          ]))))
        ]));
  }
}

class _MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  _MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://th.bing.com/th/id/R.5f72006c3d7e4348fca79cacb13f1f49?rik=SFq5KC3b6u52oA&pid=ImgRaw&r=0',
          fit: BoxFit.cover,
        ),
        Positioned(
            top: expandedHeight - shrinkOffset - kToolbarHeight,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
            ))
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(_MySliverAppBar oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight;
  }
}
