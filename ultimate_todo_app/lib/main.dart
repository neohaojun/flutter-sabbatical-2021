import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'detail.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ultimate Todo App',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<QuerySnapshot> _getTodos;

  @override
  void initState() {
    super.initState();
    _getTodos = FirebaseFirestore.instance.collection('todos').get();
  }

  void _refreshTodos() {
    setState(() {
      _getTodos = FirebaseFirestore.instance.collection('todos').get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ultimate Todo App'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshTodos,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final titleController = TextEditingController();
          final descriptionController = TextEditingController();

          final completed = await showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.all(8.0),
                title: Text('Create Item'),
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextButton(
                    child: Text('Done'),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              );
            },
          );

          if (completed) {
            await FirebaseFirestore.instance.collection('todos').add({
              "title": titleController.text,
              "description": descriptionController.text,
              "isDone": false,
            });
            _refreshTodos();
          }
        },
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _getTodos,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final undoneTodos = snapshot.data.docs
              .where((DocumentSnapshot document) => document.data()['isDone'] == false)
              .toList();

          return ListView.separated(
            itemCount: undoneTodos.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(undoneTodos[index].data()["title"]),
                trailing: Icon(Icons.arrow_forward),
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPage(todo: undoneTodos[index]),
                  ));
                  _refreshTodos();
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
