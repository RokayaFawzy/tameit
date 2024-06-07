import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';
import 'package:intl/intl.dart'; // For formatting date and time
import 'chat.dart'; // Import the Chat screen

class RoomChat extends StatefulWidget {
  const RoomChat({Key? key}) : super(key: key);

  @override
  State<RoomChat> createState() => _RoomChatState();
}

class _RoomChatState extends State<RoomChat> {
  List<Map<String, dynamic>> chatRooms = List.generate(
    10,
    (index) {
      final now = DateTime.now();
      final lastMessageTime =
          now.subtract(Duration(minutes: index * 5)); // Example timestamp
      return {
        "name": "Patient Name $index",
        "message": "Last message from patient $index",
        "unreadCount": index % 2 == 0 ? index : 0, // Example unread count
        "isRead": index % 2 != 0, // Example read status
        "lastMessageTime": lastMessageTime,
      };
    },
  );

  String formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    if (now.difference(timestamp).inMinutes < 1) {
      return 'just now';
    }
    return DateFormat('hh:mm a').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        backgroundColor: AppColors.whiteShade3,
        title: Text(
          'Chat Patients',
          style: TextStyle(
            color: AppColors.deepsea,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Message',
                  style: TextStyle(
                    color: AppColors.OrangePeel,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the Chat screen when a chat room is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chat(
                          patientName: chatRoom['name'],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                  'assets/images/userimage.jpg'), // Replace with your image asset
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chatRoom['name'],
                                    style: TextStyle(
                                      color: AppColors.deepsea,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    chatRoom['message'],
                                    style: TextStyle(
                                      color: AppColors.deepsea,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  formatTimestamp(chatRoom['lastMessageTime']),
                                  style: TextStyle(
                                    color: AppColors.deepsea,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 5),
                                if (chatRoom['unreadCount'] > 0)
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      chatRoom['unreadCount'].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                else
                                  Icon(
                                    Icons.check,
                                    color: AppColors.deepsea,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(), // Add a Divider widget here
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
