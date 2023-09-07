import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/todo_items.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todolist = Todo.todolist();
  final _todoaddingitmes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _upperNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 0.0),
          child: FloatingActionButton(
            onPressed: () {
              _addItems(_todoaddingitmes.text);
            },
            child: const Icon(Icons.add),
          )),
      bottomNavigationBar: _bottomNav(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                searchbox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40, bottom: 20),
                        child: const Text(
                          'Work Needs To be Done',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      for (Todo todo in todolist)
                        Items(
                          todo: todo,
                          onChnages: _toDoChanges,
                          toDelete: _toDoDelete,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0)
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _todoaddingitmes,
                decoration: const InputDecoration(
                    hintText: 'Add A New Task', border: InputBorder.none),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _toDoChanges(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _toDoDelete(String id) {
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
  }

  void _addItems(String todo) {
    setState(() {
      todolist.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(), text: todo));
    });
    _todoaddingitmes.clear();
  }

  Widget searchbox() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[100]),
        child: const TextField(
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
                size: 20,
              ),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
        ));
  }

  AppBar _upperNav() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.pink[300],
      title: const Text('To_Do Application'),
    );
  }

  BottomAppBar _bottomNav() {
    return BottomAppBar(
        color: Colors.pink[300],
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                size: 40,
              ),
            ),
          ],
        ));
  }
}
