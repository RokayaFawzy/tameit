import 'dart:convert';
import 'package:http/http.dart' as http;

class Response {
  String type;
  dynamic workflow;
  String text;
  List<String> variations;
  bool markdown;
  bool typing;

  Response({
    required this.type,
    required this.workflow,
    required this.text,
    required this.variations,
    required this.markdown,
    required this.typing,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      type: json['type'],
      workflow: json['workflow'],
      text: json['text'],
      variations: List<String>.from(json['variations']),
      markdown: json['markdown'],
      typing: json['typing'],
    );
  }
}

class SingleChoiceResponse extends Response {
  String skill;
  String dropdownPlaceholder;
  List<Choice> choices;
  bool disableFreeText;

  SingleChoiceResponse({
    required String type,
    required dynamic workflow,
    required String text,
    required List<String> variations,
    required bool markdown,
    required bool typing,
    required this.skill,
    required this.dropdownPlaceholder,
    required this.choices,
    required this.disableFreeText,
  }) : super(
          type: type,
          workflow: workflow,
          text: text,
          variations: variations,
          markdown: markdown,
          typing: typing,
        );

  factory SingleChoiceResponse.fromJson(Map<String, dynamic> json) {
    return SingleChoiceResponse(
      type: json['type'],
      workflow: json['workflow'],
      text: json['text'],
      variations: List<String>.from(json['variations']),
      markdown: json['markdown'],
      typing: json['typing'],
      skill: json['skill'],
      dropdownPlaceholder: json['dropdownPlaceholder'],
      choices: List<Choice>.from(
        json['choices'].map((x) => Choice.fromJson(x)),
      ),
      disableFreeText: json['disableFreeText'],
    );
  }
}

class Choice {
  String title;
  String value;

  Choice({
    required this.title,
    required this.value,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      title: json['title'],
      value: json['value'],
    );
  }
}

class ApiService {
  static const String baseUrl = 'http://172.210.57.245/api/v1';
  static const String email = "sm711015@gmail.com";
  static const String password = "Pp01154744";
  static String? jwtToken;

  static Future<void> login() async {
    final url = Uri.parse('$baseUrl/auth/login/basic/default');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      jwtToken = data['payload']['jwt'];
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<Map<String, dynamic>> sendMessage(
      String userId, String text) async {
    final url = Uri.parse('$baseUrl/bots/chatbot_try1/converse/userId/secured');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: json.encode({
        'type': 'text',
        'text': text,
      }),
    );


    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send message');
    }
  }
}
