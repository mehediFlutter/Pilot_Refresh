import 'package:flutter/material.dart';
import 'package:pilot_refresh/add%20car/add-car.dart';
import 'package:pilot_refresh/methodes/log_out_methode.dart';
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
  bool isCustomerCare=false;
late SharedPreferences pre;

Future<void> getPreffs() async {
  pre = await SharedPreferences.getInstance();
  if (pre.getString('token') == null) {
    getIntPreef--;
  } else {
    getIntPreef++;
  }
  if(await pre.getString('type')=='customercare'){
    setState(() {
      isCustomerCare=true;
    });

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
        height: (getIntPreef==1 && isCustomerCare==true)?160:160,     
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
                   
                
                  (getIntPreef ==1 || getIntPreef>=0)?   DrawerItemList(
                      text: 'Logout',
                      icon: Icon(Icons.logout),
                      onTapFunction: () {
                        LogOutAlartDialog().showAlertDialog(context);
                      },
                    ):SizedBox(),
                    
                
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
