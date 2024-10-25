import 'package:get/get.dart';

class TaskController extends GetxController {
  // Reactive list to hold tasks
  var tasks = <String>[].obs;

  // Method to add a new task
  void addTask(String task) {
    tasks.add(task);
  }

  // Method to update a task
  void updateTask(int index, String newTask) {
    tasks[index] = newTask;
  }

  // Method to delete a task
  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}
