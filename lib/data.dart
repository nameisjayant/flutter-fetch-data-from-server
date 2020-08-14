class Data {
  final int userId;
  final int id;
  final String title;
  final String body;

  Data({this.userId, this.id, this.title, this.body});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}
