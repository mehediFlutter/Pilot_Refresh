import 'package:flutter/material.dart';
import 'package:pilot_refresh/For_Customer_Care/auth/customer_care_login.dart';
import 'package:pilot_refresh/add%20car/add-car.dart';
import 'package:pilot_refresh/calculate_car_price/calculate_car_price.dart';
import 'package:pilot_refresh/methodes/log_out_methode.dart';
import 'package:pilot_refresh/screens/auth/customer_care/customer_care_details.dart';
import 'package:pilot_refresh/screens/auth/customer_care/customer_care_registration.dart';
import 'package:pilot_refresh/screens/auth/new_login_screen.dart';
import 'package:pilot_refresh/screens/marcent_dash_board.dart';
import 'package:pilot_refresh/widget/drawer_item_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class C_EndDrawer extends StatefulWidget {
  const C_EndDrawer({
    super.key,
    required this.mounted,
  });

  final bool mounted;

  @override
  State<C_EndDrawer> createState() => _C_EndDrawerState();
}

class _C_EndDrawerState extends State<C_EndDrawer> {
  int getIntPreef = 0;
late SharedPreferences pre;

Future<void> getPreffs() async {
  pre = await SharedPreferences.getInstance();
  if (pre.getString('token') == null) {
    getIntPreef--;
  } else {
    getIntPreef++;
  }
}

@override
  void initState() {
    super.initState();
    initializePreffsBool();
    // TODO: implement initState
    
  }

  void initializePreffsBool() async {
  await getPreffs();
  setState(() {
    print(getIntPreef);
  });
}
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: (getIntPreef==1 || getIntPreef>=0)?300:215,     
        width: 200,
        child: Drawer(
          backgroundColor: Color(0xFF333333),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    DrawerItemList(
                      text: 'Preview',
                      icon: Icon(Icons.dashboard),
                      onTapFunction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MarchentDashBoard()));
                      },
                    ),
                  // (getIntPreef==1 || getIntPreef>=0)?  DrawerItemList(
                  //     text: 'Add New Car',
                  //     icon: Icon(Icons.add_box_sharp),
                  //     onTapFunction: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => AddNewCar()));
                  //     },
                  //   ):SizedBox(),
                   
             
                   DrawerItemList(
                      text: 'Customer Care Login',
                      icon: Icon(Icons.login),
                      onTapFunction: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CustomerCareLogin()), (route) => false);
                      },
                    ),
                 
                    
                    

                   

                      // DrawerItemList(text: 'Calculate Car Price',
                      // icon: Icon(Icons.calculate), onTapFunction: (){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CalculateCarPrice()));
                      // })
                  ],
                ),
              ),
              //ListTile(title: Text("item"),)
            ],
          ),
        ),
      ),
    );
  }
}
