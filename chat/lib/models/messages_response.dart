class MessagesListResponse {
  MessagesListResponse({
    this.ok,
    this.messages,
  });

  final bool? ok;
  final List<Message>? messages;

  MessagesListResponse copyWith({
    bool? ok,
    List<Message>? messages,
  }) =>
      MessagesListResponse(
        ok: ok ?? this.ok,
        messages: messages ?? this.messages,
      );

  factory MessagesListResponse.fromJson(Map<String, dynamic> json) =>
      MessagesListResponse(
        ok: json["ok"],
        messages:
            List<Message>.from(json["last_30"].map((x) => Message.fromJson(x))),
      );
}

class Message {
  Message({
    this.from,
    this.to,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  final String? from;
  final String? to;
  final String? message;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Message copyWith({
    String? from,
    String? to,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Message(
        from: from ?? this.from,
        to: to ?? this.to,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
