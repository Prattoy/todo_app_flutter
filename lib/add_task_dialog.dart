import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter task name'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(controller.text);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
