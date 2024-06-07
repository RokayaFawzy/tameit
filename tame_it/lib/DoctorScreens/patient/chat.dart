import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.patientName}) : super(key: key);

  final String patientName;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        final now = DateTime.now();
        final formattedTime = DateFormat('HH:mm').format(now);

        _messages.add({
          'sender': 'doctor', // Assuming doctor is sending the message
          'message': _messageController.text,
          'time': formattedTime,
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        backgroundColor: AppColors.whiteShade3,
        title: Text(
          'Chat with ${widget.patientName}',
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
          Expanded(
            child: ListView.builder(
              reverse: true, // Reverse the list to start from bottom
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isDoctor = message['sender'] == 'doctor';
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Align(
                    alignment:
                        isDoctor ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDoctor ? AppColors.deepsea : Color(0xFFF6F8FB),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                          bottomLeft: Radius.circular(isDoctor ? 32 : 0),
                          bottomRight: Radius.circular(isDoctor ? 0 : 32),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['message'],
                            style: TextStyle(
                              color:
                                  isDoctor ? Colors.white : AppColors.deepsea,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            message['time'],
                            style: TextStyle(
                              color: isDoctor ? Colors.white70 : AppColors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
