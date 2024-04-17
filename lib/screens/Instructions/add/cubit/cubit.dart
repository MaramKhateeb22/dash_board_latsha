import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/resources/util.dart';
import 'package:dash_board_mopidati/screens/Instructions/add/cubit/state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddInstractionCubit extends Cubit<AddInstractionState> {
  AddInstractionCubit() : super(AddInstractionInitalState());
  static AddInstractionCubit get(context) => BlocProvider.of(context);

  final formkey = GlobalKey<FormState>();
  TextEditingController adressController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  Uint8List? image;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final uuid = const Uuid().v4();

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = storage.ref().child(childName).child('${uuid}jpg');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void selectImage(context) async {
    Uint8List img = await pickImage(ImageSource.gallery, context);

    image = img;
    emit(SelectImageState());
  }

  Future<String> saveData(context) async {
    String resp = "Some Error Occurred";
    try {
      emit(AddInstractionLoadingState());
      if (formkey.currentState?.validate() ?? false) {
        String imagUrl =
            await uploadImageToStorage('InstractionsImage', image!);
        // await FirebaseFirestore.instance.collection('markers').add(locationMap);
        final uuid = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("Instractions")
            .doc(uuid)
            .set({
          'id': uuid,
          'Adress': adressController.text,
          'Details Instraction': detailsController.text,
          'imageLink': imagUrl,
          'createdAt': Timestamp.now(),
        });
        Navigator.pop(context);
        clearForm();
        emit(AddInstractionSuccessState());
        print("Success submit");
      } else {
        emit(
          AddInstractionErrorState(error: 'Field Required'),
        );

        print('non fire store');
      }
      resp = 'Success';
    } catch (err) {
      resp = err.toString();
      emit(AddInstractionErrorState(error: resp));
    }
    return resp;
  }

  void clearForm() {
    detailsController.clear();
    adressController.clear();
    image = null;
    emit(ClearFormState());
    // webImage = Uint8List(8);
  }
}
