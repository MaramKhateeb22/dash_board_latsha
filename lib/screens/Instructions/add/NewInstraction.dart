import 'package:dash_board_mopidati/screens/Instructions/AllInstraction.dart';
import 'package:dash_board_mopidati/screens/Instructions/add/cubit/cubit.dart';
import 'package:dash_board_mopidati/screens/Instructions/add/cubit/state.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/buttonwidget.dart';
import 'package:dash_board_mopidati/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class NewInstarctionScreen extends StatefulWidget {
  const NewInstarctionScreen({super.key});

  @override
  State<NewInstarctionScreen> createState() => _NewInstarctionScreenState();
}

class _NewInstarctionScreenState extends State<NewInstarctionScreen> {
  // String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddInstractionCubit(),
      child: BlocConsumer<AddInstractionCubit, AddInstractionState>(
        listener: (context, state) {
          if (state is AddInstractionSuccessState) {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         const AllInsractions(), // استبدل بالشاشة التي تريد الانتقال إليها
            //   ),
            // );
            // Navigator.pushNamed(context, '/AllInsractions');
            message(context, 'تم إرسال الارشاد  بنجاح');
            FlutterToastr.show(
              ' تم إرسال الأرشاد  بنجاح ',
              context,
              position: FlutterToastr.bottom,
              duration: FlutterToastr.lengthLong,
              backgroundColor: backgroundColor,
              textStyle: const TextStyle(color: pColor),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('إضافة إرشاد')),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          context.read<AddInstractionCubit>().image != null
                              ? SizedBox(
                                  child: Image.memory(
                                    context.read<AddInstractionCubit>().image!,
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
                                          .read<AddInstractionCubit>()
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
                      key: context.read<AddInstractionCubit>().formkey,
                      child: Column(
                        children: [
                          TextFormFieldWidget(
                              yourController: context
                                  .read<AddInstractionCubit>()
                                  .adressController,
                              hintText: 'أدخل عنوان الارشاد  ',
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
                                .read<AddInstractionCubit>()
                                .detailsController,
                            keyboardType: TextInputType.multiline,
                            // style: const TextStyle(height: 0.2),
                            maxLines: null, // عدد الخطوط غير محدود
                            decoration: const InputDecoration(
                              labelText:
                                  ' أدخل تفاصيل الارشاد', // يمكنك تغيير النص هنا
                              hintText: 'ادخل  التفاصيل...',
                              border: OutlineInputBorder(),
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
                        state is AddInstractionLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ButtonWidget(
                                side: const BorderSide(
                                    style: BorderStyle.solid,
                                    color: Colors.green),
                                icon: Icons.telegram,
                                child: ' حفظ',
                                // widthFactor: 0.34,
                                onPressed: () {
                                  context.read<AddInstractionCubit>().image ==
                                          null
                                      ? message(context,
                                          ' أرفع صورة للتوضيح من فضلك قبل الارسال')
                                      : null;
                                  // احفظ البيانات باستخدام Cubit
                                  context
                                      .read<AddInstractionCubit>()
                                      .saveData(context);
                                },
                              ),
                        const SizedBox(
                          width: 20,
                        ),
                        ButtonWidget(
                          icon: Icons.delete,
                          colorIcon: Colors.red,
                          colorText: Colors.red,
                          side: const BorderSide(
                              style: BorderStyle.solid, color: Colors.red),
                          child: 'حذف ',
                          onPressed: () {
                            context.read<AddInstractionCubit>().clearForm();
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
