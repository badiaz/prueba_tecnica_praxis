class TaskEntity {
  final int? id;
  final String title;
  final bool completed;

  TaskEntity({this.id, required this.title, required this.completed});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["title"] = title;
    json["completed"] = completed ? 1 : 0;
    return json;
  }

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
        id: json['id'],
        title: json['title'],
        completed: json['completed'] == 1);
  }
}
