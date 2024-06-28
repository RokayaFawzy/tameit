import 'package:flutter/material.dart';
import 'package:tame_it/Screens/navbar_Root_Screens/chatpot/apiServic.dart';
import 'package:tame_it/values/values.dart';

class ChatPotPage extends StatefulWidget {
  @override
  _ChatPotPageState createState() => _ChatPotPageState();
}

class _ChatPotPageState extends State<ChatPotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  String _userId = 'chatbot_try1';

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() async {
    try {
      await ApiService.login();
    } catch (error) {
      // Handle login error
    }
  }

  void _sendMessage({String? mes}) async {
    final text = mes ?? _controller.text;
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'type': 'sent', 'text': text});
    });

    _controller.clear();

    try {
      final response = await ApiService.sendMessage(_userId, text);
      print(response['responses']);

      List<Map<String, dynamic>> list = [];
      for (var e in response['responses']) {
        if (e['type'] == 'single-choice') {
          list.add({
            'type': e['type'],
            'text': e['text'],
            'choices': e['choices'],
            'dropdownPlaceholder': e['dropdownPlaceholder']
          });
        } else {
          list.add({'type': 'text', 'text': e['text']});
        }
      }
      print(list);

      setState(() {
        _messages.addAll(list);
      });

      print('_messages');
      print(_messages);
    } catch (error) {
      // Handle error
      print('error');
      print(error);
    }
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    if (message['type'] == 'text' || message['type'] == 'sent') {
      return ListTile(
        title: Align(
          alignment: message['type'] == 'sent'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color:
                  message['type'] == 'sent' ? AppColors.deepsea : Colors.grey,
              borderRadius: message['type'] == 'sent'
                  ? BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(0),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(32),
                    ),
            ),
            child: Text(message['text'], style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    } else if (message['type'] == 'single-choice') {
      return ListTile(
        title: Text(message['text']),
        subtitle: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.grey),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(message['dropdownPlaceholder']),
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.grey.shade300,
                ),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.deepsea,
                ),
              ),
              items: (message['choices'] as List)
                  .map<DropdownMenuItem<String>>((choice) {
                return DropdownMenuItem<String>(
                  value: choice['title'],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.grey.shade200,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(choice['title']),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                // Handle the selection
                setState(() {
                  _messages.add({'type': 'sent', 'text': value});
                  _sendMessage(mes: value);
                });
              },
              isExpanded: true,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        '_---------------------------------messages---------------------------------');
    print(_messages);
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        title: const Text(
          'Chat Bot',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        shape: const Border(
          bottom: BorderSide(
            color: AppColors.whiteShade4,
            width: 1,
          ),
        ),
        shadowColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.deepsea),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(message);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        InputDecoration(hintText: 'Enter your message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
