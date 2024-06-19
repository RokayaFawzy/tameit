import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.patientName, required this.patientId})
      : super(key: key);

  final String patientName;
  final int patientId;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      // Handle the case where token is null
      return;
    }

    final response = await http.get(
      Uri.parse(
          'https://tameit.azurewebsites.net/api/history/your_sender_id/${widget.patientId}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _messages.clear();
        for (var item in data) {
          _messages.add({
            'sender':
                item['senderId'] == 'your_sender_id' ? 'doctor' : 'patient',
            'message': item['content'],
            'time': item['timestamp'] != null
                ? DateFormat('HH:mm').format(DateTime.parse(item['timestamp']))
                : '',
          });
        }
      });
    } else {
      // Handle the error
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      // Handle the case where token is null
      return;
    }

    final response = await http.post(
      Uri.parse('https://tameit.azurewebsites.net/api/sender'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'senderId': 'your_sender_id',
        'receiverId': widget.patientId,
        'content': _messageController.text,
      }),
    );

    if (response.statusCode == 200) {
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm').format(now);

      setState(() {
        _messages.insert(0, {
          'sender': 'doctor',
          'message': _messageController.text,
          'time': formattedTime,
        });
        _messageController.clear();
      });
    } else {
      // Handle the error
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
