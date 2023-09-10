class Todo {
  String? id;
  String? text;
  bool isDone;

  Todo({
    required this.id,
    required this.text,
    this.isDone = false,
  });
  static List<Todo> todolist() {
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isDone': isDone,
    };
  }

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        isDone = json['isDone'];
}
