import 'dart:convert';
import 'package:chat_app/models/chat_msg_entity.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMsgEntity> _messages = [];
  _loadMsgs() async {
    rootBundle.loadString('assets/mock_msg.json').then((response) {
      final List<dynamic> decodedList = jsonDecode(response) as List;
      final List<ChatMsgEntity> _chatmsg = decodedList.map((Listitem) {
        return ChatMsgEntity.fromJson(Listitem);
      }).toList();

      setState(() {
        _messages = _chatmsg;
      });
    });
  }

  onMsgSent(ChatMsgEntity entity) {
    _messages.add(entity);
    setState(() {});
  }

  @override
  void initState() {
    _loadMsgs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final username = context.watch<AuthService>().getUsername();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Hi $username!",
          style: const TextStyle(
            color: Colors.lightBlueAccent,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthService>().updateUserName("New Name");
            },
            icon: const Icon(Icons.update),
          ),
          IconButton(
            onPressed: () {
              context.read<AuthService>().logoutUser();
              Navigator.pushReplacementNamed(context, '/');
              if (kDebugMode) {
                print("Logut Pressed");
              }
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  align: _messages[index].author.userName ==
                          context.read<AuthService>().getUsername()
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  entity: _messages[index],
                );
              },
            ),
          ),
          ChatInput(onSubmit: onMsgSent)
        ],
      ),
    );
  }
}
