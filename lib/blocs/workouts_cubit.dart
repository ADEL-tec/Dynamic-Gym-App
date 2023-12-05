import 'dart:convert';

import 'package:dynamic_gym/models/exercise.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/workout.dart';

class WorkoutsCubit extends HydratedCubit<List<Workout>> {
  WorkoutsCubit() : super([]);

  getWorkouts() async {
    final List<Workout> workouts = [];

    final workoutsJson =
        jsonDecode(await rootBundle.loadString("assets/workouts.json"));
    for (var el in (workoutsJson as Iterable)) {
      workouts.add(Workout.fromJson(el));
    }
    emit(workouts);
  }

  saveWorkouts(Workout workout, int index) {
    Workout newWorkout = Workout(title: workout.title, exercises: []);
    int exIndex = 0;
    int startTime = 0;
    for (var ex in workout.exercises) {
      newWorkout.exercises.add(
        Exercise(
          title: ex.title,
          prelude: ex.prelude,
          duration: ex.duration,
          index: exIndex,
          startTime: startTime,
        ),
      );
      exIndex++;
      startTime += ex.prelude! + ex.duration!;
    }

    state[index] = newWorkout;
    emit([...state]);
    print('--i have ${state.length} state');
  }

  @override
  List<Workout>? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    List<Workout> workouts = [];
    json['workouts'].forEach((el) => workouts.add(Workout.fromJson(el)));
    print('___get ${workouts[0]}');
    print('___get ${workouts.length} workout from local storage ');
    return workouts;
  }

  @override
  Map<String, dynamic>? toJson(List<Workout> state) {
    // TODO: implement toJson
    final json = {"workouts": []};
    for (var wo in state) {
      json["workouts"]!.add(wo.toJson());
    }

    print('___save workouts : $json ');

    return json;
  }
}
