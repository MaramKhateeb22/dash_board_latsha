import 'package:dash_board_mopidati/screens/Reports/cubit/cubit.dart';
import 'package:dash_board_mopidati/screens/Reports/cubit/state.dart';
import 'package:dash_board_mopidati/screens/Reports/functionReport.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/Report_Listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
enum statusReport {
  depinding,
  accept,
  reject;
}

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(),
      child: BlocConsumer<ReportCubit, ReportState>(
        listener: (context, state) {
          if (state is ReportRejectSuccessState) {
            message(context, 'تم رفض البلاغ بنجاح');
            setState(() {});
          }
          if (state is ReportAcceptScuccessState) {
            setState(() {});
            message(context, ' تم قبول البلاغ بنجاح');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('كل البلاغات'),
            ),
            body: FutureBuilder(
                future: initData(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snap.hasError) return const Text("Something has error");
                  if (snap.data == null) {
                    print('empty data');
                    return const Text("لا يوجد بيانات للعرض ");
                  }
                  if (snap.data?.docs.isEmpty ?? false) {
                    print('empty data');
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.report,
                            size: 60,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(" لايوجد   بلاغات"),
                        ],
                      ),
                    );
                  }
                  return ReportListView(
                    snap: snap,
                    futureBuilder: (index) {
                      return FutureBuilder(
                        future: displayUserNames(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snap.data?.docs.isEmpty ?? false) {
                            print('empty data');
                            return const Text(" لا يوجد بيانات للعرض ");
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                          '0'
                                      ? pendingColor
                                      : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                              '1'
                                          ? acceptColor
                                          : rejectColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('${snapshot.data![index]}'),
                              ],
                            );
                          } else {
                            return const Text('No data available');
                          }
                        },
                      );
                    },
                  );
                  // return ReportListView(
                  //     snap: snap, futureName: displayUserNames());
                  // return ListView.builder(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   itemCount: snap.data?.docs.length ?? 0,
                  //   itemBuilder: (context, index) {
                  //     return InkWell(
                  //       onTap: () {
                  //         Navigator.pushNamed(context, '/Iteme Report',
                  //             arguments: [
                  //               snap.data!.docs[index]['Adress'],
                  //               snap.data!.docs[index]['Type Insect'],
                  //               snap.data!.docs[index]['imageLink'],
                  //               snap.data!.docs[index]['idUser'],
                  //               snap.data!.docs[index]['id'],
                  //               snap.data!.docs[index]['createdAt'],
                  //               snap.data!.docs[index]['location'],
                  //               snap.data!.docs[index]['statusReport'],
                  //             ]);
                  //       },
                  //       child: Card(
                  //         margin: const EdgeInsets.symmetric(vertical: 4),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     FutureBuilder<List<String>>(
                  //                       future: displayUserNames(),
                  //                       builder: (context, snapshot) {
                  //                         if (snapshot.connectionState ==
                  //                             ConnectionState.waiting) {
                  //                           return const CircularProgressIndicator();
                  //                         } else if (snapshot.hasError) {
                  //                           return Text(
                  //                               'Error: ${snapshot.error}');
                  //                         } else if (snapshot.hasData) {
                  //                           return Text(
                  //                               'اسم المستخدم: ${snapshot.data![index]}');
                  //                         } else {
                  //                           return const Text(
                  //                               'No data available');
                  //                         }
                  //                       },
                  //                     ),
                  //                     Text(
                  //                       "نوع الحشرة: ${snap.data!.docs[index].data()["Type Insect"]}",
                  //                       // style: Theme.of(context).textTheme.titleMedium,
                  //                     ),
                  //                     Text(
                  //                       "عنوان المكان الذي نتنشر فيه الحشرة \n: ${snap.data!.docs[index].data()["Adress"]}",
                  //                     ),
                  //                     '${snap.data!.docs[index].data()["statusReport"]}' ==
                  //                             '0'
                  //                         ? const Row(
                  //                             children: [
                  //                               Icon(Icons.timelapse_outlined),
                  //                               Text('البلاغ قيد الانتظار')
                  //                             ],
                  //                           )
                  //                         : '${snap.data!.docs[index].data()["statusReport"]}' ==
                  //                                 '1'
                  //                             ? const Row(
                  //                                 children: [
                  //                                   Text('تم قبول  البلاغ'),
                  //                                   Icon(Icons
                  //                                       .check_circle_outline_rounded),
                  //                                 ],
                  //                               )
                  //                             : const Row(
                  //                                 children: [
                  //                                   Text('تم رفض البلاغ'),
                  //                                   Icon(Icons.clear),
                  //                                 ],
                  //                               ),
                  // Row(
                  //   children: [
                  //     MaterialButton(
                  //       color: backgroundColor,
                  //       elevation: 2,
                  //       textColor: pColor,
                  //       onPressed: () {
                  //         // setState(() {});
                  //         context
                  //             .read<ReportCubit>()
                  //             .acceptReport(
                  //                 context,
                  //                 snap.data!.docs[index]
                  //                     .data()["id"]);
                  //         print(snap.data!.docs[index]
                  //             .data()["id"]);
                  //       },
                  //       child: state
                  //               is ReportAcceptLoadingState
                  //           ? const Center(
                  //               child:
                  //                   CircularProgressIndicator(),
                  //             )
                  //           : '${snap.data!.docs[index].data()["statusReport"]}' ==
                  //                   '0'
                  //               ? const Text('قبول البلاغ')
                  //               : '${snap.data!.docs[index].data()["statusReport"]}' ==
                  //                       '1'
                  //                   ? const Text(
                  //                       'تم قبول البلاغ ')
                  //                   : null,
                  //     ),
                  //     const SizedBox(
                  //       width: 15,
                  //     ),
                  //     state is ReportRejectLoadingState
                  //         ? const Center(
                  //             child:
                  //                 CircularProgressIndicator(),
                  //           )
                  //         : MaterialButton(
                  //             color: backgroundColor,
                  //             textColor: sColor,
                  //             onPressed: () {
                  //               // setState(() {});
                  //               context
                  //                   .read<ReportCubit>()
                  //                   .rejectReport(
                  //                       context,
                  //                       snap.data!
                  //                           .docs[index]
                  //                           .data()["id"]);
                  //               print(snap.data!.docs[index]
                  //                   .data()["id"]);

                  //               print('تم رفض البلاغ');
                  //             },
                  //             child: '${snap.data!.docs[index].data()["statusReport"]}' ==
                  //                     '0'
                  //                 ? const Text('رفض البلاغ')
                  //                 : '${snap.data!.docs[index].data()["statusReport"]}' ==
                  //                         '1'
                  //                     ? null
                  //                     : const Text(
                  //                         ' تم رفض البلاغ'),
                  //           ),
                  //   ],
                  // )
                  // ]),
                  // ],
                  // ),
                  // ),
                  //       ),
                  //     );
                  //   },
                  // );
                }),
          );
        },
      ),
    );
  }
}
