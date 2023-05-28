import 'package:chat_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:chat_app/chat_page.dart';
import 'package:chat_app/widgets/counter.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat Application",
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primarySwatch: AppColor.primaryColor,
      ),
      home: LoginPage(),
      // home: const msg_send_counter(),
      // home: const ChatPage(),
      routes: {
        '/chat': (context) => ChatPage(),
      },
    );
  }
}
