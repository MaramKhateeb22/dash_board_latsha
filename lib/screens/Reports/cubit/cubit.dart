import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/screens/Reports/Reports.dart';
import 'package:dash_board_mopidati/screens/Reports/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitialState());
  static ReportCubit get(context) => BlocProvider.of(context);

//reject
  Future<String> rejectReport(context, String idReports) async {
    String resp = "Some Error Occurred";
    try {
      emit(ReportRejectLoadingState());
      statusReport statusReject = statusReport.reject;
      int statusIndex = statusReport.reject.index;
      await FirebaseFirestore.instance
          .collection("Reports")
          .doc(idReports)
          .update({'statusReport': statusIndex});
      emit(ReportRejectSuccessState());
      print("reject Report ✔");
    } catch (err) {
      emit(ReportRejectErrorState(error: resp));
      resp = err.toString();
    }
    return resp;
  }

//Accept
  Future<String> acceptReport(context, String idReports) async {
    String resp = "Some Error Occurred";
    try {
      emit(ReportAcceptLoadingState());
      statusReport statusAccept = statusReport.accept;
      int statusIndex = statusReport.accept.index;
      await FirebaseFirestore.instance
          .collection("Reports")
          .doc(idReports)
          .update({'statusReport': statusIndex});
      emit(ReportAcceptScuccessState());
      print("Accept Report ✔");
    } catch (err) {
      emit(ReportAcceptErrorState(error: resp));
      resp = err.toString();
    }
    return resp;
  }
}
