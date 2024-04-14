import 'package:dash_board_mopidati/screens/Reverse/AcceptReverse.dart';
import 'package:dash_board_mopidati/screens/Reverse/DoneReverese.dart';
import 'package:dash_board_mopidati/screens/Reverse/RejectsReverse.dart';
import 'package:dash_board_mopidati/screens/Reverse/cubit/cubit.dart';
import 'package:dash_board_mopidati/screens/Reverse/cubit/state.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReverseListView extends StatelessWidget {
  final AsyncSnapshot snap;
  // final AsyncSnapshot? snapshot;
  // Function(int index, AsyncSnapshot snapshot)? onPressedAccept;
  // Function(int index, AsyncSnapshot snapshot)? onPressedReject;

  // FutureBuilder futureBuilder;
  final FutureBuilder Function(int index)
      futureBuilder; // توقيع الدالة التي تقبل int وترجع FutureBuilder.
  // final int index; // ال
  const ReverseListView({
    // this.snapshot,
    super.key,
    required this.snap,
    required this.futureBuilder,
    // this.onPressedAccept,
    // this.onPressedReject,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReverseCubit(),
      child: BlocConsumer<ReverseCubit, ReverseState>(
        listener: (context, state) {
          if (state is ReverseRejectSuccessState) {
            message(context, 'تم رفض الحجز بنجاح');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    const RejectReverseScreen(), // استبدل بالشاشة التي تريد الانتقال إليها
              ),
            );
          }
          if (state is ReverseAcceptScuccessState) {
            message(context, ' تم قبول الحجز بنجاح');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    const AcceptReverseScreen(), // استبدل بالشاشة التي تريد الانتقال إليها
              ),
            );
          }

          if (state is ReverseDoneSuccessState) {
            message(context, ' تم الرش ');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    const DoneReverseScreen(), // استبدل بالشاشة التي تريد الانتقال إليها
              ),
            );
          }
        },
        builder: (context, state) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: snap.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/Iteme Reverse', arguments: [
                    snap.data!.docs[index]['Adress'],
                    snap.data!.docs[index]['Type Insect'],
                    snap.data!.docs[index]['imageLink'],
                    snap.data!.docs[index]['idUser'],
                    snap.data!.docs[index]['id'],
                    snap.data!.docs[index]['createdAt'],
                    snap.data!.docs[index]['location'],
                    snap.data!.docs[index]['space'],
                    snap.data!.docs[index]['statusReverse'],
                  ]);
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
                        color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                '0'
                            ? pendingColor
                            : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                    '1'
                                ? acceptColor
                                : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                        '2'
                                    ? rejectColor
                                    : doneColor, // لون الحدود
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
                                Row(
                                  children: [
                                    Icon(Icons.bug_report,
                                        color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                '0'
                                            ? pendingColor
                                            : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                    '1'
                                                ? acceptColor
                                                : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                        '2'
                                                    ? rejectColor
                                                    : doneColor),
                                    Text(
                                      "${snap.data!.docs[index].data()["Type Insect"]}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                '0'
                                            ? pendingColor
                                            : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                    '1'
                                                ? acceptColor
                                                : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                        '2'
                                                    ? rejectColor
                                                    : doneColor),
                                    SizedBox(
                                      width: 230,
                                      child: Text(
                                        "${snap.data!.docs[index].data()["Adress"]}",
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                '${snap.data!.docs[index].data()["statusReverse"]}' ==
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
                                            'الحجز قيد الانتظار',
                                            style: TextStyle(
                                                color: pendingColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                            '1'
                                        ? const Row(
                                            children: [
                                              Icon(
                                                color: acceptColor,
                                                Icons
                                                    .check_circle_outline_rounded,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'تم قبول  الحجز',
                                                style: TextStyle(
                                                    color: acceptColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                '2'
                                            ? const Row(
                                                children: [
                                                  Icon(
                                                    color: rejectColor,
                                                    Icons.clear,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'تم رفض  الحجز',
                                                    style: TextStyle(
                                                        color: rejectColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            : const Row(
                                                children: [
                                                  Icon(
                                                    Icons.done_all,
                                                    color: doneColor,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'تم الرش',
                                                    style: TextStyle(
                                                        color: doneColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                '${snap.data!.docs[index].data()["statusReverse"]}' ==
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
                                              // onPressedAccept;

                                              // setState(() {});
                                              context
                                                  .read<ReverseCubit>()
                                                  .acceptReverse(
                                                      context,
                                                      snap.data!.docs[index]
                                                          .data()["id"]);
                                              print(snap.data!.docs[index]
                                                  .data()["id"]);
                                            },
                                            child: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                    '0'
                                                ? 'قبول '
                                                : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                        '1'
                                                    ? 'تم قبول الحجز '
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
                                                  .read<ReverseCubit>()
                                                  .rejectReveres(
                                                      context,
                                                      snap.data!.docs[index]
                                                          .data()["id"]);
                                              print(snap.data!.docs[index]
                                                  .data()["id"]);

                                              print('تم رفض الحجز');
                                            },
                                            child: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                    '0'
                                                ? 'رفض '
                                                : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                        '1'
                                                    ? null
                                                    : ' تم رفض الحجز',
                                          ),
                                        ],
                                      )
                                    : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                            '1'
                                        ? ButtonWidget(
                                            child: 'تم الرش؟',
                                            icon: Icons.done_all,
                                            onPressed: () {
                                              context
                                                  .read<ReverseCubit>()
                                                  .DoneReveres(
                                                      context,
                                                      snap.data!.docs[index]
                                                          .data()["id"]);
                                              print(snap.data!.docs[index]
                                                  .data()["id"]);

                                              print('تم  الرش');
                                            })
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
                                width: 70,
                                height: 200,
                                color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                        '0'
                                    ? pendingColor
                                    : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                            '1'
                                        ? acceptColor
                                        : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                '2'
                                            ? rejectColor
                                            : doneColor,
                                child: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                        '0'
                                    ? const Icon(
                                        Icons.timelapse_rounded,
                                        color: backgroundColor,
                                        size: 25,
                                      )
                                    : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                            '1'
                                        ? const Icon(
                                            Icons.check,
                                            color: backgroundColor,
                                            size: 25,
                                          )
                                        : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                '2'
                                            ? const Icon(
                                                Icons.clear,
                                                color: backgroundColor,
                                                size: 25,
                                              )
                                            : const Icon(
                                                Icons.done_all,
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
