import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praxis_tareas_app/src/presentation/blocs/task/task_bloc.dart';
import 'package:praxis_tareas_app/src/presentation/widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          const _HomeHeader(),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TasksLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TasksLoaded) {
                if (state.tasks.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'Añade una tarea',
                        style:
                            TextStyle(fontSize: 25.0, color: Colors.grey[400]),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return TaskCard(task: task);
                      },
                    ),
                  );
                }
              } else if (state is TasksError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.2,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            const BorderRadius.only(bottomRight: Radius.circular(50.0)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[400]!, spreadRadius: 2.0, blurRadius: 2.0),
        ],
      ),
      child: SafeArea(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'To Do List',
            style: TextStyle(
                fontSize: size.width * 0.1, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

void _showAddTaskDialog(BuildContext context) {
  final TextEditingController taskTitleController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('New task'),
        content: TextFormField(
          controller: taskTitleController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: 'Title',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Create',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              final String taskTitle = taskTitleController.text;
              if (taskTitle.isNotEmpty) {
                context.read<TaskBloc>().add(AddTaskEvent(taskTitle));

                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El título no puede estar vacío'),
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
