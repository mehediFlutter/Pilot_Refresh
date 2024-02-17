import 'package:flutter/material.dart';
import 'package:pilot_refresh/add%20car/add-car.dart';
import 'package:pilot_refresh/add%20car/description_page.dart';
import 'package:pilot_refresh/add%20car/upload_multiple_image.dart';
import 'package:pilot_refresh/methodes/log_out_methode.dart';
import 'package:pilot_refresh/marcent/marcents.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/customer_care_login.dart';
import 'package:pilot_refresh/screens/auth/new_login_screen.dart';
import 'package:pilot_refresh/screens/double_vehicle_screen.dart';
import 'package:pilot_refresh/screens/marcent_dash_board.dart';
import 'package:pilot_refresh/widget/drawer_item_list.dart';
import 'package:pilot_refresh/widget/save_user_data.dart';
import 'package:pilot_refresh/widget/single_double_select.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({
    super.key,
    required this.mounted,
  });

  final bool mounted;

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
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
        height: 230,
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
                  (getIntPreef==1)?  DrawerItemList(
                      text: 'Add New Car',
                      icon: Icon(Icons.dashboard),
                      onTapFunction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNewCar()));
                      },
                    ):SizedBox(),
                    // DrawerItemList(
                    //   text: 'Item with whats app',
                    //   icon: Icon(Icons.view_module),
                    //   onTapFunction: () {
                    //     // if (mounted) {
                    //     //   Navigator.push(
                    //     //       context,
                    //     //       MaterialPageRoute(
                    //     //           builder: (context) =>
                    //     //               HomeWithWhatsAppIcon()));
                    //     // }
                    //   },
                    // ),

                    // DrawerItemList(
                    //   text: 'View',
                    //   icon: Icon(Icons.view_agenda_outlined),
                    //   onTapFunction: () {
                    //     if (mounted)
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => DoublVehicle()));
                    //   },
                    // ),
                    DrawerItemList(
                      text: 'Login',
                      icon: Icon(Icons.login),
                      onTapFunction: () async {
                         pre = await SharedPreferences.getInstance();
                       print("Log out er age clear info er pore");
                      print(pre.getString('token').toString());
                      await AuthUtility.clearUserInfo();
                      print("Log out er pore clear info er pore");
                      print(pre.getString('token').toString());
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NewLoginScreen()), (route) => false);
                      },
                    ),
                    DrawerItemList(
                      text: 'Logout',
                      icon: Icon(Icons.logout),
                      onTapFunction: () {
                        LogOutAlartDialog().showAlertDialog(context);
                      },
                    ),
                    // DrawerItemList(
                    //     text: "Double or Single",
                    //     icon: Icon(Icons.single_bed),
                    //     onTapFunction:(){
                    //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleOrDouble()));
                    //     }),
                    // DrawerItemList(
                    //     text: "Marcents",
                    //     icon: Icon(Icons.single_bed),
                    //     onTapFunction:(){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>MarcentsAccount()));
                    //     }),
                    // DrawerItemList(
                    //     text: "User Details",
                    //     icon: Icon(Icons.person),
                    //     onTapFunction:(){
                    //       Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInfo()));
                    //     }),
                    // DrawerItemList(
                    //     text: "Description",
                    //     icon: Icon(Icons.person),
                    //     onTapFunction:(){
                    //       Navigator.push(context, MaterialPageRoute(builder: (context)=>DescriptionPage()));
                    //     }),
                    // DrawerItemList(
                    //     text: "Multiple images",
                    //     icon: Icon(Icons.person),
                    //     onTapFunction:(){
                    //       Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadMultiPleImage()));
                    //     }),

                      DrawerItemList(
                      text: 'Customer Care Login',
                      icon: Icon(Icons.login),
                      onTapFunction: () async {
                         pre = await SharedPreferences.getInstance();
                       print("Log out er age clear info er pore");
                      print(pre.getString('token').toString());
                      await AuthUtility.clearUserInfo();
                      print("Log out er pore clear info er pore");
                      print(pre.getString('token').toString());
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CustomerCareLogin()), (route) => false);
                      },
                    ),
                      DrawerItemList(
                      text: 'Pilot Bazae Authority Login',
                      icon: Icon(Icons.login),
                      onTapFunction: () async {
                         pre = await SharedPreferences.getInstance();
                       print("Log out er age clear info er pore");
                      print(pre.getString('token').toString());
                      await AuthUtility.clearUserInfo();
                      print("Log out er pore clear info er pore");
                      print(pre.getString('token').toString());
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NewLoginScreen()), (route) => false);
                      },
                    ),
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
