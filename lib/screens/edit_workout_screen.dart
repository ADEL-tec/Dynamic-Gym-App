import 'package:dynamic_gym/blocs/workout_cubit.dart';
import 'package:dynamic_gym/blocs/workouts_cubit.dart';
import 'package:dynamic_gym/helpers.dart';
import 'package:dynamic_gym/models/workout.dart';
import 'package:dynamic_gym/states/workout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/exercise.dart';
import 'edit_exercise_screen.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
      child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (blocContext, state) {
        WorkoutEditing we = state as WorkoutEditing;
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
            ),
            title: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (alertContext) {
                      TextEditingController controller = TextEditingController(
                        text: we.workout!.title!.toString(),
                      );
                      return AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            label: Text('Workout title'),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  Navigator.pop(context);
                                  Workout renamed = we.workout!
                                      .copyWith(title: controller.text);
                                  BlocProvider.of<WorkoutsCubit>(context)
                                      .saveWorkouts(renamed, we.index);
                                  BlocProvider.of<WorkoutCubit>(context)
                                      .editWorkout(renamed, we.index);
                                }
                              },
                              child: const Text('Rename')),
                        ],
                      );
                    });
              },
              child: Text(we.workout!.title!),
            ),
          ),
          body: ListView.builder(
              itemCount: we.workout!.exercises.length,
              itemBuilder: (listContext, index) {
                Exercise exercise = we.workout!.exercises[index];
                if (we.exIndex == index) {
                  return EditExerciseScreen(
                    workout: we.workout,
                    index: we.index,
                    exIndex: we.exIndex,
                  );
                } else {
                  return ListTile(
                    leading: Text(formatTime(exercise.prelude!, true)),
                    title: Text(exercise.title!),
                    trailing: Text(formatTime(exercise.duration!, true)),
                    onTap: () => BlocProvider.of<WorkoutCubit>(context)
                        .editExercise(index),
                  );
                }
              }),
        );
      }),
    );
  }
}
