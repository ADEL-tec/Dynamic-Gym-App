import 'package:dynamic_gym/models/workout.dart';
import 'package:equatable/equatable.dart';

abstract class WorkoutState extends Equatable {
  final Workout? workout;
  final int? elapsed;
  const WorkoutState(this.workout, this.elapsed);
}

class WorkoutInit extends WorkoutState {
  const WorkoutInit() : super(null, 0);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WorkoutEditing extends WorkoutState {
  final int index;
  final int? exIndex;
  const WorkoutEditing(Workout? workout, this.index, this.exIndex)
      : super(workout, 0);

  @override
  // TODO: implement props
  List<Object?> get props => [workout, index, exIndex];
}

class WorkoutInProgress extends WorkoutState {
  const WorkoutInProgress(Workout? workout, int? elapsed)
      : super(workout, elapsed);
  @override
  // TODO: implement props
  List<Object?> get props => [workout, elapsed];
}

class WorkoutPaused extends WorkoutState {
  const WorkoutPaused(Workout? workout, int? elapsed) : super(workout, elapsed);
  @override
  // TODO: implement props
  List<Object?> get props => [workout, elapsed];
}
