import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/auth/new_registration_screen.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({super.key});

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  String phone = '01969944400';
  @override
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
              SizedBox(height: size.height / 10),
              Image.asset('assets/images/pilot_logo3.png',width: 170,height: 80,fit: BoxFit.cover,),
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
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Mobile No / Email",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
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
                          color: const Color.fromARGB(
                              255, 243, 237, 237)), // Focused border color
                    ),
                  ),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
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
                    " Forget Password ? ",
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the value as needed
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 89, 170, 236)),
                    onPressed: () {},
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
                    "New Register Here",
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(height: size.height/10,),
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
