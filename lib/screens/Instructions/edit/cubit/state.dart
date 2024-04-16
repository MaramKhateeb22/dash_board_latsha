abstract class EditInstractionState {}

class EditInstractionInitalState extends EditInstractionState {}

class EditInstractionLoadingState extends EditInstractionState {}

class EditInstractionSuccessState extends EditInstractionState {}

class EditInstractionErrorState extends EditInstractionState {
  final String error;

  EditInstractionErrorState({required this.error});
}

class SelectImageState extends EditInstractionState {}

class ClearFormState extends EditInstractionState {}
