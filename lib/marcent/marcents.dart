import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/login_model.dart';
import 'package:pilot_refresh/widget/bottom_nav_base-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarcentsAccount extends StatefulWidget {
  const MarcentsAccount({super.key});

  @override
  State<MarcentsAccount> createState() => _MarcentsAccountState();
}

class _MarcentsAccountState extends State<MarcentsAccount> {
  SharedPreferences? share;
  bool myLoginInInProgress = false;
  late String? token;

  Future myLogin(String mobile, password) async {
    myLoginInInProgress = true;
    if (mounted) {
      setState(() {});
    }
    share = await SharedPreferences.getInstance();
    Map<String, dynamic> body = {
      "mobile": mobile,
      "password": password,
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
      token = decodedBody['payload']?['token']!;
      LoginModel model =
          LoginModel.fromJson(decodedBody.cast<String, dynamic>());
      await AuthUtility.saveUserInfo(model);
      print(decodedBody['payload']?['token']);
      print(token);
      await share?.setString('token', token!);
      setState(() {});
      print(model.payload!.token);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavBaseScreen(
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xFF313131),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [


            OutlinedButton(
                onPressed: () async {
                  share = await SharedPreferences.getInstance();
                  print("Log out er age clear info er pore");
                  print(share?.getString('token').toString());
                  await AuthUtility.clearUserInfo();
                  print("Log out er pore clear info er pore");
                  print(share?.getString('token').toString());
                  myLogin('8801969944400', 'pilot87654321');
                },
                child: Text("marcent 1")),
            OutlinedButton(
                onPressed: () async {
                  share = await SharedPreferences.getInstance();
                  print("Log out er age clear info er pore");
                  print(share?.getString('token').toString());
                  await AuthUtility.clearUserInfo();
                  print("Log out er pore clear info er pore");
                  print(share?.getString('token').toString());

                  myLogin('01985664675', 'pilot87654321');
                },
                child: Text("marcent 2")),
            OutlinedButton(onPressed: () {}, child: Text("marcent 3")),
            Spacer(),
            ElevatedButton(onPressed: (){}, child: Text('Add marcent')),

          ],
          
        ),
        
      ),
    );
  }
}
