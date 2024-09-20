import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praxis_tareas_app/src/domain/entities/task_entity.dart';
import 'package:praxis_tareas_app/src/domain/use_cases/use_cases.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskCompletedUseCase updateTaskCompletedUseCase;

  TaskBloc({
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.deleteTaskUseCase,
    required this.updateTaskCompletedUseCase,
  }) : super(TasksInitial()) {
    on<LoadTasksEvent>((event, emit) async {
      emit(TasksLoading());
      try {
        final tasks = await getTasksUseCase.call();
        emit(TasksLoaded(tasks));
      } catch (e) {
        emit(const TasksError('Error loading tasks'));
      }
    });

    on<AddTaskEvent>((event, emit) async {
      try {
        await addTaskUseCase.call(event.title);
        add(LoadTasksEvent());
      } catch (e) {
        emit(const TasksError('Error adding task'));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await deleteTaskUseCase.call(event.taskId);
        add(LoadTasksEvent());
      } catch (e) {
        emit(const TasksError('Error deleting task'));
      }
    });

    on<UpdateTaskCompletedEvent>((event, emit) async {
      try {
        await updateTaskCompletedUseCase.call(event.taskId, event.completed);
        add(LoadTasksEvent());
      } catch (e) {
        emit(const TasksError('Error updating task'));
      }
    });
  }
}
