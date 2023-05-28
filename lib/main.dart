import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'package:chat_app/chat_page.dart';
import 'package:chat_app/widgets/counter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => AuthService(),
      child: const ChatApp(),
    ),
  );
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
      home: FutureBuilder<bool>(
        future: context.read<AuthService>().isLoggedIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!) {
              return ChatPage();
            }
          } else {
            return LoginPage();
          }
          return CircularProgressIndicator();
        },
      ),
      // home: const msg_send_counter(),
      // home: const ChatPage(),
      routes: {
        '/chat': (context) => ChatPage(),
      },
    );
  }
}
