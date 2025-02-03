import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'add_task_state.dart';

class AddTaskController extends GetxController {
  final AddTaskState state = AddTaskState();

  final CollectionReference _memoCollection =
      FirebaseFirestore.instance.collection('Memo Collection');

  CollectionReference get memoCollection => _memoCollection;
  Future<void> addTask(String task) async {
    if (task.isNotEmpty) {
      await _memoCollection.add({
        'task': task,
        'date':
            '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
      });
    }
  }

  Future<void> deleteTask(String docId) async {
    await _memoCollection.doc(docId).delete();
  }

  Future<void> updateTask(String docId, String updatedTask) async {
    await _memoCollection.doc(docId).update({'task': updatedTask});
  }
}
