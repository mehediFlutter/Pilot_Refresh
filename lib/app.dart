import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/splash_screen.dart';

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
          
          

       
         

//  inputDecorationTheme: InputDecorationTheme(
//          //  contentPadding: EdgeInsets.only(left: 50),
          
//           border: OutlineInputBorder(
            
            
//             borderSide: BorderSide(
//               color: Colors.grey
//             )
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.white
//             )
//           ),
          
//         ),

          textTheme: TextTheme(
            titleLarge: TextStyle(
                fontSize: 17.2,
                fontFamily: "Roboto",
                color: Color.fromARGB(255, 226, 221, 221),
                fontWeight: FontWeight.w500),
            titleMedium: TextStyle(
              fontSize: 10.5,
              fontFamily: "Roboto",
              //fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 0
            ),
            titleSmall: TextStyle(
              fontSize: 17,
              fontFamily: "Roboto",
              color: Colors.white,
               height: 0
            ),
            bodyMedium: TextStyle(
                fontSize: 13.5,
                fontFamily: "Roboto",
                //fontFamily: "AbhayaLibre",
                color: Colors.white,
                fontWeight: FontWeight.w100),
            bodySmall: TextStyle(
                height: 0,
                fontSize: 12,
                fontFamily: "Roboto",
                color: Color.fromARGB(255, 226, 221, 221),
                fontWeight: FontWeight.w100
                // color: Colors.grey,
                ),
            bodyLarge: TextStyle(
                height: 0,
                fontSize: 10,
                fontFamily: "Roboto",
                color: Color.fromARGB(255, 226, 221, 221),
                fontWeight: FontWeight.w100
                // color: Colors.grey,
                ),
          ),

        
        ),
        home: SplashScreen());
  }
}
