import 'package:dynamic_gym/blocs/workout_cubit.dart';
import 'package:dynamic_gym/blocs/workouts_cubit.dart';
import 'package:dynamic_gym/helpers.dart';
import 'package:dynamic_gym/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Time!'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.event_available_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
            builder: (context, workouts) {
          return ExpansionPanelList.radio(
            children: workouts
                .map((workout) => ExpansionPanelRadio(
                    value: workout,
                    headerBuilder: (context, isExpanded) => ListTile(
                          title: Text(workout.title!),
                          leading: IconButton(
                            onPressed: () {
                              BlocProvider.of<WorkoutCubit>(context)
                                  .editWorkout(
                                      workout, workouts.indexOf(workout));
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          trailing: Text(formatTime(workout.getTotal(), true)),
                          visualDensity: const VisualDensity(
                            horizontal: 0,
                            vertical: VisualDensity.maximumDensity,
                          ),
                          onTap: () => !isExpanded
                              ? BlocProvider.of<WorkoutCubit>(context)
                                  .startWorkout(workout)
                              : null,
                        ),
                    body: ListView.builder(
                        shrinkWrap: true,
                        itemCount: workout.exercises.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(workout.exercises[index].title!),
                            leading: Text(formatTime(
                                workout.exercises[index].prelude!, true)),
                            trailing: Text(formatTime(
                                workout.exercises[index].duration!, true)),
                            visualDensity: const VisualDensity(
                              horizontal: 0,
                              vertical: VisualDensity.maximumDensity,
                            ),
                          );
                        })))
                .toList(),
          );
        }),
      ),
    );
  }
}
