import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/screens/Insects/add/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddInsectsCubit extends Cubit<AddInsectsState> {
  AddInsectsCubit() : super(AddInsectsInitalState());
  static AddInsectsCubit get(context) => BlocProvider.of(context);
  final formkey = GlobalKey<FormState>();
  TextEditingController nameInsectController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final uuid = const Uuid().v4();

  Future<String> saveDataInscts(context) async {
    String resp = "Some Error Occurred";
    try {
      emit(AddInsectsLoadingState());
      if (formkey.currentState?.validate() ?? false) {
        final uuid = const Uuid().v4();
        await FirebaseFirestore.instance.collection("insects").doc(uuid).set(
          {
            'id': uuid,
            'name': nameInsectController.text,
            'price': priceController.text,
            'createdAt': Timestamp.now(),
          },
        );
        clearForm();
        emit(AddInsectsSuccessState());
        print("Success submit");
      } else {
        emit(
          AddInsectsErrorState(error: 'Field Required'),
        );
        print('non fire store');
      }
      resp = 'Success';
    } catch (err) {
      resp = err.toString();
      emit(AddInsectsErrorState(error: resp));
    }
    return resp;
  }

  void clearForm() {
    priceController.clear();
    nameInsectController.clear();
    emit(ClearFormState());
  }
}
