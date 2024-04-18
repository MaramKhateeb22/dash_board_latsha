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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/syria-removebg-preview.png'),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: const Text(
                'هل من جديد؟!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                  // color: Colors.blue,
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: const Icon(Icons.people_alt_sharp),
                    title: const Text("عملاؤنا"),
                    onTap: () {
                      Navigator.pushNamed(context, '/AllUsers');
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.price_change),
                  //   title: const Text(" إضافة السعر "),
                  //   onTap: () {
                  //     Navigator.pushNamed(context, '/add_insects');
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.price_change),
                    title: const Text(" كل الاسعار  "),
                    onTap: () {
                      Navigator.pushNamed(context, '/all_price');
                    },
                  ),
                ],
              ),
            ),
            // مجموعة البلاغات
            ExpansionTile(
              leading: const Icon(Icons.menu),
              initiallyExpanded: true,
              title: const Text("البلاغات"),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text(" جميع البلاغات"),
                  onTap: () {
                    Navigator.pushNamed(context, '/reports');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.timelapse),
                  title: const Text(" البلاغات  المنتظرة"),
                  onTap: () {
                    Navigator.pushNamed(context, '/Pending Reports');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.done),
                  title: const Text("البلاغات المقبولة"),
                  onTap: () {
                    Navigator.pushNamed(context, '/Accept Reports');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.clear),
                  title: const Text("البلاغات المرفوضة"),
                  onTap: () {
                    Navigator.pushNamed(context, '/Reject Reports');
                  },
                ),
              ],
            ),
            // مجموعة الحجوزات
            ExpansionTile(
              initiallyExpanded: true,
              leading: const Icon(Icons.timelapse_sharp),
              title: const Text("الحجوزات"),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.menu),
                  title: const Text(" جميع الحجوزات "),
                  onTap: () {
                    Navigator.pushNamed(context, '/reverse');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.timelapse_sharp),
                  title: const Text("الحجوزات المنتظرة "),
                  onTap: () {
                    Navigator.pushNamed(context, '/pending Reverse');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.check),
                  title: const Text("الحجوزات المقبولة"),
                  onTap: () {
                    Navigator.pushNamed(context, '/Accept Reverse');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.clear),
                  title: const Text("الحجوزات المرفوضة"),
                  onTap: () {
                    Navigator.pushNamed(context, '/Reject Reverse');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.done_all),
                  title: const Text("الحجوزات المنجزة"),
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/Done Reverse'); // كود الانتقال لشاشة الحجوزات المرفوضة
                  },
                ),
              ],
            ),

            ExpansionTile(
              textColor: Colors.grey,
              iconColor: Colors.grey,
              initiallyExpanded: true,
              title: const Text("الارشادات"),
              leading: const Icon(Icons.edit_document),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.edit_document),
                  title: const Text(" جميع الارشادات"),
                  onTap: () {
                    Navigator.pushNamed(context, '/AllInsractions');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard_customize),
                  title: const Text("إضافة إرشادات "),
                  onTap: () {
                    Navigator.pushNamed(context, '/NewInstarctionScreen');
                  },
                ),
              ],
            ),
            // يمكنك إضافة المزيد من العناصر هُنا
          ],
        ),
      ),
    );
  }
}
