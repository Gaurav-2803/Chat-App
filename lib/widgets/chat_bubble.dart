import 'package:flutter/material.dart';

import '../models/chat_msg_entity.dart';

class ChatBubble extends StatelessWidget {
  final ChatMsgEntity entity;
  final Alignment align;
  final Color boxColor;
  const ChatBubble(
      {super.key,
      required this.align,
      required this.entity,
      required this.boxColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.45),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: boxColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              entity.text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            if (entity.imageUrl != null)
              Image.network(
                '${entity.imageUrl}',
                height: 80,
                width: 80,
              ),
          ],
        ),
      ),
    );
  }
}
