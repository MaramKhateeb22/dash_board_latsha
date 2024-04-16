abstract class AddInsectsState {}

class AddInsectsInitalState extends AddInsectsState {}

class AddInsectsLoadingState extends AddInsectsState {}

class AddInsectsSuccessState extends AddInsectsState {}

class AddInsectsErrorState extends AddInsectsState {
  final String error;

  AddInsectsErrorState({required this.error});
}

class ClearFormState extends AddInsectsState {}
