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
              : const Color.fromARGB(255, 239, 225, 209),
          leading: Icon(
            todo.isDone ? Icons.radio_button_checked : Icons.radio_button_off,
            color: todo.isDone
                ? const Color.fromARGB(255, 114, 113, 113)
                : const Color.fromARGB(255, 63, 64, 66),
          ),
          title: Text(
            todo.text ?? "",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: todo.isDone
                  ? const Color.fromARGB(255, 114, 113, 113)
                  : const Color.fromARGB(255, 101, 101, 102),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: todo.isDone
                  ? const Color.fromARGB(255, 114, 113, 113)
                  : const Color.fromARGB(255, 114, 113, 113),
              size: 25,
            ),
            onPressed: () {
              toDelete(todo.id);
            },
          )),
    );
  }
}
