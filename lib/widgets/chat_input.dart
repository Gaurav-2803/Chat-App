import 'package:chat_app/models/chat_msg_entity.dart';
import 'package:chat_app/widgets/counter.dart';
import 'package:chat_app/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final Function(ChatMsgEntity) onSubmit;
  ChatInput({super.key, required this.onSubmit});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final chat_msg_controller = TextEditingController();
  String _selectedImgUrl = '';

  void send_btn_press() {
    final new_msg = ChatMsgEntity(
      text: chat_msg_controller.text,
      id: "123",
      timeStamp: DateTime.now().microsecondsSinceEpoch,
      author: Author(userName: "gaurav"),
    );
    if (_selectedImgUrl.isNotEmpty) {
      new_msg.imageUrl = _selectedImgUrl;
    }
    widget.onSubmit(new_msg);
    chat_msg_controller.clear();
    _selectedImgUrl = '';
    setState(() {});
  }

  void pickedImage(String imageUrl) {
    setState(() {
      _selectedImgUrl = imageUrl;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    return ImagePicker(
                      imageSelected: pickedImage,
                    );
                  });
            },
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
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
                if (_selectedImgUrl.isNotEmpty)
                  Image.network(
                    _selectedImgUrl,
                    height: 60,
                  ),
              ],
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
