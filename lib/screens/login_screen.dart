import 'package:flutter/material.dart';
import 'package:pilot_bazar/auth/registration.dart';
import 'package:pilot_bazar/widget/make_a-phone_call.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  String phone = '01969944400';
  final websiteUrl = Uri.parse('https://heyflutter.com');
  bool isChecked = false;
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF333333),
        body: Padding(
          padding: EdgeInsets.only(top: size.height / 12, left: 10, right: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Text(
                  //   "Login",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 27,fontFamily: "AbhayaLibre"
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 40, bottom: 0),
                    // child: Row(
                    //   children: [
                    //     TextButton(
                    //         onPressed: () {},
                    //         child: const Text(
                    //           "Login",
                    //           style: TextStyle(fontSize: 16,fontFamily: "AbhayaLibre"),
                    //         )),
                    //     const Spacer(),
                    //     TextButton(
                    //         onPressed: () {},
                    //         child: InkWell(
                    //           onTap: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         const Registration()));
                    //           },
                    //           child:  Text(
                    //             "Registration",
                    //             style: Theme.of(context).textTheme.titleLarge,
                    //             // style: TextStyle(
                    //             //     color: Colors.white, fontSize: 16),
                    //           ),
                    //         ))
                    //   ],
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.only(top: 10),
                            // enabledBorder: UnderlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.white)),
                            // prefixIcon: Padding(
                            //   padding: EdgeInsetsDirectional.only(
                            //       start: 0, end: 30),
                            //   // child: Icon(
                            //   //   Icons.email_outlined,
                            //   //   color: Colors.grey,
                            //   //   size: 30,
                            //   // ),
                            // ),
                            hintText: "Mobile Number/Email Address",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                            // hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 50,
                        ),
                        TextField(
                          // scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.only(left: 20,top: 15),
                            // prefixIcon: Padding(
                            //   padding: EdgeInsetsDirectional.only(
                            //       start: 1.0, end: 0),
                            //   // child: Icon(
                            //   //   Icons.lock_outline_sharp,
                            //   //   color: Colors.grey,
                            //   //   size: 30,
                            //   // ),
                            // ),
                            // suffixIcon: Icon(
                            //   Icons.remove_red_eye_outlined,
                            //   color: Colors.grey,
                            //   size: 30,
                            // ),
                            hintText: "Password",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Checkbox(
                      //   //fillColor: Colors.white,
                      //   checkColor: Colors.white,
                      //   activeColor: Colors.white,
                      //   value: isChecked,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       isChecked = value!;
                      //     });
                      //   },
                      // ),
                      // const Expanded(
                      //   child: Text(
                      //     "Remember password",
                      //     style:
                      //         TextStyle(color: Colors.grey, fontSize: 14,fontFamily: "AbhayaLibre"),
                      //   ),
                      // ),
                      Spacer(),
                      SizedBox(
                        width: size.width / 10,
                      ),
                      const Text(
                        "Forget password",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontFamily: "AbhayaLibre"),
                      )
                    ],
                  ),
                  SizedBox(height: size.height / 30),
                  SizedBox(
                      height: size.height / 14,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registration()));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Adjust the value as needed
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.titleLarge,
                          ))),
                  SizedBox(height: size.height / 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Hava an Account?",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registration()));
                          },
                          child: Text(
                            "Registration",
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                  Text("or Connect With Us",
                      style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: size.height / 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/facebook1.png"),
                      Image.asset('assets/images/instagram1.png'),
                      Image.asset('assets/images/pinterest1.png'),
                      Image.asset('assets/images/linkedin1.png'),
                    ],
                  ),
                  //Spacer(),
                  // SizedBox(
                  //   height: size.height/50,
                  // ),
                  
                  // Image.asset('assets/images/logoCircle.png')
                  Padding(
                    padding:  EdgeInsets.only(top: size.height/10),
                    child: MakeAPhoneCall(phone: phone),
                  ),
                       SizedBox(
                    height: size.height/13,
                  ),
                      Text(
                    "By signing in your agreeing our",
                   style: Theme.of(context).textTheme.titleSmall
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
      ),
    );
  }
}

