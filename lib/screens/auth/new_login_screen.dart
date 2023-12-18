import 'dart:convert';

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/login_model.dart';
import 'package:pilot_refresh/screens/auth/new_registration_screen.dart';
import 'package:pilot_refresh/screens/home_vehicle.dart';
import 'package:pilot_refresh/service/network_caller.dart';
import 'package:pilot_refresh/service/network_response.dart';
=======
import 'package:http/http.dart';
import 'package:pilot_refresh/screens/auth/new_registration_screen.dart';
import 'package:pilot_refresh/screens/double_vehicle_screen.dart';
>>>>>>> 137f4f9c055122fef255f4c1f64b47baf5ac2e32
import 'package:pilot_refresh/widget/bottom_nav_base-screen.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({super.key});

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
    final GlobalKey<FormState> _globalKey = GlobalKey();
  String phone = '01969944400';
<<<<<<< HEAD
  bool _loginInProgress = false;
  Future<void> login() async {
    _loginInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller().postRequest(
        'https://pilotbazar.com/api/merchant/auth/login', <String, dynamic>{
      "mobile": _mobileController.text,
      "password": _passwordController.text
    });
    _loginInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.statusCode == 200) {
      _mobileController.clear();
      _passwordController.clear();
        LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login Success")));
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavBaseScreen()));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login Faild!!")));
      }
    }
  }
=======
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
>>>>>>> 137f4f9c055122fef255f4c1f64b47baf5ac2e32

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
<<<<<<< HEAD
          child: Form(
            key: _globalKey,
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
                  child: TextFormField(
                    controller: _mobileController,
                    style: TextStyle(color: Colors.black,fontSize: 15),
                    decoration: InputDecoration(
                      labelText: "Mobile No",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter mobile number';
                      }
                      return null;
                    },
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
                            color: const Color.fromARGB(
                                255, 243, 237, 237)), // Focused border color
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                     style: TextStyle(color: Colors.black,fontSize: 15),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                      
                    ),
                     validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter password';
                      }
                      return null;
                    },
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
                  child: _loginInProgress
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the value as needed
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 89, 170, 236)),
                          onPressed: () {
                            if(!_globalKey.currentState!.validate()){
                              return null;
                            }
                            login();
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
=======
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
>>>>>>> 137f4f9c055122fef255f4c1f64b47baf5ac2e32
                    },
                    child: Text(
                      " Registration",
                      style: TextStyle(color: Colors.black87, fontSize: 13),
                    ),
                  ),
                ),
<<<<<<< HEAD
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
=======
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
>>>>>>> 137f4f9c055122fef255f4c1f64b47baf5ac2e32
          ),
        ),
      ),
    );
  }
}
