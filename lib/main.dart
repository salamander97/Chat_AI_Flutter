import 'package:flutter/material.dart';
import 'Accounts/login_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ChatBot());
}

class ChatBot extends StatelessWidget {
  static const String tittle = 'Chat AI';
  const ChatBot({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginUI(), //Use StartPage from startpage.dart
    );
  }
}
