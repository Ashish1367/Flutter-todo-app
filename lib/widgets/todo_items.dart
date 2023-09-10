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
          tileColor: const Color(0xff5DEEBE),
          leading: Icon(
            todo.isDone ? Icons.radio_button_checked : Icons.radio_button_off,
            color: Colors.blue,
          ),
          title: Text(
            todo.text ?? "",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: todo.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
              size: 25,
            ),
            onPressed: () {
              toDelete(todo.id);
            },
          )),
    );
  }
}
