import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/bottom_nav_base-screen.dart';
import 'package:pilot_refresh/widget/make_a_phone_call.dart';


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
                  SizedBox(height: size.height/8,),
                 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                           
                            hintText: "Phone Number",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextField(
                          decoration: InputDecoration(
                          
                            hintText: "Name",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                           
                            hintText: "Conpany Name",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),

                        SizedBox(height: 5),
                        TextField(
                          decoration: InputDecoration(
                           
                            hintText: "Email",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      
                        SizedBox(height: 5),
                        TextField(
                          decoration: InputDecoration(
                          
                            hintText: "Password",
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
              
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
                                  20.0),
                                   // Adjust the value as needed
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge,
                          ))),
                  const SizedBox(height: 20),
                  Text("or connect with",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    height: size.height / 30,
                  ),
                  Text("By signing in your agreeing our",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 15)),
                  const Text(
                    "Term and privacy policy",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
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
