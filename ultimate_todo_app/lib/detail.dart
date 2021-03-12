import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key key, @required this.todo}) : super(key: key);

  final DocumentSnapshot todo;
  final _todosCollection = FirebaseFirestore.instance.collection('todos');

  Future<void> _markAsDone(BuildContext context) async {
    await _todosCollection.doc(todo.id).update({'isDone': true});
    Navigator.of(context).pop();
  }

  Future<void> _delete(BuildContext context) async {
    await _todosCollection.doc(todo.id).delete();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _delete(context),
          ),
          if (!todo.data()["isDone"])
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () => _markAsDone(context),
            ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              todo.data()["title"],
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text(todo.data()["description"]),
          ),
        ],
      ),
    );
  }
}
