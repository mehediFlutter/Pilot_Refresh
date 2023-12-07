import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/auth/login_screen.dart';

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         

          //primarySwatch: Colors.blue,
          // TextField(
          //             // scrollPadding: EdgeInsets.zero,
          //             decoration: InputDecoration(
          //               contentPadding: const EdgeInsets.only(top: 10),
          //               enabledBorder: UnderlineInputBorder(
          //                   borderSide: BorderSide(color: Colors.white)),
          //               prefixIcon: Padding(
          //                 padding: EdgeInsetsDirectional.only(start: 1.0,end: 30),
          //                 child: Icon(
          //                   Icons.lock_outline_sharp,
          //                   color: Colors.white,
          //                   size: 30,
          //                 ),
          //               ),
          //               suffixIcon: Icon(
          //                 Icons.remove_red_eye_outlined,
          //                 color: Colors.white,
          //                 size: 30,
          //               ),
          //               hintText: "Password",
          //               hintStyle:  Theme.of(context).textTheme.titleMedium,
          //             ),
          //           ),
          // inputDecorationTheme: InputDecorationTheme(
          //   labelStyle: TextStyle(
          //     color: Colors.blue,
          //     // Change this color to your desired label text color
          //   ),
          //   contentPadding: EdgeInsets.only(left: 20, top: 15),
          //   enabledBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(color: Colors.white),
          //   ),
          // ),

          textTheme: TextTheme(
            titleLarge: TextStyle(
                fontSize: 22,
                fontFamily: "Roboto",
                color: Color.fromARGB(255, 226, 221, 221),
                fontWeight: FontWeight.w500),
            titleMedium: TextStyle(
              fontSize: 16,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 194, 191, 191),
            ),
            titleSmall: TextStyle(
              fontSize: 17,
              fontFamily: "Roboto",
              color: Colors.grey,
            ),
            bodyMedium: TextStyle(
                fontSize: 16,
                fontFamily: "Roboto",
                //fontFamily: "AbhayaLibre",
                color: Color.fromARGB(255, 226, 221, 221),
                fontWeight: FontWeight.w100),
            bodySmall: TextStyle(
                height: 0,
                fontSize: 12,
                fontFamily: "Roboto",
                color: Color.fromARGB(255, 226, 221, 221),
                fontWeight: FontWeight.w100
                // color: Colors.grey,
                ),
          ),

          textSelectionTheme: TextSelectionThemeData(
            cursorColor:
                Colors.blue, // Change this color to your desired cursor color
          ),
        ),
        home: LoginScreen());
  }
}
