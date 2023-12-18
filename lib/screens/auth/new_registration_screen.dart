import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewRegistrationScreen extends StatefulWidget {
  const NewRegistrationScreen({super.key});

  @override
  State<NewRegistrationScreen> createState() => _NewRegistrationScreenState();
}

class _NewRegistrationScreenState extends State<NewRegistrationScreen> {
  String phone = '01969944400';
  final websiteUrl = Uri.parse('https://facebook.com');
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height/10,),
              Image.asset('assets/images/pilot_logo3.png',width: 170,height: 80,fit: BoxFit.cover,),
              Text(
              " Do Business with Us",
              style: TextStyle(color: Colors.black87, fontSize: 13),
            ),

              SizedBox(height: size.height/15),
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
                          color: Colors.grey), // Focused border color
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: _mobileController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Mobile No / Email ",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 60,
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
                          color: Colors.grey), // Focused border color
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: _nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 60,
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
                          color: Colors.grey), // Focused border color
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: _companyController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Company Name",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 60,
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
                          color: Colors.grey), // Focused border color
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 60,
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
                  controller: _passwordController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 60,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the value as needed
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 89, 170, 236)),
                    onPressed: () {},
                    child: Text(
                      "Registration",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: size.height / 60,
              ),
              Text(
                "Connect with Us",
                style: TextStyle(color: Colors.black87, fontSize: 13),
              ),
              SizedBox(height: size.height / 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        final url = Uri(scheme: 'tel', path: phone);
                        if (await canLaunchUrl(url)) {
                          launchUrl(url);
                        }
                      },
                      icon: Icon(
                        Icons.phone,
                        color: Colors.blue,
                      )),
                  SizedBox(width: size.width / 5),
                  IconButton(
                      onPressed: () async {
                        if (await canLaunchUrl(websiteUrl)) {
                          launchUrl(websiteUrl);
                        }
                      },
                      icon: Icon(Icons.facebook, color: Colors.blue)),
                ],
              ),
              Text(
                "By signing in your agreeing our",
                style: TextStyle(color: Colors.black87, fontSize: 13),
              ),
              const Text(
                "Term and Privacy Policy",
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
