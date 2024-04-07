import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                  // color: Colors.blue,
                  ),
              child: Center(child: Text('القائمة')),
            ),
            // مجموعة البلاغات
            ExpansionTile(
              title: const Text("البلاغات"),
              children: <Widget>[
                ListTile(
                  title: const Text(" جميع البلاغات"),
                  onTap: () {
                    Navigator.pushNamed(context, '/reports');
                  },
                ),
                ListTile(
                  title: const Text("البلاغات المقبولة"),
                  onTap: () {
                    Navigator.pushNamed(context, '/Accept Reports');
                  },
                ),
                ListTile(
                  title: const Text("البلاغات المرفوضة"),
                  onTap: () {},
                ),
              ],
            ),
            // مجموعة الحجوزات
            ExpansionTile(
              title: const Text("الحجوزات"),
              children: <Widget>[
                ListTile(
                  title: const Text("الحجوزات المقبولة"),
                  onTap: () {
                    Navigator.pushNamed(context, '/Accept Reports');
                  },
                ),
                ListTile(
                  title: const Text("الحجوزات المرفوضة"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("الحجوزات المنجزة"),
                  onTap: () {
                    // كود الانتقال لشاشة الحجوزات المرفوضة
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("الارشادات"),
              children: <Widget>[
                ListTile(
                  title: const Text(" جميع الارشادات"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("إضافة إرشادات "),
                  onTap: () {},
                ),
              ],
            ),
            // يمكنك إضافة المزيد من العناصر هُنا
          ],
        ),
      ),

      // drawer: Drawer(
      //   child: ListView(children: <Widget>[
      //     DrawerHeader(
      //       padding: const EdgeInsets.all(20),
      //       decoration: const BoxDecoration(
      //         color: backgroundColor,
      //       ),
      //       child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             ListTile(
      //               leading: const Icon(Icons.home),
      //               title: const Text('الرئيسية'),
      //               onTap: () {
      //                 Navigator.pushNamed(context, '/home');
      //               },
      //             ),
      //             ListTile(
      //               leading: const Icon(Icons.timelapse_sharp),
      //               title: const Text('حجوزاتي'),
      //               onTap: () {},
      //             ),
      //           ]),
      //     ),
      //     ListTile(
      //       leading: const Icon(Icons.menu_outlined),
      //       title: const Text('كل البلاغات'),
      //       onTap: () {
      //         Navigator.pushNamed(context, '/reports');
      //       },
      //     ),
      //     ListTile(
      //       leading: const Icon(Icons.menu_outlined),
      //       title: const Text(' البلاغات المقبولة '),
      //       onTap: () {
      //         Navigator.pushNamed(context, '/Accept Reports');
      //       },
      //     ),
      //   ]),
      // ),
    );
  }
}
