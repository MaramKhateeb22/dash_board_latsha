import 'package:dash_board_mopidati/screens/Reverse/function.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/Reverse_Listview.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class ReversesScreen extends StatefulWidget {
  const ReversesScreen({super.key});
  @override
  State<ReversesScreen> createState() => _ReversesScreenState();
}

enum statusReverse {
  depinding,
  accept,
  reject,
  done;
}

class _ReversesScreenState extends State<ReversesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جميع  الحجوزات'),
      ),
      body: FutureBuilder(
          future: initDataReverse(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) return const Text("Something has error");
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
                    Text(" لايوجد حجوزات  "),
                  ],
                ),
              );
            }
            if (snap.data == null) {
              print('empty data');
              return const Text("Empty data");
            }
            if (snap.data?.docs.isEmpty ?? false) {
              print('empty data');
              return const Text(" لا يوجد بيانات للعرض ");
            }
            return ReverseListView(
             
              snap: snap,
              futureBuilder: (index) {
                return FutureBuilder(
                  future: displayUserNamesReverse(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                    '0'
                                ? pendingColor
                                : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                        '1'
                                    ? acceptColor
                                    : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                            2
                                        ? rejectColor
                                        : doneColor,
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
            // return ListView.builder(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   itemCount: snap.data?.docs.length ?? 0,
            //   itemBuilder: (context, index) {
            //     return InkWell(
            //       onTap: () {
            //         Navigator.pushNamed(context, '/Iteme Reverse', arguments: [
            //           snap.data!.docs[index]['Adress'],
            //           snap.data!.docs[index]['Type Insect'],
            //           snap.data!.docs[index]['imageLink'],
            //           snap.data!.docs[index]['idUser'],
            //           snap.data!.docs[index]['id'],
            //           snap.data!.docs[index]['createdAt'],
            //           snap.data!.docs[index]['location'],
            //           snap.data!.docs[index]['space'],
            //           snap.data!.docs[index]['statusReverse'],
            //           snap.data!.docs[index]['numberPhone'],
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
            //                       future: displayUserNamesReverse(),
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

            //                     Text(
            //                       "نوع الحشرة: ${snap.data!.docs[index].data()["Type Insect"]}",
            //                       // style: Theme.of(context).textTheme.titleMedium,
            //                     ),
            //                     Text(
            //                       "عنوان المكان الذي نتنشر فيه الحشرة \n: ${snap.data!.docs[index].data()["Adress"]}",
            //                     ),
            //                     '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                             '0'
            //                         ? const Row(
            //                             children: [
            //                               Icon(Icons.timelapse_outlined),
            //                               Text('الحجز قيد الانتظار'),
            //                             ],
            //                           )
            //                         : '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                                 '1'
            //                             ? const Row(
            //                                 children: [
            //                                   Icon(Icons
            //                                       .check_circle_outline_rounded),
            //                                   Text('تم قبول الحجز'),
            //                                 ],
            //                               )
            //                             : '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                                     '3'
            //                                 ? const Row(
            //                                     children: [
            //                                       Icon(Icons
            //                                           .check_circle_outline_rounded),
            //                                       Icon(Icons
            //                                           .check_circle_outline_rounded),
            //                                       Text('تم الرش ✔'),
            //                                     ],
            //                                   )
            //                                 : const Row(
            //                                     children: [
            //                                       Icon(Icons.clear),
            //                                       Text('تم رفض الحجز'),
            //                                     ],
            //                                   ),

            //                     //buttons

            //                     Row(
            //                       children: [
            //                         MaterialButton(
            //                           color: backgroundColor,
            //                           elevation: 2,
            //                           textColor: pColor,
            //                           onPressed: () {
            //                             setState(() {});
            //                             if ('${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                                 '0') {
            //                               acceptReverse(
            //                                   context,
            //                                   snap.data!.docs[index]
            //                                       .data()["id"]);
            //                             }
            //                             if ('${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                                 '1') {
            //                               DoneReveres(
            //                                   context,
            //                                   snap.data!.docs[index]
            //                                       .data()["id"]);
            //                             }

            //                             print(snap.data!.docs[index]
            //                                 .data()["id"]);
            //                           },
            //                           child: '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                                   '0'
            //                               ? const Text('قبول الحجز؟')
            //                               : '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                                       '1'
            //                                   ? const Text(' ✔تم قبول الحجز '
            //                                       'تم الرش؟')
            //                                   : '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                                           '3'
            //                                       ? const Text('تم الرش ✔')
            //                                       : const SizedBox.shrink(),
            //                         ),
            //                         const SizedBox(
            //                           width: 15,
            //                         ),
            //                         MaterialButton(
            //                           color: backgroundColor,
            //                           textColor: pColor,
            //                           onPressed: () {
            //                             setState(() {});
            //                             rejectReveres(
            //                                 context,
            //                                 snap.data!.docs[index]
            //                                     .data()["id"]);
            //                             print(snap.data!.docs[index]
            //                                 .data()["id"]);

            //                             print('تم رفض الحجز');
            //                           },
            //                           child: '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                                   '0'
            //                               ? const Text('رفض الحجز؟')
            //                               : '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                                       '2'
            //                                   ? const Text('✔ تم رفض الحجز')
            //                                   : const SizedBox.shrink(),
            //                         ),
            //                         // const SizedBox(
            //                         //   width: 15,
            //                         // ),
            //                         // MaterialButton(
            //                         //   color: backgroundColor,
            //                         //   textColor: pColor,
            //                         //   onPressed: () {
            //                         //     setState(() {});
            //                         //     DoneReveres(context,
            //                         //         snap.data!.docs[index].data()["id"]);
            //                         //   },
            //                         //   child: '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                         //           '0'
            //                         //       ? const SizedBox.shrink()
            //                         //       : '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                         //               '1'
            //                         //           ? const Text('تم إنجاز الرش؟')
            //                         //           : '${snap.data!.docs[index].data()["statusReverse"]}' ==
            //                         //                   '2'
            //                         //               ? null
            //                         //               : const Text(' تم الرش✔ '),
            //                         // ),
            //                       ],
            //                     ),
            //                   ]),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );
          }),
    );
  }
}
