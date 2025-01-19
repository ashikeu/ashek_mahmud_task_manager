import 'package:flutter/material.dart';

import '../../app.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';

Future<void> ShowDeleteConfirmationDialog(BuildContext context,String sno) async{
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async{
              await _deleteTask(sno);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}
Future<void> _deleteTask(String sid) async {
  // _getTaskCountByStatusInProgress = true;
  // setState(() {});
  final NetworkResponse response =
  await NetworkCaller.getRequest(url: Urls.deleteTaskUrl(sid));
  if (response.isSuccess) {
    showSnackBarMessage(TaskManagerApp.navigatorKey.currentContext!, "Task deleted successfully.");
  } else {
    showSnackBarMessage(TaskManagerApp.navigatorKey.currentContext!, response.errorMessage);
  }
  // _getTaskCountByStatusInProgress = false;
  // setState(() {});
}