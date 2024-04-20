import 'package:shared_preferences/shared_preferences.dart';

// Store token securely
Future<void> storeToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}
