abstract class ReportState {}

class ReportInitialState extends ReportState {}

//Pending
class ReportPendingLoadingState extends ReportState {}

class ReportPendingSuccessState extends ReportState {}

class ReportPendingErrorState extends ReportState {
  final String error;

  ReportPendingErrorState({required this.error});
}

//Accept
class ReportAcceptLoadingState extends ReportState {}

class ReportAcceptScuccessState extends ReportState {}

class ReportAcceptErrorState extends ReportState {
  final String error;

  ReportAcceptErrorState({required this.error});
}

//Reject
class ReportRejectLoadingState extends ReportState {}

class ReportRejectSuccessState extends ReportState {}

class ReportRejectErrorState extends ReportState {
  final String error;

  ReportRejectErrorState({required this.error});
}
