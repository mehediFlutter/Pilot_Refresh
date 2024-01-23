import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/new_login_screen.dart';
import 'package:pilot_refresh/widget/bottom_nav_base-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isDoubleScreenSelected;

  @override
  void initState() {
    super.initState();
    loadSelectedScreenType();
  }

  // Function to load the saved value from shared preferences
  Future<void> loadSelectedScreenType() async {
    // Load the selected screen type during the app startup
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Use ?? to provide a default value in case the preference is not set
      isDoubleScreenSelected =
          prefs.getBool('isDoubleScreenSelected') ?? true;
    });
    navigateToLogin();
  }

  Future<void> navigateToLogin() async {
    final bool isLoggedIn = await AuthUtility.checkIfUserLoggedIn();

    Future.delayed(const Duration(seconds: 2)).then((_) =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => isLoggedIn
                    ? BottomNavBaseScreen(
                        isDoubleScreenSelected: isDoubleScreenSelected,
                        isSingleScreenSelected: !isDoubleScreenSelected,
                      )
                    : const NewLoginScreen()),
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
          Center(
            child: Text(
              "PilotBazar.com",
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ),
          Center(
            child: Text(
              " Do Business with us",
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 200,),
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
}
