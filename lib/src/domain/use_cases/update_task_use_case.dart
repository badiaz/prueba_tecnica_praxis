import 'package:praxis_tareas_app/src/infrastructure/repository/task_repository.dart';

abstract class UpdateTaskCompletedUseCase {
  Future<void> call(int id, bool completed);
}

class UpdateTaskCompletedUseCaseImpl implements UpdateTaskCompletedUseCase {
  final TaskRepository repository;

  UpdateTaskCompletedUseCaseImpl(this.repository);

  @override
  Future<void> call(int id, bool completed) async {
    return await repository.updateTaskCompleted(id, completed);
  }
}
