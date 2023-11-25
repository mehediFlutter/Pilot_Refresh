import 'package:flutter/material.dart';
import 'package:pilot_bazar/screens/bottom_nav_base-screen.dart';
import 'package:pilot_bazar/screens/home_page.dart';
import 'package:pilot_bazar/widget/make_a-phone_call.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF333333),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Text(
                  //   "Register",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 27,
                  //       fontFamily: "AbhayaLibre"),
                  // ),

                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       left: 60, right: 60, top: 20, bottom: size.height / 25),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "Login",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 16,
                  //             fontFamily: 'Axiforma'),
                  //       ),
                  //       Spacer(),
                  //       Text(
                  //         "Registration",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 16,
                  //             fontFamily: 'Axiforma'),
                  //       )
                  //     ],
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextField(
                          // scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            // prefixIcon: Padding(
                            //   padding: EdgeInsetsDirectional.only(
                            //       start: 1.0, end: 30),
                            //   // child: Icon(
                            //   //   Icons.phone_android_outlined,
                            //   //   color: Colors.white,
                            //   //   size: 25,
                            //   // ),
                            // ),
                            // suffixIcon: Icon(
                            //   Icons.remove_red_eye_outlined,
                            //   color: Colors.white,
                            //   size: 30,
                            // ),
                            hintText: "Phone Number",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextField(
                          // scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            // prefixIcon: Padding(
                            //   padding: EdgeInsetsDirectional.only(
                            //       start: 1.0, end: 30),
                            //   // child: Icon(
                            //   //   Icons.account_circle_outlined,
                            //   //   color: Colors.white,
                            //   //   size: 25,
                            //   // ),
                            // ),
                            // suffixIcon: Icon(
                            //   Icons.remove_red_eye_outlined,
                            //   color: Colors.white,
                            //   size: 30,
                            // ),
                            hintText: "Name",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        TextField(
                          // scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            // prefixIcon: Padding(
                            //   padding: EdgeInsetsDirectional.only(
                            //       start: 1.0, end: 30),
                            //   // child: Icon(
                            //   //   Icons.account_circle_outlined,
                            //   //   color: Colors.white,
                            //   //   size: 25,
                            //   // ),
                            // ),
                            // suffixIcon: Icon(
                            //   Icons.remove_red_eye_outlined,
                            //   color: Colors.white,
                            //   size: 30,
                            // ),
                            hintText: "Conpany Name",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),

                        SizedBox(height: 5),
                        TextField(
                          // scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            // prefixIcon: Padding(
                            //   padding: EdgeInsetsDirectional.only(
                            //       start: 1.0, end: 30),
                            //   // child: Icon(
                            //   //   Icons.email_outlined,
                            //   //   color: Colors.white,
                            //   //   size: 25,
                            //   // ),
                            // ),
                            // suffixIcon: Icon(
                            //   Icons.remove_red_eye_outlined,
                            //   color: Colors.white,
                            //   size: 30,
                            // ),
                            hintText: "Email",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        SizedBox(height: 5),
                        TextField(
                          // scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            // prefixIcon: Padding(
                            //   padding: EdgeInsetsDirectional.only(
                            //       start: 1.0, end: 30),
                            //   // child: Icon(
                            //   //   Icons.lock_outline_sharp,
                            //   //   color: Colors.white,
                            //   //   size: 25,
                            //   // ),
                            // ),
                            // suffixIcon: Icon(
                            //   Icons.remove_red_eye_outlined,
                            //   color: Colors.white,
                            //   size: 30,
                            // ),
                            hintText: "Password",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  // TextField(
                  //   // scrollPadding: EdgeInsets.zero,
                  //   decoration: InputDecoration(
                  //     prefixIcon: const Padding(
                  //       padding:
                  //           EdgeInsetsDirectional.only(start: 1.0, end: 30),
                  //       // child: Icon(
                  //       //   Icons.lock_outline_sharp,
                  //       //   color: Colors.white,
                  //       //   size: 25,
                  //       // ),
                  //     ),
                  //     // suffixIcon: const Icon(
                  //     //   Icons.remove_red_eye_outlined,
                  //     //   color: Colors.white,
                  //     //   size: 30,
                  //     // ),
                  //     hintText: " Confirm Password",
                  //     hintStyle: Theme.of(context).textTheme.titleMedium,
                  //   ),
                  // ),
                  SizedBox(
                    height: size.height / 40,
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBaseScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Adjust the value as needed
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: const Color.fromARGB(
                                        255, 209, 207, 207)),
                          ))),
                  const SizedBox(height: 10),
                  Text("or connect with",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/facebook1.png'),
                        Image.asset('assets/images/instagram1.png'),
                        Image.asset('assets/images/pinterest1.png'),
                        Image.asset('assets/images/linkedin1.png'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: size.height / 50,
                  ),
                  MakeAPhoneCall(phone: '01969944400'),
                  SizedBox(
                    height: size.height / 15,
                  ),
                  Text("By signing in your agreeing our",
                      style: Theme.of(context).textTheme.titleSmall),
                  const Text(
                    "Term and privacy policy",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontFamily: "AbhayaLibre"),
                  ),

                  //Image.asset('assets/images/logoCircle.png')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
