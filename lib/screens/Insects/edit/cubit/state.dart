abstract class EditInsectState {}

class EditInsectsInitalState extends EditInsectState {}

class EditInsectsLoadingState extends EditInsectState {}

class EditInsectsSuccessState extends EditInsectState {}

class EditInsectsErrorState extends EditInsectState {
  final String error;

  EditInsectsErrorState({required this.error});
}

class ClearFormState extends EditInsectState {}
