import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'view_task_state.dart';

class ViewTaskController extends GetxController {
  final ViewTaskState state = ViewTaskState();

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
}
