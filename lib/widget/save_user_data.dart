import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    SharedPreferences userData;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: ElevatedButton(onPressed: () async {
        //  userData = await SharedPreferences.getInstance();
           LoginModel userInfo = await AuthUtility.getUserInfo();
           print('User marcent id is ');
          print(userInfo.payload?.merchant?.id);
          
        }, child: Text("User-Info"))),

      ],),
    );
  }
}