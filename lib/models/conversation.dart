import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:konnect/models/message.dart';

class ConversationSnippet {
  final String id;
  final String conversationID;
  final String lastMessage;
  final String name;
  final String image;
  final MessageType type;
  final int unseenCount;
  final Timestamp timestamp;

  ConversationSnippet(
      {this.conversationID,
      this.id,
      this.lastMessage,
      this.unseenCount,
      this.timestamp,
      this.name,
      this.type,
      this.image});
  factory ConversationSnippet.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data();
    var _messageType = MessageType.Text;
    if (_data["type"] != null && _data["type"] == "image") {
      _messageType = MessageType.Image;
    }
    return ConversationSnippet(
      id: _snapshot.id,
      conversationID: _data["conversationID"],
      lastMessage: _data["lastMessage"] != null ? _data["lastMessage"] : "",
      unseenCount: _data["unseenCount"],
      timestamp: _data["timestamp"],
      name: _data["name"],
      image: _data["image"],
      type: _messageType,
    );
  }
}

class Conversation {
  final String id;
  final List members;
  final List<Message> messages;
  final String ownerID;

  Conversation({this.id, this.members, this.messages, this.ownerID});

  factory Conversation.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data();
    List _messages = _data["messages"];
    if (_messages != null) {
      _messages = _messages.map((_m) {
        var _messageType =
            _m["type"] == "text" ? MessageType.Text : MessageType.Image;
        return Message(
            senderID: _m["senderID"],
            content: _m["message"],
            type: _messageType,
            timestamp: _m["timestamp"]);
      }).toList();
    } else {
      _messages = null;
    }

    return Conversation(
        id: _snapshot.id,
        members: _data["members"],
        ownerID: _data["ownerID"],
        messages: _messages);
  }
}
