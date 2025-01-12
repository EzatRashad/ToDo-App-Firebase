class TaskModel {
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  TaskModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone=false,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          description: json["description"],
          dateTime: DateTime.fromMillisecondsSinceEpoch(json["dateTime"]),
          isDone: json["isDone"],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dateTime": dateTime?.millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }
}
