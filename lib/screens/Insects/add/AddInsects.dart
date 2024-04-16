import 'package:dash_board_mopidati/screens/Insects/AllInsects.dart';
import 'package:dash_board_mopidati/screens/Insects/add/cubit/cubit.dart';
import 'package:dash_board_mopidati/screens/Insects/add/cubit/state.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddInsectsScreen extends StatelessWidget {
  const AddInsectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddInsectsCubit(),
      child: BlocConsumer<AddInsectsCubit, AddInsectsState>(
        listener: (context, state) {
          if (state is AddInsectsSuccessState) {
            message(context, 'تمت الإضافة بنجاح');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    const AllInsectPriceScreen(), // استبدل بالشاشة التي تريد الانتقال إليها
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('إضافة سعر الرش '),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: context.read<AddInsectsCubit>().formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            // autovalidateMode: AutovalidateMode.always,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              height: 0.3,
                            ),
                            controller: context
                                .read<AddInsectsCubit>()
                                .nameInsectController,
                            decoration: const InputDecoration(
                                label: Text('أدخل اسم الحشرة'),
                                border: OutlineInputBorder(),
                                hintText: 'أدخل اسم الحشرة'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'لا يمكن لهذا الحقل أن يبقى فارغا ';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            style: const TextStyle(height: 0.3),
                            controller:
                                context.read<AddInsectsCubit>().priceController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text(' أدخل  سعر ال كم ل.س'),
                                hintText: ' أدخل  سعر ال كم'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'لا يمكن أن يكون الحقل فارغًا';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      state is AddInsectsLoadingState
                          ? const CircularProgressIndicator()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: ButtonWidget(
                                // widthFactor: 0.3,
                                backgroundColors: cardbackground,
                                icon: Icons.bug_report,
                                child: 'إرسال',
                                onPressed: () {
                                  context
                                      .read<AddInsectsCubit>()
                                      .formkey
                                      .currentState!
                                      .validate();
                                  context
                                      .read<AddInsectsCubit>()
                                      .saveDataInscts(context);
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
                          context.read<AddInsectsCubit>().clearForm();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
