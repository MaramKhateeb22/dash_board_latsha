import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/screens/Insects/edit/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditInsectsCubit extends Cubit<EditInsectState> {
  EditInsectsCubit() : super(EditInsectsInitalState());
  static EditInsectsCubit get(context) => BlocProvider.of(context);
  final formkey = GlobalKey<FormState>();
  TextEditingController nameInsectEditController = TextEditingController();
  TextEditingController priceEditController = TextEditingController();
  // final uuid = const Uuid().v4();

  Future<String> saveDataInsctEdit(
    context,
    String idInsect,
    // TextEditingController nameInsectC,
    // TextEditingController priceInscetC
  ) async {
    String resp = "Some Error Occurred";
    try {
      emit(EditInsectsLoadingState());
      if (formkey.currentState?.validate() ?? false) {
        await FirebaseFirestore.instance
            .collection("insects")
            .doc(idInsect)
            .update(
          {
            // 'id': idInsect,
            // 'name': nameInsectEditController.text,
            'name': nameInsectEditController.text,
            // 'price': priceEditController.text,
            'price': priceEditController.text,
            'createdAtEdit': Timestamp.now(),
          },
        );
        // clearForm();
        emit(EditInsectsSuccessState());
        print("Success submit");
      } else {
        emit(
          EditInsectsErrorState(error: 'Field Required'),
        );
        print('non fire store');
      }
      resp = 'Success';
    } catch (err) {
      resp = err.toString();
      emit(EditInsectsErrorState(error: resp));
    }
    return resp;
  }

  void clearForm() {
    priceEditController.clear();
    nameInsectEditController.clear();
    emit(ClearFormState());
  }

  Future<QuerySnapshot<Map<String, dynamic>>?>? initDataInsect() async {
    return FirebaseFirestore.instance
        .collection("insects")
        .orderBy("createdAt", descending: true)
        .get();
  }
}
