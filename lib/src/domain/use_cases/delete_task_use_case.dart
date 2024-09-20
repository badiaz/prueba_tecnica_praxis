import 'package:praxis_tareas_app/src/infrastructure/repository/task_repository.dart';

abstract class DeleteTaskUseCase {
  Future<void> call(int id);
}

class DeleteTaskUseCaseImpl implements DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCaseImpl(this.repository);

  @override
  Future<void> call(int id) async {
    return await repository.deleteTask(id);
  }
}
