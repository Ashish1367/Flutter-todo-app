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
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
          onTap: () {
            onChnages(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          tileColor: todo.isDone
              ? Colors.grey
              : const Color.fromARGB(255, 119, 239, 199),
          leading: Icon(
            todo.isDone ? Icons.radio_button_checked : Icons.radio_button_off,
            color: Colors.blue,
          ),
          title: Text(
            todo.text ?? "",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Color.fromARGB(255, 246, 61, 48),
              size: 25,
            ),
            onPressed: () {
              toDelete(todo.id);
            },
          )),
    );
  }
}
