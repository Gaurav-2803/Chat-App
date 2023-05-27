class ChatMsgEntity {
  String text;
  String id;
  String? imageUrl;
  int timeStamp;
  Author author;

  ChatMsgEntity({
    required this.text,
    required this.id,
    this.imageUrl,
    required this.timeStamp,
    required this.author,
  });
  factory ChatMsgEntity.fromJson(Map<String, dynamic> json) {
    return ChatMsgEntity(
        text: json['text'],
        id: json['id'],
        timeStamp: json['createdAt'],
        author: Author.fromJson(json['author']),
        imageUrl: json['image']);
  }
}

class Author {
  String userName;
  Author({
    required this.userName,
  });
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(userName: json['username']);
  }
}
