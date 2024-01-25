import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/new_login_screen.dart';

class LogOutAlartDialog{
     showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
        
          elevation: 50,
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.only(left: 25,top: 20),
            child: Text(
              'Do you want to logout?',
              style: TextStyle(color: Colors.black87, fontSize: 18,fontFamily: "Roboto",),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No',style: TextStyle(fontSize: 17),),
                  ),
                  SizedBox(width: 40),
                  TextButton(
                    onPressed: () async {
                      await AuthUtility.clearUserInfo();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewLoginScreen()),
                          (route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Successfully Logout")));
                    },
                    child: Text('Yes',style: TextStyle(fontSize: 17)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}