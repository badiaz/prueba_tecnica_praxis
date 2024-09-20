import 'package:praxis_tareas_app/src/domain/entities/task_entity.dart';
import 'package:praxis_tareas_app/src/infrastructure/services/task_db_service.dart';

abstract class ITaskRepository {
  Future<List<TaskEntity>> getTasks();
  Future<void> insertTask(String title);
  Future<void> updateTaskCompleted(int id, bool completed);
  Future<void> deleteTask(int id);
}

class TaskRepository implements ITaskRepository {
  final TaskDBService service;

  TaskRepository({required this.service});

  @override
  Future<List<TaskEntity>> getTasks() async {
    return await service.getTasks();
  }

  @override
  Future<void> insertTask(String title) async {
    await service.insertTask(TaskEntity(title: title, completed: false));
  }

  @override
  Future<void> updateTaskCompleted(int id, bool completed) async {
    await service.updateTaskCompleted(id, completed);
  }

  @override
  Future<void> deleteTask(int id) async {
    await service.deleteTask(id);
  }
}
