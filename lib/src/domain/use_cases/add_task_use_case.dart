import 'package:praxis_tareas_app/src/infrastructure/repository/task_repository.dart';

abstract class AddTaskUseCase {
  Future<void> call(String title);
}

class AddTaskUseCaseImpl implements AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCaseImpl(this.repository);

  @override
  Future<void> call(String title) async {
    return await repository.insertTask(title);
  }
}
