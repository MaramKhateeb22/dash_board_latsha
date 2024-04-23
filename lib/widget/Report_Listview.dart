import 'dart:convert';

import 'package:dash_board_mopidati/screens/Reports/Reports.dart';
import 'package:dash_board_mopidati/screens/Reports/cubit/cubit.dart';
import 'package:dash_board_mopidati/screens/Reports/cubit/state.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class ReportListView extends StatelessWidget {
  static Future<bool> sendFcmMessage(String title, String message) async {
    try {
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization":
            "key=eAtD39SiQpa9OrhflJgwu9:APA91bFGDw8wtQ8hUYgNyIiLmeyCKb9g7BUJJoG3xXHeHKnZQa2yZVBZogYAE1QSGsCJhDoiXkcUfFnsRvp-fxwKxfbsm14t3ioWYp3sdfKaH2ojIRD6xAvwSvBqqBgnpN6mzMP270O9",
      };
      var request = {
        "notification": {
          "title": title,
          "text": message,
          "sound": "default",
          "color": "#990000",
        },
        "priority": "high",
        // "to": "/topics/all",
        "to":
            "eAtD39SiQpa9OrhflJgwu9:APA91bFGDw8wtQ8hUYgNyIiLmeyCKb9g7BUJJoG3xXHeHKnZQa2yZVBZogYAE1QSGsCJhDoiXkcUfFnsRvp-fxwKxfbsm14t3ioWYp3sdfKaH2ojIRD6xAvwSvBqqBgnpN6mzMP270O9",
      };

      var client = Client();
      var response = await client.post(
        Uri.parse(url),
        headers: header,
        body: json.encode(request),
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  final AsyncSnapshot snap;
  final FutureBuilder Function(int index)
      futureBuilder; // توقيع الدالة التي تقبل int وترجع FutureBuilder.
  const ReportListView({
    super.key,
    required this.snap,
    required this.futureBuilder,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(),
      child: BlocConsumer<ReportCubit, ReportState>(
        listener: (context, state) {
          if (state is ReportRejectSuccessState) {
            message(context, 'تم رفض البلاغ بنجاح');
            sendFcmMessage(" عذرا تم الرفض ", "عذرا تم رفض البلاغ");
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    const ReportsScreen(), // استبدل بالشاشة التي تريد الانتقال إليها
              ),
            );
          }
          if (state is ReportAcceptScuccessState) {
            message(context, ' تم قبول البلاغ بنجاح');
            sendFcmMessage(
                "تهانينا، تم قبول البلاغ!", "تهانينا، تم قبول التقرير!");

            // FirebaseMessagingService()
            //     .sendNotification("تم القبول", "تهانينا، تم قبول التقرير!");
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    const ReportsScreen(), // استبدل بالشاشة التي تريد الانتقال إليها
              ),
            );
          }
        },
        builder: (context, state) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemCount: snap.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/Iteme Report',
                    arguments: [
                      snap.data!.docs[index]['Adress'],
                      snap.data!.docs[index]['Type Insect'],
                      snap.data!.docs[index]['imageLink'],
                      snap.data!.docs[index]['idUser'],
                      snap.data!.docs[index]['id'],
                      snap.data!.docs[index]['createdAt'],
                      snap.data!.docs[index]['location'],
                      snap.data!.docs[index]['statusReport'],
                    ],
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 5.0),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    color: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                '0'
                            ? pendingColor
                            : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                    '1'
                                ? acceptColor
                                : rejectColor, // لون الحدود
                        // width: 2.0, // عرض الحدود
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  child: futureBuilder(index),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.bug_report,
                                      color: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                              '0'
                                          ? pendingColor
                                          : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                                  '1'
                                              ? acceptColor
                                              : rejectColor,
                                    ),
                                    Text(
                                      " ${snap.data!.docs[index].data()["Type Insect"]}",
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                              '0'
                                          ? pendingColor
                                          : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                                  '1'
                                              ? acceptColor
                                              : rejectColor,
                                    ),
                                    SizedBox(
                                      // width: 230,
                                      child: Text(
                                        "${snap.data!.docs[index].data()["Adress"]}",
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                '${snap.data!.docs[index].data()["statusReport"]}' ==
                                        '0'
                                    ? const Row(
                                        children: [
                                          Icon(
                                            Icons.timelapse_outlined,
                                            color: pendingColor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'البلاغ قيد الانتظار',
                                            style: TextStyle(
                                                color: pendingColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                            '1'
                                        ? const Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'تم قبول  البلاغ',
                                                style: TextStyle(
                                                    color: acceptColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        : const Row(
                                            children: [
                                              Icon(
                                                Icons.clear,
                                                color: rejectColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'تم رفض البلاغ',
                                                style: TextStyle(
                                                    color: rejectColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                '${snap.data!.docs[index].data()["statusReport"]}' ==
                                        '0'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 27,
                                          ),
                                          ButtonWidget(
                                            colorIcon: Colors.green,
                                            colorText: Colors.green,
                                            // backgroundColors: Colors.grey,
                                            icon: Icons.check,
                                            onPressed: () {
                                              context
                                                  .read<ReportCubit>()
                                                  .acceptReport(
                                                      context,
                                                      snap.data!.docs[index]
                                                          .data()["id"]);
                                              print(snap.data!.docs[index]
                                                  .data()["id"]);
                                            },
                                            child: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                                    '0'
                                                ? 'قبول '
                                                : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                                        '1'
                                                    ? 'تم قبول البلاغ '
                                                    : null,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          ButtonWidget(
                                            colorIcon: Colors.red,
                                            icon: Icons.clear,
                                            colorText: Colors.red,
                                            onPressed: () {
                                              // onPressedReject;
                                              // setState(() {});
                                              context
                                                  .read<ReportCubit>()
                                                  .rejectReport(
                                                      context,
                                                      snap.data!.docs[index]
                                                          .data()["id"]);
                                              print(snap.data!.docs[index]
                                                  .data()["id"]);

                                              print('تم رفض البلاغ');
                                            },
                                            child: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                                    '0'
                                                ? 'رفض '
                                                : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                                        '1'
                                                    ? null
                                                    : ' تم رفض البلاغ',
                                          ),
                                        ],
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(0),
                                      ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                // clipBehavior: Clip.antiAlias,
                                width: 50,
                                height: 180,
                                color: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                        '0'
                                    ? pendingColor
                                    : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                            '1'
                                        ? acceptColor
                                        : rejectColor,
                                child: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                        '0'
                                    ? const Icon(
                                        Icons.timelapse_rounded,
                                        color: backgroundColor,
                                        size: 25,
                                      )
                                    : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                            '1'
                                        ? const Icon(
                                            Icons.done_all,
                                            color: backgroundColor,
                                            size: 25,
                                          )
                                        : const Icon(
                                            Icons.clear,
                                            color: backgroundColor,
                                            size: 25,
                                          ),
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
          );
        },
      ),
    );
  }
}
