import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/screens/auth/new_registration_screen.dart';
import 'package:pilot_refresh/screens/double_vehicle_screen.dart';
import 'package:pilot_refresh/widget/bottom_nav_base-screen.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({super.key});

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  String phone = '01969944400';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  bool loginInProgress = false;
  Future<void> loginFunction() async {
    loginInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response response = await post(
      Uri.parse("https://rm.guideasy.com/api/merchant/login"),
      headers: {
        "Accept": "application/vnd.api+json",
        "Content-Type": "application/vnd.api+json"
      },
      body: jsonEncode({
        "email": _emailController.text,
        "password": _passwordController.text
      },)
    );
    loginInProgress = false;
    if (mounted) {
      setState(() {});
    }
    print("Status Code is");
    print(response.statusCode);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login Success!!")));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login Faild Try Again!!")));
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 27, right: 27, top: size.height / 7),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height / 30),
              Image.asset(
                'assets/images/pilot_logo3.png',
                width: 170,
                height: 80,
                fit: BoxFit.cover,
              ),
              Text(
                " Do Business with Us",
                style: TextStyle(color: Colors.black87, fontSize: 13),
              ),
              SizedBox(height: size.height / 10),
              Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Focused border color
                    ),
                  ),
                ),
                child: TextField(
                  
                  controller: _emailController,
                  style: TextStyle(color: Colors.black,fontSize: 17),
                  decoration: InputDecoration(
                    
                    labelText: "Mobile No",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 243, 237, 237),
                      ), // Focused border color
                    ),
                  ),
                ),
                child: TextField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.black,fontSize: 17),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    " Forgot password ? ",
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child:loginInProgress?Center(child: CircularProgressIndicator()): ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the value as needed
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 89, 170, 236)),
                    onPressed: () {
                      loginFunction();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewRegistrationScreen()));
                  },
                  child: Text(
                    " Registration",
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 10,
              ),
              Text(
                "By signing in your agreeing our",
                style: TextStyle(color: Colors.black87, fontSize: 13),
              ),
              const Text(
                "Term and privacy policy",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontFamily: "AbhayaLibre"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
