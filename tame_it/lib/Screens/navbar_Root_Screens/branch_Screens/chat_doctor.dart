import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/chat_buble.dart';

class ChatDoctorPage extends StatelessWidget {
  const ChatDoctorPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Doctor Chat',
            // textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.deepsea,
              fontSize: 16,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w700,
              height: 1.70,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.deepsea)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemBuilder: ((context, index) {
                return
                    // ChatBuble();
                    ChatBubleForFriend();
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: Icon(
                  Icons.send,
                  color: AppColors.deepsea1,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.deepsea1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
