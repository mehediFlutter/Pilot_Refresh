import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/const_color/border_color_radious.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/customer_care/customer_care_registration.dart';
import 'package:pilot_refresh/screens/auth/login_model.dart';
import 'package:pilot_refresh/screens/auth/new_registration_screen.dart';
import 'package:pilot_refresh/widget/bottom_nav_base-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerCareLogin extends StatefulWidget {
  const CustomerCareLogin({super.key});

  @override
  State<CustomerCareLogin> createState() => _CustomerCareLoginState();
}

class _CustomerCareLoginState extends State<CustomerCareLogin> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  String phone = '01969944400';
  var token;
  var merchantId;
  late SharedPreferences prefss;
  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  late String toki;
  initSharedPref() async {
    prefss = await SharedPreferences.getInstance();
    // toki = prefss.getString('token').toString();
    // print('token is');
    // print(toki);
  }

  bool myLoginInInProgress = false;
  Future myLogin() async {
    prefss = await SharedPreferences.getInstance();
    myLoginInInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> body = {
      "mobile": mobileController.text,
      "password": passwordController.text
    };
    Response response = await post(
        Uri.parse('https://pilotbazar.com/api/merchant/auth/login'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      Map decodedBody = jsonDecode(response.body.toString());
      print(decodedBody);
      token = decodedBody['payload']?['token']!;
      merchantId = decodedBody['payload']?['merchant']?['id'];
      LoginModel model =
          LoginModel.fromJson(decodedBody.cast<String, dynamic>());
      await AuthUtility.saveUserInfo(model);
      print(decodedBody['payload']?['token']);

      print(token);
      await prefss.setString('token', token);
      await prefss.setString('merchantId', merchantId.toString());
      //  await prefss.setString('token', token);
      setState(() {});
      print(model.payload!.token);
      await prefss.setBool('isLogin', true);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavBaseScreen(
                  isLogedIn: prefss.getBool('isLogin'),
                  token: decodedBody['payload']?['token'].toString())));

      print("Login Success");
    }

    // token = decodedBody['payload']['token'];
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavBaseScreen(
                  token: token,
                )),
        (route) => false);
    myLoginInInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  // Future<void> login() async {
  //   _loginInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }

  //   NetworkResponse response = await NetworkCaller().postRequest(
  //       'https://pilotbazar.com/api/merchant/auth/login', <String, dynamic>{
  //     "mobile": _mobileController.text,
  //     "password": _passwordController.text
  //   });
  //   _loginInProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   print("here 1 ?");
  //   if (response.statusCode == 200) {
  //     print("Login Success!!!!");
  //     Map decodedBody = jsonDecode(response.body.toString());
  //     // String token = decodedBody['token'];
  //     // print("Token is");
  //     // print(token);
  //     // _mobileController.clear();
  //     // _passwordController.clear();
  //     token = decodedBody['payload']?['token'] ?? '';
  //     // LoginModel model = LoginModel.fromJson(response.body!);
  //     // await AuthUtility.saveUserInfo(model);
  //     if (mounted) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("Login Success")));
  //     }

  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => BottomNavBaseScreen()));
  //   } else {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("Login Faild!!")));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 27, right: 27, top: size.height / 7),
        child: SingleChildScrollView(
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


                SizedBox(height: size.height/30),
                TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black,fontSize: 15),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                       textFildContentPadding,
                      border: customBorderPackage,
                      focusedBorder: customFocusBorder,
                      disabledBorder: customBorderPackage),
                ),
                SizedBox(height: size.height/50),
                TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                  cursorColor: Colors.black,
                  
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                         textFildContentPadding,
                      border: customBorderPackage,
                      focusedBorder: customFocusBorder,
                      disabledBorder: customBorderPackage),
                ),
                SizedBox(height: 20),
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
                  child: myLoginInInProgress
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
                          onPressed: () async {
                            if (!_globalKey.currentState!.validate()) {
                              return null;
                            }
                            await myLogin();
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          )),
                ),
                SizedBox(height: 15),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: OutlinedButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => CustomerCareRegistration()));
                //     },
                //     child: Text(
                //       "Customer Care Registration",
                //       style: TextStyle(color: Colors.black87, fontSize: 13),
                //     ),
                //   ),
                // ),
                TextButton(
                    onPressed: () async {
                      final bool isLoggedIn =
                          await AuthUtility.checkIfUserLoggedIn();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBaseScreen(
                                    isLogedIn: isLoggedIn,
                                  )),
                          (route) => false);
                    },
                    child: Text("View as Gest")),
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
      ),
    );
  }
}
