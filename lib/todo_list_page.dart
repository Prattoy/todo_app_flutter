import 'package:flutter/material.dart';
import 'package:todo_app_flutter/add_task_dialog.dart';
import 'package:todo_app_flutter/task.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<Task> _tasks = [];

  void _addTask(String taskName) {
    setState(() {
      _tasks.add(Task(name: taskName));
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            leading: Text('${index + 1}.'),
            title: Text(
              task.name,
              style: task.isCompleted
                  ? TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                  ),
                  onPressed: () => _toggleTaskCompletion(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeTask(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final taskName = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              TextEditingController _controller = TextEditingController();
              return AddTaskDialog(controller: _controller);
            },
          );
          if (taskName != null && taskName.isNotEmpty) {
            _addTask(taskName);
          }
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
