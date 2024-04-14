abstract class ReverseState {}

class ReverseInitialState extends ReverseState {}

//Pending
class ReversePendingLoadingState extends ReverseState {}

class ReversePendingSuccessState extends ReverseState {}

class ReversePendingErrorState extends ReverseState {
  final String error;

  ReversePendingErrorState({required this.error});
}

//Accept
class ReverseAcceptLoadingState extends ReverseState {}

class ReverseAcceptScuccessState extends ReverseState {}

class ReverseAcceptErrorState extends ReverseState {
  final String error;

  ReverseAcceptErrorState({required this.error});
}

//Reject
class ReverseRejectLoadingState extends ReverseState {}

class ReverseRejectSuccessState extends ReverseState {}

class ReverseRejectErrorState extends ReverseState {
  final String error;

  ReverseRejectErrorState({required this.error});
}

//Done
class ReverseDoneLoadingState extends ReverseState {}

class ReverseDoneSuccessState extends ReverseState {}

class ReverseDoneErrorState extends ReverseState {
  final String error;

  ReverseDoneErrorState({required this.error});
}
