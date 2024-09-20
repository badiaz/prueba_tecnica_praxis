import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:praxis_tareas_app/src/domain/use_cases/use_cases.dart';
import 'package:praxis_tareas_app/src/infrastructure/repository/task_repository.dart';
import 'package:praxis_tareas_app/src/infrastructure/services/task_db_service.dart';
import 'package:praxis_tareas_app/src/presentation/blocs/task/task_bloc.dart';
import 'package:praxis_tareas_app/src/presentation/screens/screens.dart';
part 'router.dart';

void main() {
  final taskRepository = TaskRepository(service: TaskDBService());

  final getTasksUseCase = GetTasksUseCaseImpl(taskRepository);
  final addTaskUseCase = AddTaskUseCaseImpl(taskRepository);
  final deleteTaskUseCase = DeleteTaskUseCaseImpl(taskRepository);
  final updateTaskCompletedUseCase =
      UpdateTaskCompletedUseCaseImpl(taskRepository);

  runApp(BlocProvider(
      create: (_) => TaskBloc(
          getTasksUseCase: getTasksUseCase,
          addTaskUseCase: addTaskUseCase,
          deleteTaskUseCase: deleteTaskUseCase,
          updateTaskCompletedUseCase: updateTaskCompletedUseCase)
        ..add(LoadTasksEvent()),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
