import 'package:services_manager/models/task.dart';
import 'package:services_manager/models/user.dart';

class TaskManager {
  final List<User> userProfiles;

  TaskManager({required this.userProfiles});

  List<Task>? getTasksForUser(String userId) {
    User? user = userProfiles.firstWhere((profile) => profile.id == userId);
    if (user != null) {
      return user.tasks;
    }
    return [];
  }
}
