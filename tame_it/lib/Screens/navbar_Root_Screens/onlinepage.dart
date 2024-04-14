import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';
import '../../Models/Doctor_model.dart';
import '../../widgets/custom_card.dart';

class OnlineTherapists extends StatefulWidget {
  const OnlineTherapists({super.key});

  @override
  State<OnlineTherapists> createState() => __OnlineTherapistsStateState();
}

class __OnlineTherapistsStateState extends State<OnlineTherapists> {
  final TextEditingController _searchController = TextEditingController();
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        body: DefaultTabController(
            length: 2,
            child: GestureDetector(
                child: Stack(children: <Widget>[
              ListView(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: widthOfScreen * 0.1,
                    right: widthOfScreen * 0.3,
                  ),
                ),
                Container(
                  height: heightOfScreen,
                  child: _buildMyTherapy(),
                )
              ])
            ]))));
  }

  Widget _buildMyTherapy() {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          shape: const Border(
              bottom: BorderSide(
            color: AppColors.whiteShade4,
            width: 1,
          )),
          title: const Text('Online Therapists',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('    You can start in minutes',
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: width / 20,
                  )),
              SizedBox(height: 2),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Expanded(
                        child: TextField(
                            controller: _searchController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Therapist Name or interest',
                                hintStyle: TextStyle(
                                    color: AppColors.greyShade7,
                                    fontSize: width / 25),
                                prefixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      color: AppColors.greyShade7,
                                    ),
                                    onPressed: () {
                                      // Perform the search here
                                    }),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () => _searchController.clear(),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))))
                  ])),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(children: [
                        Container(
                            width: width * 0.45,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                        const BorderSide(
                                            color: AppColors.deepsea,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    shape: const MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ))),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.tune,
                                        color: AppColors.deepsea,
                                        size: 20,
                                      ),
                                      Text(' Filter by',
                                          style: TextStyle(
                                            color: AppColors.deepsea,
                                          ))
                                    ]),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/FiltersScreen');
                                }))
                      ])),
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(children: [
                        Container(
                            width: width * 0.45,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                        const BorderSide(
                                            color: AppColors.deepsea,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    shape: const MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ))),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.swap_vert,
                                        color: AppColors.deepsea,
                                        size: 20,
                                      ),
                                      Text(' Sort by',
                                          style: TextStyle(
                                            color: AppColors.deepsea,
                                          ))
                                    ]),
                                onPressed: _showMultiSelect))
                      ]))
                ],
              ),
              SizedBox(
                height: 12,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DoctorCard(
                      doctor: Doctor(
                        firstName: 'Smith',
                        specialty: 'Psychologist',
                        rating: 5,
                        lastName: ' Wilson',
                        price: '800',
                        experienceYears: '24 yr',
                        interest: 'Depression, Stress, Anxiety',
                        image: 'assets/images/123.jpg',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

//Sorted by page
  String _selectedItem = ''; // Declaration and initialization of _selectedItem

  void _showMultiSelect() {
    final List<String> items = [
      'Price: low to high',
      'Price: high to low',
      'Customer rating',
      'Most popular'
    ];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Sorting By",
                  style: TextStyle(
                    color: AppColors.deepsea,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Domine',
                  )),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                for (String item in items)
                  RadioListTile<String>(
                      title: Text(item,
                          style: TextStyle(color: AppColors.deepsea)),
                      value: item,
                      groupValue: _selectedItem,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value!;
                        });
                        Navigator.pop(context);
                      },
                      activeColor: AppColors.OrangePeel)
              ]),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.OrangePeel),
                    child: Text('Cancel'))
              ]);
        });
  }
}
