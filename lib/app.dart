import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/home_vehicle.dart';
import 'package:pilot_refresh/screens/login_screen.dart';

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
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.only(left: 20, top: 15),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),

          textTheme: TextTheme(
              titleMedium: TextStyle(
                fontSize: 20,
                fontFamily: "AbhayaLibre",
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              titleLarge: TextStyle(
                fontSize: 25,
                fontFamily: "AbhayaLibre",
                color: Colors.white,
                fontWeight: FontWeight.w500
              ),
              titleSmall: TextStyle(
                fontSize: 17,
                fontFamily: "AbhayaLibre",
                color: Colors.grey,
              ),
              bodySmall: TextStyle(
                height: 0,
                fontSize: 10,
                fontFamily: "AbhayaLibre",
                // color: Colors.grey,
              )),
        ),
        home: LoginScreen());
  }
}
