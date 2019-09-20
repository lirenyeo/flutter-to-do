import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'Todo List', home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = ['TEST'];

  void _addTodoItem(val) {
    setState(() {
      _todoItems.add(val);
    });
  }

  void _removeTodoItem(index) {
    log('HELLO, $index');
    setState(() {
      _todoItems.remove(index);
    });
  }

  Widget _buildTodoList() {
    if (_todoItems.length > 0) {
      return new ListView.builder(
        itemBuilder: (context, index) {
          if (index < _todoItems.length) {
            return _buildTodoItem(_todoItems[index]);
          }
        },
      );
    } else {
      return new Text("Nothing here!");
    }
  }

  Widget _buildTodoItem(String todoText) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () { _removeTodoItem(0); }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('- Todo List -')),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add Task!',
        child: new Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Add New Task')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              // log('**log**data: $val');
              // print('---print----data: $val');
              // debugPrint('====debugPrint===data: $val');
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}
