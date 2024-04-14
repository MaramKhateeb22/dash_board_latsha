import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/screens/Reports/functionReport.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class ItemeReverse extends StatefulWidget {
  const ItemeReverse({super.key});

  @override
  State<ItemeReverse> createState() => _ItemeReverseState();
}

class _ItemeReverseState extends State<ItemeReverse> {
  Future<String> getAddress(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    String adress = arguments[0];
    String typeInsect = arguments[1];
    String imageLink = arguments[2];
    String iduser = arguments[3];
    String id = arguments[4];
    Timestamp createdAt = arguments[5];
    String location = arguments[6];
    String space = arguments[7];
    int statusReverse = arguments[8];
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل  الحجز '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // width: double.infinity,
                  // height: 200,
                  child: Image.network(
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                      imageLink),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder<List<String>>(
                  future: displayUserNames(),
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
                            color: getStatusReverseColor(statusReverse),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(snapshot.data!.first),
                        ],
                      );
                    } else {
                      return const Text('لا يوجد بيانات للعرض');
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.bug_report,
                      color: getStatusReverseColor(statusReverse),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(typeInsect),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: getStatusReverseColor(statusReverse),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(adress),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: getStatusReverseColor(statusReverse),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(
                        createdAt.toDate(),
                      ),
                    ),
                    // Text('${createdAt.toDate().minute}'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timelapse_outlined,
                      color: getStatusReverseColor(statusReverse),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateFormat('HH:mm:ss').format(
                        createdAt.toDate(),
                      ),
                    ),
                    // Text('${createdAt.toDate().minute}'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.space_dashboard_outlined,
                      color: getStatusReverseColor(statusReverse),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('$space كم'),
                    // Text('${createdAt.toDate().minute}'),
                  ],
                ),
                statusReverse == 0
                    ? Row(
                        children: [
                          Icon(
                            Icons.timer_sharp,
                            color: getStatusReverseColor(statusReverse),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'الحجز قيد الانتظار',
                            style: TextStyle(
                              color: getStatusReverseColor(statusReverse),
                            ),
                          ),
                        ],
                      )
                    : statusReverse == 1
                        ? Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline_rounded,
                                color: getStatusReverseColor(statusReverse),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'تم قبول الحجز ',
                                style: TextStyle(
                                  color: getStatusReverseColor(statusReverse),
                                ),
                              ),
                            ],
                          )
                        : statusReverse == 2
                            ? Row(children: [
                                Icon(
                                  Icons.clear,
                                  color: getStatusReverseColor(statusReverse),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'تم رفض الحجز ',
                                  style: TextStyle(
                                    color: getStatusReverseColor(statusReverse),
                                  ),
                                ),
                              ])
                            : Row(children: [
                                Icon(
                                  Icons.done_all,
                                  color: getStatusReverseColor(statusReverse),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'تم  الرش ',
                                  style: TextStyle(
                                    color: getStatusReverseColor(statusReverse),
                                  ),
                                ),
                              ]),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ButtonWidget(
                    colorText: Colors.grey,
                    icon: Icons.add_location,
                    colorIcon: Colors.grey,
                    widthFactor: 0.65,
                    onPressed: () async {
                      double latitude = 37.094722;
                      double longitude = 36.203842;
                      String Adress = await getAddress(latitude, longitude);
                      print(Adress);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('العنوان من الخريطة'),
                            content: Text(Adress),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('حسناً'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      AlertDialog(
                        content: Text(Adress),
                      );
                    },
                    child: 'أظهر العنوان من الخريطة',
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}













// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dash_board_mopidati/screens/Reverse/function.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';

// class ItemeReverse extends StatefulWidget {
//   const ItemeReverse({super.key});

//   @override
//   State<ItemeReverse> createState() => _ItemeReverseState();
// }

// class _ItemeReverseState extends State<ItemeReverse> {
//   // _getCurrentLocation() {
//   //   Geolocator.getCurrentPosition(
//   //           desiredAccuracy: LocationAccuracy.best,
//   //           forceAndroidLocationManager: true)
//   //       .then((Position position) {
//   //     setState(() {
//   //       _currentPosition = position;
//   //     });
//   //   }).catchError((e) {
//   //     print(e);
//   //   });
//   // }

//   // Future<String> getAddress(double latitude, double longitude) async {
//   //   List<Placemark> placemarks =
//   //       await placemarkFromCoordinates(latitude, longitude);

//   //   Placemark place = placemarks[0];

//   //   String address =
//   //       '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

//   //   return address;
//   // }

//   Future<String> getAddress(double latitude, double longitude) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(latitude, longitude);
//     Placemark place = placemarks[0];
//     return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
//   }

//   // Positioned? _currentPosition;
//   @override
//   Widget build(BuildContext context) {
//     final List<dynamic> arguments =
//         ModalRoute.of(context)?.settings.arguments as List<dynamic>;

//     String adress = arguments[0];
//     String typeInsect = arguments[1];
//     String imageLink = arguments[2];
//     String iduser = arguments[3];
//     String id = arguments[4];
//     Timestamp createdAt = arguments[5];
//     String location = arguments[6];
//     String space = arguments[7];
//     int statusReverse = arguments[8];
//     String numberPhone = arguments[9];
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 // width: double.infinity,
//                 // height: 200,
//                 child: Image.network(
//                     width: double.infinity,
//                     height: 400,
//                     fit: BoxFit.cover,
//                     imageLink),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               FutureBuilder<List<String>>(
//                 future: displayUserNamesReverse(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else if (snapshot.hasData) {
//                     return Text('  اسم المستخدم: ${snapshot.data!.first}');
//                   } else {
//                     return const Text('No data available');
//                   }
//                 },
//               ),
//               Text(' نوع الحشرة: ' '$typeInsect'),
//               Text(' المساحة المقدرة للرش :' '$space  ' 'كم'),
//               Text('  رقم هاتف المستخدم  :' '$numberPhone  '),
//               Text('  العنوان المطلوب للرش:' '$adress  '),
//               Text('    تاريح الحجز:' '${createdAt.toDate()}  '),
//               statusReverse == 0
//                   ? const Icon(Icons.timer_sharp)
//                   : statusReverse == 1
//                       ? const Icon(Icons.check_circle_outline_rounded)
//                       : statusReverse == 2
//                           ? const Icon(Icons.clear)
//                           : const Row(
//                               children: [
//                                 Text('تم الرش   '),
//                                 Icon(
//                                   Icons.check_circle_outline_rounded,
//                                 ),
//                                 Icon(
//                                   Icons.check_circle_outline_rounded,
//                                 ),
//                               ],
//                             ),
//               TextButton(
//                 onPressed: () async {
//                   double latitude = 37.094722;
//                   double longitude = 36.203842;
//                   String Adress = await getAddress(latitude, longitude);
//                   print(Adress);
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text('العنوان من الخريطة'),
//                         content: Text(Adress),
//                         actions: <Widget>[
//                           TextButton(
//                             child: const Text('حسناً'),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                   AlertDialog(
//                     content: Text(Adress),
//                   );
//                 },
//                 child: const Row(children: [Text('أظهر العنوان من الخريطة')]),
//               ),
//             ]),
//       ),
//     );
//   }
// }