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
          backgroundColor: const Color.fromARGB(255, 85, 65, 75),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      searchbox(),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, bottom: 0),
                              child: const Text(
                                'tasks to do',
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(218, 255, 255, 255)),
                              ),
                            ),
                            const Divider(
                              thickness: 0.6,
                              color: Color.fromARGB(255, 85, 65, 75),
                            ),
                            for (Todo todo in _searchToDo)
                              Items(
                                todo: todo,
                                onChnages: _toDoChanges,
                                toDelete: _toDoDelete,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 85, 65,
                    75), // This ensures a constant white background
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 4, left: 12, right: 8, top: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 238, 233),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 2.0,
                                spreadRadius: 0.0)
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _todoaddingitmes,
                          decoration: const InputDecoration(
                              hintText: 'add a new task',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20)),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 60,
                      margin:
                          const EdgeInsets.only(bottom: 2, right: 10, top: 2),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 4.0,
                              spreadRadius: 0.0)
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          _addItems(_todoaddingitmes.text);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                const Color.fromARGB(255, 243, 238, 233)),
                        child: const Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
        padding: const EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 243, 238, 233)),
        child: TextField(
          onChanged: (value) => _search(value),
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
                size: 28,
              ),
              border: InputBorder.none,
              hintText: 'search...',
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 110, 110, 110), fontSize: 20)),
        ));
  }

  AppBar _upperNav() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 85, 65, 75),
      title: const Padding(
        padding: EdgeInsets.only(
            left: 8.0, top: 8.0), // Adjust the padding values as needed
        child: Center(
          child: Text(
            'Todo',
            style: TextStyle(
                color: Color.fromARGB(218, 255, 255, 255),
                fontSize: 26,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
