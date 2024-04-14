import 'package:dash_board_mopidati/screens/Instructions/AllInstraction.dart';
import 'package:dash_board_mopidati/screens/Instructions/NewInstraction.dart';
import 'package:dash_board_mopidati/screens/Reports/AcceptReports.dart';
import 'package:dash_board_mopidati/screens/Reports/ItemReport.dart';
import 'package:dash_board_mopidati/screens/Reports/RejectsReports.dart';
import 'package:dash_board_mopidati/screens/Reports/Reports.dart';
import 'package:dash_board_mopidati/screens/Reports/pendingReports.dart';
import 'package:dash_board_mopidati/screens/Reverse/AcceptReverse.dart';
import 'package:dash_board_mopidati/screens/Reverse/DoneReverese.dart';
import 'package:dash_board_mopidati/screens/Reverse/ItemRevers.dart';
import 'package:dash_board_mopidati/screens/Reverse/RejectsReverse.dart';
import 'package:dash_board_mopidati/screens/Reverse/Reverse.dart';
import 'package:dash_board_mopidati/screens/Reverse/pendingReverse.dart';
import 'package:dash_board_mopidati/screens/users/AllUsers.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale("ar", "AE"),
      title: 'Flutter Demo',
      theme: ThemeData(
        cardTheme: CardTheme(
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          // clipBehavior: Clip.antiAlias,
          color: cardbackground,
          elevation: 10,
          margin: const EdgeInsets.all(4),
        ),
        cardColor: cardbackground,
        listTileTheme: const ListTileThemeData(iconColor: pColor),
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: backgroundColor,
        //textbutton
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            // foregroundColor: pColor,
            textStyle: const TextStyle(
              fontSize: 17, // حجم النص
            ),
          ),
        ),
        //text
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            // color: pColor,
            fontSize: 22,
            // fontWeight: FontWeight.bold
          ),
          bodyLarge: TextStyle(color: pColor),
          bodySmall: TextStyle(color: pColor),
        ),

        //appbar theme
        appBarTheme: const AppBarTheme(
          color: pColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.white24,
          ),
        ),
        //icon theme
        iconTheme: const IconThemeData(color: pColor),
        //inuprtdecoration theme
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            // تعريف حاشية الحقل المفعل
            borderSide: BorderSide(color: pColor),
            // تعيين لون الحاشية
            gapPadding: 2,
          ),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: sColor)),
        ),
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        //Reports
        '/reports': (context) => const ReportsScreen(),
        // '/reports': (context) => UsersList(),
        '/Accept Reports': (context) => const AcceptReportScreen(),
        '/Reject Reports': (context) => const RejectReportScreen(),
        '/Pending Reports': (context) => const PendingReportScreen(),
        '/Iteme Report': (context) => const ItemeReport(),

        //Reverse
        '/reverse': (context) => const ReversesScreen(),
        '/Accept Reverse': (context) => const AcceptReverseScreen(),
        '/Reject Reverse': (context) => const RejectReverseScreen(),
        '/pending Reverse': (context) => const PendingReverseScreen(),
        '/Done Reverse': (context) => const DoneReverseScreen(),
        '/Iteme Reverse': (context) => const ItemeReverse(),

        //instraction
        '/NewInstarctionScreen': (context) => const NewInstarctionScreen(),
        '/AllInsractions': (context) => const AllInsractions(),
        '/AllUsers': (context) => const AllUsers(),
      },
    );
  }
}
