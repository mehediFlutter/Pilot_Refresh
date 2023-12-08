import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/auth/new_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToLogin();
  }

  Future<void> navigateToLogin() async {
    //final bool isLoggedIn = await AuthUtility.checkIfUserLoggedIn();

    Future.delayed(const Duration(seconds: 2)).then((_) =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NewLoginScreen() /*isLoggedIn? const BottomNavBaseScreen(): const LoginScreen()*/),
            (route) => false));
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
          Center(child: Text("PilotBazar.con",style: TextStyle(color: Colors.black87, fontSize: 20),),),
          Center(
            child: Text(
              " Do Business with Us",
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
