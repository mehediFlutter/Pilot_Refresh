import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/For_Customer_Care/auth/customer_care_login.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/login_model.dart';
import 'package:pilot_refresh/screens/bottom_nav_base-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({super.key});

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  String phone = '01969944400';
  var token;
  var merchantId;
  var merchantName;
  var mobileNumber;
  late SharedPreferences prefss;
  @override
  void initState() {
    // TODO: implement initState
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
    print("status code");
    print(response.statusCode);

    if (response.statusCode == 200) {
      Map decodedBody = jsonDecode(response.body.toString());
      print(decodedBody);
      token = decodedBody['payload']?['token']!;
      merchantId = decodedBody['payload']?['merchant']?['id'];
      merchantName = decodedBody['payload']?['merchant']?['name'];
      mobileNumber = decodedBody['payload']?['merchant']?['mobile'];
      LoginModel model =
          LoginModel.fromJson(decodedBody.cast<String, dynamic>());
      await AuthUtility.saveUserInfo(model);
      print(decodedBody['payload']?['token']);

      print(token);
      await prefss.setString('token', token);
      await prefss.setString('merchantId', merchantId.toString());
      await prefss.setString('merchantName', merchantName.toString());
      await prefss.setString('mobileNumber', mobileNumber.toString());
      setState(() {});
      print(model.payload!.token);
      await prefss.setBool('isLogin', true);

      print("Login Success");
    }
    myLoginInInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error Phone number or Password try again!!!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 27, right: 27, top: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height / 6),
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
                    onChanged: (value) {
                      // Check if the value entered does not start with "88"
                      if (!value.startsWith("88")) {
                        // If it doesn't start with "88", prepend "88" to the entered value
                        mobileController.value =
                            mobileController.value.copyWith(
                          text: "88$value",
                          selection:
                              TextSelection.collapsed(offset: "88".length),
                          // Set cursor position after "88"
                        );
                      }
                    },
                    cursorColor: Colors.black,
                  //  controller: mobileController,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15, color: Colors.black),
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
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey), // Focused border color
                      ),
                    ),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: passwordController,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15, color: Colors.black),
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
                //               builder: (context) => NewRegistrationScreen()));
                //     },
                //     child: Text(
                //       " Registration",
                //       style: TextStyle(color: Colors.black87, fontSize: 13),
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerCareLogin()));
                    },
                    child: Text(
                      "Customer Care Login",
                      style: TextStyle(color: Colors.black87, fontSize: 13),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      final bool isLoggedIn =
                          await AuthUtility.checkIfUserLoggedIn();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBaseScreen()),
                          (route) => false);
                    },
                    child: Text("View as Gest")),
                SizedBox(height: 20),
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
