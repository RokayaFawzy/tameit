import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 25, top: 25, bottom: 25, right: 25),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: AppColors.deepsea1,
        ),
        child: Text(
          "Hi",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 25, top: 25, bottom: 25, right: 25),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: AppColors.grey,
        ),
        child: Text(
          "welcome",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
