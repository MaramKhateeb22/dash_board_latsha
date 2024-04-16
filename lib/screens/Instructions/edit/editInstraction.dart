import 'package:dash_board_mopidati/screens/Instructions/edit/cubit/cubit.dart';
import 'package:dash_board_mopidati/screens/Instructions/edit/cubit/state.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/buttonwidget.dart';
import 'package:dash_board_mopidati/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class EditInstarctionScreen extends StatefulWidget {
  const EditInstarctionScreen({super.key});

  @override
  State<EditInstarctionScreen> createState() => _EditInstarctionScreenState();
}

class _EditInstarctionScreenState extends State<EditInstarctionScreen> {
  // String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List?;
    // String? receivedId;
    // String? receivedAddress;
    // String? receivedDetails;

    return BlocProvider(
      create: (context) => EditInstractionCubit(),
      child: BlocConsumer<EditInstractionCubit, EditInstractionState>(
        listener: (context, state) {
          if (state is EditInstractionSuccessState) {
            Navigator.pushNamed(context, '/AllInsractions');
            message(context, 'تم تعديل الارشاد  بنجاح');
            FlutterToastr.show(
              ' تم تعديل  الأرشاد  بنجاح ',
              context,
              position: FlutterToastr.bottom,
              duration: FlutterToastr.lengthLong,
              backgroundColor: backgroundColor,
              textStyle: const TextStyle(color: pColor),
            );
          }
        },
        builder: (context, state) {
          // String receivedAddress = arguments[1];
          // var receivedAddress = context
          //     .read<EditInstractionCubit>()
          //     .adresseditController = arguments![1];
          // // String receivedDetails = arguments[2];
          // var receivedDetails = context
          //     .read<EditInstractionCubit>()
          //     .detailseditController = arguments[2];
          // if (arguments.length >= 3) {
          //   String receivedId = arguments[0];

          //   // String receivedAddress = arguments[1];
          // String receivedAddress
          // =
          context.read<EditInstractionCubit>().adresseditController.text =
              arguments![1];
          // String receivedDetails = arguments[2];
          // String receivedDetails =
          context.read<EditInstractionCubit>().detailseditController.text =
              arguments[2];
          // }

          return Scaffold(
            appBar: AppBar(
              title: const Text('تعديل الإرشاد'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          context.read<EditInstractionCubit>().image != null
                              ? SizedBox(
                                  child: Image.memory(
                                    context.read<EditInstractionCubit>().image!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: pColor,
                                  ),
                                  width: 300,
                                  height: 300,
                                  child: TextButton(
                                    onPressed: () {
                                      context
                                          .read<EditInstractionCubit>()
                                          .selectImage(context);
                                    },
                                    child: const Text(
                                      'ارفع صورة لتوضيح الارشاد',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: context.read<EditInstractionCubit>().formkey,
                      child: Column(
                        children: [
                          TextFormFieldWidget(
                              height: 1,
                              maxLines: null,
                              yourController: context
                                  .read<EditInstractionCubit>()
                                  .adresseditController,
                              hintText: 'تعديل عنوان الارشاد  ',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'هذا الحقل مطلوب';
                                }
                              },
                              keyboardType: TextInputType.name),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: context
                                .read<EditInstractionCubit>()
                                .detailseditController,
                            keyboardType: TextInputType.multiline,
                            // style: const TextStyle(height: 0.2),
                            maxLines: null, // عدد الخطوط غير محدود
                            decoration: const InputDecoration(
                              labelText:
                                  ' أدخل تفاصيل الارشاد', // يمكنك تغيير النص هنا
                              hintText: 'تعديل  التفاصيل...',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'لا يمكن أن يكون الحقل فارغًا';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state is EditInstractionLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ButtonWidget(
                                icon: Icons.telegram,
                                child: ' تعديل',
                                // widthFactor: 0.34,
                                onPressed: () {
                                  context.read<EditInstractionCubit>().image ==
                                          null
                                      ? message(context,
                                          ' أرفع صورة للتوضيح من فضلك قبل الارسال')
                                      : null;
                                  // احفظ البيانات باستخدام Cubit
                                  context
                                      .read<EditInstractionCubit>()
                                      .editInstractionSaveData(
                                          context, arguments[0]);
                                  // print(arguments);
                                },
                              ),
                        const SizedBox(
                          width: 20,
                        ),
                        ButtonWidget(
                          icon: Icons.delete,
                          child: 'مسح الفورم',
                          onPressed: () {
                            context.read<EditInstractionCubit>().clearForm();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
