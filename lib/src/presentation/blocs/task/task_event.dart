part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;
  const AddTaskEvent(this.title);
}

class DeleteTaskEvent extends TaskEvent {
  final int taskId;
  const DeleteTaskEvent(this.taskId);
}

class UpdateTaskCompletedEvent extends TaskEvent {
  final int taskId;
  final bool completed;
  const UpdateTaskCompletedEvent(this.taskId, this.completed);
}
