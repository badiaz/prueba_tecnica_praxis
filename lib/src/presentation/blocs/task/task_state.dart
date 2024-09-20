part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TaskState {}

class TasksLoading extends TaskState {}

class TasksLoaded extends TaskState {
  final List<TaskEntity> tasks;
  const TasksLoaded(this.tasks);
}

class TasksError extends TaskState {
  final String message;
  const TasksError(this.message);
}
