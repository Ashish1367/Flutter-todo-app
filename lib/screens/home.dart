import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController _todoaddingitmes = TextEditingController();
  List<Todo> _searchToDo = [];
  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('todos');

  @override
  void initState() {
    _loadTodoList();
    _searchToDo = todolist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: _upperNav(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: FloatingActionButton(
              onPressed: () {
                _addItems(_todoaddingitmes.text);
              },
              child: const Icon(Icons.add),
            ),
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    searchbox(),
                    Expanded(
                      child: ListView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 40, bottom: 20),
                            child: const Text(
                              'Work Needs To be Done',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          for (Todo todo in _searchToDo)
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
                  margin:
                      const EdgeInsets.only(bottom: 15, left: 20, right: 20),
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
                        hintText: 'Add A New Task',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _toDoChanges(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    todoCollection.doc(todo.id).update({'isDone': todo.isDone});
  }

  void _toDoDelete(String id) async {
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
    await FirebaseFirestore.instance.collection('todos').doc(id).delete();
  }

  void _addItems(String todo) async {
    final newTodo = (Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(), text: todo));

    setState(() {
      todolist.add(newTodo);
    });

    _todoaddingitmes.clear();

    await todoCollection.doc(newTodo.id).set(newTodo.toJson());
  }

  void _search(String searchedKeyword) {
    List<Todo> result = [];
    if (searchedKeyword.isEmpty) {
      result = todolist;
    } else {
      result = todolist
          .where((item) =>
              item.text!.toLowerCase().contains(searchedKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _searchToDo = result;
    });
  }

  Future<void> _loadTodoList() async {
    final todoSnapshot = await todoCollection.get();

    setState(() {
      todolist.clear();
      todolist.addAll(todoSnapshot.docs
          .map((doc) => Todo.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    });
  }

  Widget searchbox() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[100]),
        child: TextField(
          onChanged: (value) => _search(value),
          decoration: const InputDecoration(
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
      title: const Text(
        'TODO',
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
    );
  }
}
