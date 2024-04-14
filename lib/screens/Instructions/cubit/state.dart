abstract class AddInstractionState {}

class AddInstractionInitalState extends AddInstractionState {}

class AddInstractionLoadingState extends AddInstractionState {}

class AddInstractionSuccessState extends AddInstractionState {}

class AddInstractionErrorState extends AddInstractionState {
  final String error;

  AddInstractionErrorState({required this.error});
}

class SelectImageState extends AddInstractionState {}

class ClearFormState extends AddInstractionState {}
