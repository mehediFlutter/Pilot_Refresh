import 'package:flutter/material.dart';
import 'package:pilot_refresh/add%20car/add-car.dart';
import 'package:pilot_refresh/add%20car/description_page.dart';
import 'package:pilot_refresh/add%20car/upload_multiple_image.dart';
import 'package:pilot_refresh/methodes/log_out_methode.dart';
import 'package:pilot_refresh/marcent/marcents.dart';
import 'package:pilot_refresh/screens/auth/customer_care/customer_care_registration.dart';
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
        height: (getIntPreef==1 || getIntPreef>=0)?300:160,
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
                  (getIntPreef==1 || getIntPreef>=0)?  DrawerItemList(
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
                   (getIntPreef !=1)?  DrawerItemList(
                      text: 'Merchent Login',
                      icon: Icon(Icons.login),
                      onTapFunction: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NewLoginScreen()), (route) => false);
                      },
                    ):SizedBox(),
                  (getIntPreef ==1 || getIntPreef>=0)?   DrawerItemList(
                      text: 'Merchent Logout',
                      icon: Icon(Icons.logout),
                      onTapFunction: () {
                        LogOutAlartDialog().showAlertDialog(context);
                      },
                    ):SizedBox(),
                    
                     (getIntPreef==1 || getIntPreef>=0)? DrawerItemList(text: 'Customar care Registration',
                      icon: Icon(Icons.login), onTapFunction: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerCareRegistration()));
                      }):SizedBox(),
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
