import 'package:flutter/material.dart';

import '../../values/values.dart';

class ShowDoctorAppointments extends StatefulWidget {
  const ShowDoctorAppointments({Key? key}) : super(key: key);

  @override
  State<ShowDoctorAppointments> createState() => _ShowDoctorAppointmentsState();
}

class _ShowDoctorAppointmentsState extends State<ShowDoctorAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          title: const Text('Doctor Appointments',
              style: TextStyle(
                color: AppColors.deepsea,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          const Center(
              child: Text('Hi Dr. Maribel Fletcher',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.OrangePeel,
                  ))),
          const SizedBox(
            height: 40,
          ),
          const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Choose Date',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepsea,
                      )))),
          Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 30.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                        decoration: InputDecoration(
                            hintText: 'Jan 21, 2023',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {},
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppColors.deepsea),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppColors.OrangePeel),
                            ))),
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Doctor Have Session At',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.deepsea,
                            ))),
                    Center(
                        child: LayoutBuilder(builder: (context, constraints) {
                      // Determine if the available width can fit 4 buttons in a row
                      bool isWideScreen = constraints.maxWidth > 600;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isWideScreen
                            ? buildWideScreenLayout()
                            : buildNarrowScreenLayout(),
                      );
                    })),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                        height: 5,
                        decoration: const BoxDecoration(
                            color: AppColors.deepsea,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            )))
                  ]))
        ])));
  }
}

Widget buildWideScreenLayout() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      buildTimeRow(['09:00 am', '10:00 am', '11:00 am', '12:00 pm'],
          [false, true, false, false]),
      SizedBox(height: 16),
      buildTimeRow(['01:00 pm', '02:00 pm', '03:00 pm', '04:00 pm'],
          [false, false, false, true]),
      SizedBox(height: 16),
      buildTimeRow(['05:00 pm', '06:00 pm', '07:00 pm', '08:00 pm'],
          [false, true, false, false]),
    ],
  );
}

Widget buildNarrowScreenLayout() {
  return const Wrap(
    spacing: 16,
    runSpacing: 16,
    alignment: WrapAlignment.center,
    children: <Widget>[
      TimeButton(time: '09:00 am'),
      TimeButton(time: '10:00 am', isSelected: true),
      TimeButton(time: '11:00 am'),
      TimeButton(time: '12:00 pm'),
      TimeButton(time: '01:00 pm'),
      TimeButton(time: '02:00 pm'),
      TimeButton(time: '03:00 pm'),
      TimeButton(time: '04:00 pm', isSelected: true),
      TimeButton(time: '05:00 pm'),
      TimeButton(time: '06:00 pm', isSelected: true),
      TimeButton(time: '07:00 pm'),
      TimeButton(time: '08:00 pm'),
    ],
  );
}

Widget buildTimeRow(List<String> times, List<bool> selections) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          times.length,
          (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TimeButton(
                time: times[index],
                isSelected: selections[index],
              ))));
}

class TimeButton extends StatelessWidget {
  final String time;
  final bool isSelected;

  const TimeButton({Key? key, required this.time, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.deepsea : AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.deepsea : AppColors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(time,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.black,
              fontSize: 14,
            )));
  }
}
