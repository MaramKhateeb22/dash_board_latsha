import 'package:dash_board_mopidati/screens/Reports/cubit/cubit.dart';
import 'package:dash_board_mopidati/screens/Reports/cubit/state.dart';
import 'package:dash_board_mopidati/screens/Reports/functionReport.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/Report_Listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingReportScreen extends StatefulWidget {
  const PendingReportScreen({super.key});

  @override
  State<PendingReportScreen> createState() => _PendingReportScreenState();
}

class _PendingReportScreenState extends State<PendingReportScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(),
      child: BlocConsumer<ReportCubit, ReportState>(
        listener: (context, state) {
          if (state is ReportRejectSuccessState) {
            message(context, 'تم رفض البلاغ بنجاح');
          }
          if (state is ReportAcceptScuccessState) {
            message(context, ' تم قبول البلاغ بنجاح');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(' البلاغات المنتظرة'),
            ),
            body: FutureBuilder(
              future: initDataPending(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) return const Text("Something has error");
                if (snap.data == null) {
                  return const Center(
                      child: Text('لايوجد بلاغات قيد الانتظار'));
                }
                return ReportListView(
                  snap: snap,
                  // onPressedAccept: (index, snapshot) {
                  //   setState(() {});
                  //   context.read<ReportCubit>().acceptReport(
                  //       context, snapshot.data!.docs[index].data()["id"]);
                  //   return null;
                  // },
                  // onPressedReject: (index, snapshot) {
                  //   setState(() {});
                  //   context.read<ReportCubit>().rejectReport(
                  //       context, snapshot.data!.docs[index].data()["id"]);
                  //   return null;
                  // },
                  futureBuilder: (index) {
                    return FutureBuilder(
                      future: displayUserNamesPending(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.orange,
                              ),
                              Text(' ${snapshot.data![index]}'),
                            ],
                          );
                        } else {
                          return const Text('No data available');
                        }
                      },
                    );
                  },
                  // FutureBuilder(
                  //   future: displayUserNamesPending(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const CircularProgressIndicator();
                  //     } else if (snapshot.hasError) {
                  //       return Text('Error: ${snapshot.error}');
                  //     } else if (snapshot.hasData) {
                  //       return Text('اسم المستخدم: ${snapshot.data![]}');
                  //     } else {
                  //       return const Text('No data available');
                  //     }
                  //   },
                  // ),
                );
                // return ListView.builder(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   itemCount: snap.data?.docs.length ?? 0,
                //   itemBuilder: (context, index) {
                //     return InkWell(
                //       onTap: () {
                //         Navigator.pushNamed(context, '/Iteme Report', arguments: [
                //           snap.data!.docs[index]['Adress'],
                //           snap.data!.docs[index]['Type Insect'],
                //           snap.data!.docs[index]['imageLink'],
                //           snap.data!.docs[index]['idUser'],
                //           snap.data!.docs[index]['id'],
                //           snap.data!.docs[index]['createdAt'],
                //           snap.data!.docs[index]['location'],
                //           snap.data!.docs[index]['statusReport'],
                //         ]);
                //       },
                //       child: Card(
                //         margin: const EdgeInsets.symmetric(vertical: 4),
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     FutureBuilder<List<String>>(
                //                       future: displayUserNamesPending(),
                //                       builder: (context, snapshot) {
                //                         if (snapshot.connectionState ==
                //                             ConnectionState.waiting) {
                //                           return const CircularProgressIndicator();
                //                         } else if (snapshot.hasError) {
                //                           return Text('Error: ${snapshot.error}');
                //                         } else if (snapshot.hasData) {
                //                           return Text(
                //                               'اسم المستخدم: ${snapshot.data![index]}');
                //                         } else {
                //                           return const Text('No data available');
                //                         }
                //                       },
                //                     ),
                //                     // Container(
                //                     //   width: 200,
                //                     //   height: 200,
                //                     //   decoration: BoxDecoration(
                //                     //       borderRadius: BorderRadius.circular(15)),
                //                     //   child: Image.network(
                //                     //       // width: 200,
                //                     //       // height: 150,
                //                     //       // fit: BoxFit.cover,
                //                     //       '${snap.data!.docs[index].data()["imageLink"]}'),
                //                     // ),
                //                     Text(
                //                       "نوع الحشرة: ${snap.data!.docs[index].data()["Type Insect"]}",
                //                       // style: Theme.of(context).textTheme.titleMedium,
                //                     ),
                //                     Text(
                //                       "عنوان المكان الذي نتنشر فيه الحشرة \n: ${snap.data!.docs[index].data()["Adress"]}",
                //                       // style: Theme.of(context).textTheme.titleMedium,
                //                     ),
                //                     const Row(
                //                       children: [
                //                         Icon(Icons.timelapse_outlined),
                //                         Text('في انتظار قبول البلاغ'),
                //                       ],
                //                     ),
                //                     // Row(
                //                     //   children: [
                //                     //     MaterialButton(
                //                     //       color: backgroundColor,
                //                     //       elevation: 2,
                //                     //       textColor: pColor,
                //                     //       onPressed: () {
                //                     //         setState(() {});
                //                     //         acceptReport(
                //                     //             context,
                //                     //             snap.data!.docs[index]
                //                     //                 .data()["id"]);
                //                     //         print(snap.data!.docs[index]
                //                     //             .data()["id"]);
                //                     //       },
                //                     //       child: '${snap.data!.docs[index].data()["statusReport"]}' ==
                //                     //               '0'
                //                     //           ? const Text('قبول البلاغ')
                //                     //           : '${snap.data!.docs[index].data()["statusReport"]}' ==
                //                     //                   '1'
                //                     //               ? const Text('تم قبول البلاغ ')
                //                     //               : null,
                //                     //     ),
                //                     //     const SizedBox(
                //                     //       width: 15,
                //                     //     ),
                //                     //     MaterialButton(
                //                     //       color: backgroundColor,
                //                     //       textColor: pColor,
                //                     //       onPressed: () {
                //                     //         setState(() {
                //                     //           rejectReport(
                //                     //               context,
                //                     //               snap.data!.docs[index]
                //                     //                   .data()["id"]);
                //                     //           print(snap.data!.docs[index]
                //                     //               .data()["id"]);
                //                     //         });
                //                     //         print('تم رفض البلاغ');
                //                     //       },
                //                     //       child: '${snap.data!.docs[index].data()["statusReport"]}' ==
                //                     //               '0'
                //                     //           ? const Text('رفض البلاغ')
                //                     //           : '${snap.data!.docs[index].data()["statusReport"]}' ==
                //                     //                   '1'
                //                     //               ? null
                //                     //               : const Text(' تم رفض البلاغ'),
                //                     //     ),
                //                     //   ],
                //                     // )
                //                   ]),
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
