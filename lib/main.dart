import 'package:dynamic_gym/blocs/workout_cubit.dart';
import 'package:dynamic_gym/blocs/workouts_cubit.dart';
import 'package:dynamic_gym/screens/edit_workout_screen.dart';
import 'package:dynamic_gym/screens/home_page.dart';
import 'package:dynamic_gym/screens/workout_progress_screen.dart';
import 'package:dynamic_gym/states/workout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(const WorkoutTime());
}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsCubit>(
            create: (context) {
              WorkoutsCubit workoutsCubit = WorkoutsCubit();
              if (workoutsCubit.state.isEmpty) {
                print(".. loading the json since the state is empty..");
                workoutsCubit.getWorkouts();
              } else {
                print(".. the state is not empty..");
              }
              return workoutsCubit;
            },
          ),
          BlocProvider<WorkoutCubit>(create: (context) => WorkoutCubit()),
        ],
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
            builder: (context, workout) {
          if (workout is WorkoutInit) {
            return const HomePage();
          } else if (workout is WorkoutEditing) {
            return const EditWorkoutScreen();
          } else if (workout is WorkoutInProgress) {
            return const WorkoutProgressScreen();
          } else {
            return const WorkoutProgressScreen();
          }
        }),
      ),
    );
  }
}
