import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pilot_refresh/For_Customer_Care/screens/C_bottom_nav_base_screen.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class C_SplashScreen extends StatefulWidget {
  const C_SplashScreen({Key? key}) : super(key: key);

  @override
  State<C_SplashScreen> createState() => _C_SplashScreenState();
}

class _C_SplashScreenState extends State<C_SplashScreen> {
  late bool isDoubleScreenSelected;
  // late String mToken;
    late StreamSubscription subscription;
  var isDeviceConnected = false;
  var isAlertSet = false;


  @override
  void initState() {
    super.initState();
    loadSelectedScreenType();
  }
    @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> loadSelectedScreenType() async {

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      // Use ?? to provide a default value in case the preference is not set
      isDoubleScreenSelected = prefs.getBool('isDoubleScreenSelected') ?? true;
      print("Token is");
    });
    navigateToLogin();
  }

  late SharedPreferences preff;
  Future<void> navigateToLogin() async {
    preff = await SharedPreferences.getInstance();
    final login = await preff.getBool('isLogin');
    setState(() {});
    print("Is login");
    print(preff.getBool('isLogin'));

    Future.delayed(const Duration(seconds: 99999999)).then(
      (_) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => C_BottomNavBaseScreen(
                    isDoubleScreenSelected: isDoubleScreenSelected,
                    isSingleScreenSelected: !isDoubleScreenSelected,
                    isLogedIn: login,
                  )),
          (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/pilot_icon.png'),
          ),
          Center(
            child: Text(
              "PilotBazar.com",
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ),
          Column(
            children: [
              Center(
                child: Text(
                  " Do Business with us",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Specially Design for Customer Care",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 200,
              ),
              // Spacer(),
              SpinKitSpinningLines(
                color: Colors.black,
                size: 60.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
    showDialogBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text(
              'No Internet Connection',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )),
            content: Text("Please Check your internet connectivity", style: TextStyle(color: Colors.black87,fontSize: 15),),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    isAlertSet = false;
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      showDialogBox();
                     
                      isAlertSet = true;
                      setState(() {});
                    }
                  },
                  child: Center(child: Text("OK",style: TextStyle(fontSize: 17),)))
            ],
          );
        });
  }
}
