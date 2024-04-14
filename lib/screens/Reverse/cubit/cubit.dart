import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/screens/Reverse/Reverse.dart';
import 'package:dash_board_mopidati/screens/Reverse/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReverseCubit extends Cubit<ReverseState> {
  ReverseCubit() : super(ReverseInitialState());
  static ReverseCubit get(context) => BlocProvider.of(context);

//reject
  Future<String> rejectReveres(context, String idReverse) async {
    String resp = "Some Error Occurred";
    try {
      emit(ReverseRejectLoadingState());
      statusReverse statusReject = statusReverse.reject;
      int statusIndex = statusReverse.reject.index;
      await FirebaseFirestore.instance
          .collection("Reverses")
          .doc(idReverse)
          .update({'statusReverse': statusIndex});
      emit(ReverseRejectSuccessState());
      print("reject Reverse ✔");
    } catch (err) {
      emit(ReverseRejectErrorState(error: resp));
      resp = err.toString();
    }
    return resp;
  }

//Accept
  Future<String> acceptReverse(context, String idReverse) async {
    String resp = "Some Error Occurred";
    try {
      emit(ReverseAcceptLoadingState());
      statusReverse statusAccept = statusReverse.accept;
      int statusIndex = statusReverse.accept.index;
      await FirebaseFirestore.instance
          .collection("Reverses")
          .doc(idReverse)
          .update({'statusReverse': statusIndex});
      emit(ReverseAcceptScuccessState());
      print("Accept Reverse ✔");
    } catch (err) {
      emit(ReverseAcceptErrorState(error: resp));
      resp = err.toString();
    }
    return resp;
  }

//Done
  Future<String> DoneReveres(context, String idReverse) async {
    String resp = "Some Error Occurred";
    try {
      emit(ReverseDoneLoadingState());
      statusReverse statusReject = statusReverse.done;
      int statusIndex = statusReverse.done.index;
      await FirebaseFirestore.instance
          .collection("Reverses")
          .doc(idReverse)
          .update({'statusReverse': statusIndex});
      emit(ReverseDoneSuccessState());
      print("Done Reverse ✔");
    } catch (err) {
      emit(ReverseDoneErrorState(error: resp));
      resp = err.toString();
    }
    return resp;
  }
}
