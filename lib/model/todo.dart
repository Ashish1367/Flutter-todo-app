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
    return [
      Todo(id: '123', text: 'LeetCode Ki Kutai'),
      Todo(id: '124', text: 'LeetCode Se Kutai', isDone: true),
      Todo(id: '125', text: 'Sleep'),
      Todo(id: '126', text: 'Play Valo !!!!'),
      Todo(id: '127', text: 'Job :") '),
      Todo(id: '128', text: 'DSA DONE !! :") '),
      Todo(id: '129', text: 'Dead Inside ', isDone: true),
      Todo(id: '121', text: 'Dead Outside', isDone: true),
    ];
  }
}
