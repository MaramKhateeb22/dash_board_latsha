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
    String id = arguments![0];

    return BlocProvider(
      create: (context) {
        EditInsectsCubit cubit = EditInsectsCubit();
        cubit.nameInsectEditController.text = arguments[1];
        cubit.priceEditController.text = arguments[2];
        return cubit;
      },
      child: BlocConsumer<EditInsectsCubit, EditInsectState>(
        listener: (context, state) {
          if (state is EditInsectsSuccessState) {
            message(context, 'تم التعديل بنجاح');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('تعديل السعر '),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: context.read<EditInsectsCubit>().formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('عدل اسم الحشرة'),
                            hintText: 'عدل اسم الحشرة'),
                        // initialValue: nameInsectController,
                        controller: context
                            .read<EditInsectsCubit>()
                            .nameInsectEditController,
                        style: const TextStyle(height: 0.3),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                              label: Text('عدل  السعر لل كم '),
                              hintText: 'عدل السعر '),
                          style: const TextStyle(height: 0.3),
                          keyboardType: TextInputType.number,
                          controller: context
                              .read<EditInsectsCubit>()
                              .priceEditController),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          state is EditInsectsLoadingState
                              ? const CircularProgressIndicator()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: ButtonWidget(
                                    side: const BorderSide(color: Colors.green),
                                    // widthFactor: 0.3,
                                    // backgroundColors: cardbackground,
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
                            side: const BorderSide(
                                style: BorderStyle.solid, color: Colors.red),
                            // backgroundColors: cardbackground,
                            child: 'حذف ',
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
