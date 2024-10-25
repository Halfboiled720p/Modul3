import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/task_controller.dart';

class HomeScreen extends StatelessWidget {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _taskControllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Log out logic here
              // You might want to navigate back to registration or login page
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: _taskController.tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_taskController.tasks[index]),
              trailing: PopupMenuButton<String>(
                onSelected: (String value) async {
                  if (value == 'edit') {
                    _editTaskDialog(context, index);
                  } else if (value == 'delete') {
                    _taskController.deleteTask(index);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit Task'),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete Task'),
                    ),
                  ];
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: _taskControllerText,
            decoration: InputDecoration(labelText: 'Task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_taskControllerText.text.isNotEmpty) {
                  _taskController.addTask(_taskControllerText.text);
                  _taskControllerText.clear();
                  Get.back();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editTaskDialog(BuildContext context, int index) {
    _taskControllerText.text = _taskController.tasks[index]; // Set current task text

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: _taskControllerText,
            decoration: InputDecoration(labelText: 'Task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_taskControllerText.text.isNotEmpty) {
                  _taskController.updateTask(index, _taskControllerText.text);
                  _taskControllerText.clear();
                  Get.back();
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
