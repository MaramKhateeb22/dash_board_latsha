import 'package:dash_board_mopidati/screens/Insects/edit/cubit/cubit.dart';
import 'package:dash_board_mopidati/screens/Insects/edit/cubit/state.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditInsectScreen extends StatelessWidget {
  const EditInsectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List?;

    return BlocProvider(
      create: (context) => EditInsectsCubit(),
      child: BlocConsumer<EditInsectsCubit, EditInsectState>(
        listener: (context, state) {},
        builder: (context, state) {
          String id = arguments![0];
          String nameInsectController = context
              .read<EditInsectsCubit>()
              .nameInsectEditController
              .text = arguments[1];
          String priceController = context
              .read<EditInsectsCubit>()
              .priceEditController
              .text = arguments[2];

          return Scaffold(
            appBar: AppBar(
              title: const Text('تعديل السعر '),
            ),
            body: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: nameInsectController,
                        // controller: context
                        //     .read<EditInsectsCubit>()
                        //     .nameInsectEditController,
                      ),
                      TextFormField(
                          initialValue: priceController,
                          keyboardType: TextInputType.number,
                          controller: context
                              .read<EditInsectsCubit>()
                              .priceEditController)
                      // FutureBuilder(
                      //   future:
                      //       context.read<EditInsectsCubit>().initDataInsect(),
                      //   builder: (context, snap) {
                      //     if (snap.connectionState == ConnectionState.waiting) {
                      //       return const Center(
                      //           child: CircularProgressIndicator());
                      //     }
                      //     if (snap.hasError)
                      //       return const Text("Something has error");
                      //     if (snap.data == null) {
                      //       return const Text("لا يوجد بيانات ");
                      //     }
                      //     return Column(children: [
                      //       TextFormField(initialValue: '${snap.data!.docs[index]['name']}',)
                      //     ],);
                      // },
                      // ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    state is EditInsectsLoadingState
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: ButtonWidget(
                              // widthFactor: 0.3,
                              backgroundColors: cardbackground,
                              icon: Icons.bug_report,
                              child: 'تعديل',
                              onPressed: () {
                                context
                                    .read<EditInsectsCubit>()
                                    .formkey
                                    .currentState!
                                    .validate();
                                context
                                    .read<EditInsectsCubit>()
                                    .saveDataInsctEdit(context, id);
                              },
                            ),
                          ),
                    ButtonWidget(
                      backgroundColors: cardbackground,
                      child: 'حذف الفورم',
                      icon: Icons.delete,
                      colorIcon: Colors.red,
                      colorText: Colors.red,
                      onPressed: () {
                        context.read<EditInsectsCubit>().clearForm();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
