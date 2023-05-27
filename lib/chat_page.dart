import 'dart:convert';

import 'package:chat_app/models/chat_msg_entity.dart';
import 'package:chat_app/models/images_models.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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

  Future<List<PixelImages>> _getNetworkImages() async {
    var endPointURL = Uri.parse('https://pixelford.com/api2/images');
    final response = await http.get(endPointURL);
    if (response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body) as List;

      final List<PixelImages> _pixelImgList = decodedList.map((Listitem) {
        return PixelImages.fromJson(Listitem);
      }).toList();
      return _pixelImgList;
    } else {
      throw Exception('API not successful');
    }
  }

  @override
  void initState() {
    _loadMsgs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getNetworkImages();
    final username = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
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
          FutureBuilder<List<PixelImages>>(
            future: _getNetworkImages(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PixelImages>> snapshot) {
              if (snapshot.hasData) {
                return Image.network(snapshot.data![0].smallSize);
              }
              return CircularProgressIndicator();
            },
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                      align: _messages[index].author.userName == 'gaurav'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      entity: _messages[index],
                      boxColor: _messages[index].author.userName == 'gaurav'
                          ? Colors.blueGrey
                          : Colors.red.shade300);
                }),
          ),
          ChatInput(onSubmit: onMsgSent)
        ],
      ),
    );
  }
}
