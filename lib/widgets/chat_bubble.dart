import 'package:chat_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat_msg_entity.dart';
import '../services/auth_service.dart';

class ChatBubble extends StatelessWidget {
  final ChatMsgEntity entity;
  final Alignment align;
  const ChatBubble({
    super.key,
    required this.align,
    required this.entity,
  });
  @override
  Widget build(BuildContext context) {
    bool isAuthor =
        entity.author.userName == context.read<AuthService>().getUsername();
    return Align(
      alignment: align,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isAuthor ? AppColor.msgSendColor : AppColor.msgRecieveColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
            bottomLeft:
                isAuthor ? const Radius.circular(10) : const Radius.circular(0),
            bottomRight:
                isAuthor ? const Radius.circular(0) : const Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              entity.text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            if (entity.imageUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(entity.imageUrl!),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
