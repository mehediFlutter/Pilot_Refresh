import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/const_color/border_color_radious.dart';
import 'package:pilot_refresh/screens/bottom_nav_base-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerCareRegistration extends StatefulWidget {
  const CustomerCareRegistration({super.key});

  @override
  State<CustomerCareRegistration> createState() =>
      _CustomerCareRegistrationState();
}

class _CustomerCareRegistrationState extends State<CustomerCareRegistration> {
  String phone = '01969944400';
  final websiteUrl = Uri.parse('https://facebook.com');
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  late SharedPreferences preffs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  bool customerCareRegistrationInProgress = false;
  initSharedPref() async {
    preffs = await SharedPreferences.getInstance();
    print("Token still have in customer care regisration");
    print(preffs.getString('token'));
  }

  //  /// registration with get methode
  // Future<void> customerCareRegistration() async {
  //   SharedPreferences preffs = await SharedPreferences.getInstance();
  //   customerCareRegistrationInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }

  //   String baseUrl =
  //       "https://pilotbazar.com/"; // Replace this with your base URL
  //   Map<String, dynamic> queryParams = {
  //     "name": _nameController.text,
  //     "mobile": _phoneNumberController.text,
  //     "password": _passwordController.text
  //   };

  //   // Constructing the query parameters
  //   String queryString = Uri(queryParameters: queryParams).query;
  //   // String queryString = Uri(queryParameters: queryParams).query;

  //   Response response = await http.get(
  //     Uri.parse(baseUrl + "api/customer-care/auth/register?$queryString"),
  //     headers: {
  //       'Accept': 'application/vnd.api+json',
  //       'Content-Type': 'application/vnd.api+json',
  //       'Authorization': 'Bearer ${preffs.getString('token')}'
  //     },
  //   );
  //   print("status code is");
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else {
  //     // Registration failed
  //   }
  // }

  customerCareRegistration() async {
    preffs = await SharedPreferences.getInstance();
    final body = 
      {
        "name": _nameController.text,
        "mobile": _phoneNumberController.text,
        "password": _passwordController.text
      };
    
    Response response = await post(
        Uri.parse("https://pilotbazar.com/api/customer-care/auth/register"),
        body: jsonEncode(body),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${preffs.getString('token')}'
        });
        print("status code is");
        print(response.statusCode);
        final decodedResponse = jsonDecode(response.body);
        print(decodedResponse);
        if(response.statusCode==200){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Customer Care Registration Success!!!')));
            Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBaseScreen()));
        }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height / 10,
              ),
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
              SizedBox(
                height: size.height / 10,
              ),
              Text(
                "Customer Care Registration",
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
              SizedBox(height: size.height / 80),
              TextFormField(
                controller: _nameController,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: customBorderPackage,
                  focusedBorder: customFocusBorder,
                  disabledBorder: customBorderPackage,
                  contentPadding: textFildContentPadding,
                ),
              ),
              SizedBox(
                height: size.height / 80,
              ),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: customBorderPackage,
                  focusedBorder: customFocusBorder,
                  disabledBorder: customBorderPackage,
                  contentPadding: textFildContentPadding,
                ),
              ),
              SizedBox(
                height: size.height / 80,
              ),
              TextFormField(
                controller: _passwordController,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: customBorderPackage,
                  focusedBorder: customFocusBorder,
                  disabledBorder: customBorderPackage,
                  contentPadding: textFildContentPadding,
                ),
              ),
              SizedBox(height: size.height / 15),
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
                    onPressed: () {
                      customerCareRegistration();
                    
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: size.height / 60,
              ),
              // TextButton(
              //     onPressed: () async {
              //       final bool isLoggedIn =
              //           await AuthUtility.checkIfUserLoggedIn();

              //       Navigator.pushAndRemoveUntil(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => BottomNavBaseScreen(
              //                     isLogedIn: isLoggedIn,
              //                   )),
              //           (route) => false);
              //     },
              //     child: Text("View as Gest")),
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
