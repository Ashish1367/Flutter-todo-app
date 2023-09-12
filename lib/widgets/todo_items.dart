import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class Items extends StatelessWidget {
  final Todo todo;
  final onChnages;
  final toDelete;
  const Items({
    Key? key,
    required this.todo,
    required this.onChnages,
    required this.toDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
          onTap: () {
            onChnages(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          tileColor: todo.isDone
              ? const Color.fromARGB(255, 213, 213, 213)
              : const Color.fromARGB(255, 119, 239, 199),
          leading: Icon(
            todo.isDone ? Icons.radio_button_checked : Icons.radio_button_off,
            color: todo.isDone
                ? const Color.fromARGB(255, 114, 113, 113)
                : Colors.blue,
          ),
          title: Text(
            todo.text ?? "",
            style: TextStyle(
              fontSize: 18,
              color: todo.isDone
                  ? const Color.fromARGB(255, 114, 113, 113)
                  : Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: todo.isDone
                  ? const Color.fromARGB(255, 114, 113, 113)
                  : const Color.fromARGB(255, 246, 61, 48),
              size: 25,
            ),
            onPressed: () {
              toDelete(todo.id);
            },
          )),
    );
  }
}
