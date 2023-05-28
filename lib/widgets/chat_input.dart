import 'package:chat_app/models/chat_msg_entity.dart';
import 'package:chat_app/widgets/counter.dart';
import 'package:chat_app/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final Function(ChatMsgEntity) onSubmit;
  ChatInput({super.key, required this.onSubmit});
  final chat_msg_controller = TextEditingController();

  void send_btn_press() {
    final new_msg = ChatMsgEntity(
      text: chat_msg_controller.text,
      id: "123",
      timeStamp: DateTime.now().microsecondsSinceEpoch,
      author: Author(userName: "gaurav"),
    );
    onSubmit(new_msg);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ImagePicker();
                  });
            },
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),
          Expanded(
            child: TextField(
              controller: chat_msg_controller,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: 'Type Your Message',
                hintStyle: TextStyle(color: Colors.lightBlueAccent),
                border: InputBorder.none,
              ),
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          IconButton(
            onPressed: send_btn_press,
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
