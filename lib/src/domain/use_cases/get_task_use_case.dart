import 'package:praxis_tareas_app/src/domain/entities/task_entity.dart';
import 'package:praxis_tareas_app/src/infrastructure/repository/task_repository.dart';

abstract class GetTasksUseCase {
  Future<List<TaskEntity>> call();
}

class GetTasksUseCaseImpl implements GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCaseImpl(this.repository);

  @override
  Future<List<TaskEntity>> call() async {
    return await repository.getTasks();
  }
}
