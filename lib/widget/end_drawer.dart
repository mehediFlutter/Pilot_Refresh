import 'package:flutter/material.dart';
import 'package:pilot_refresh/add%20car/add-car.dart';
import 'package:pilot_refresh/methodes/log_out_methode.dart';
import 'package:pilot_refresh/screens/auth/marcents.dart';
import 'package:pilot_refresh/screens/double_vehicle_screen.dart';
import 'package:pilot_refresh/screens/marcent_dash_board.dart';
import 'package:pilot_refresh/widget/drawer_item_list.dart';
import 'package:pilot_refresh/widget/single_double_select.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    super.key,
    required this.mounted,
  });

  final bool mounted;

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
                    DrawerItemList(
                      text: 'Add New Car',
                      icon: Icon(Icons.dashboard),
                      onTapFunction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNewCar()));
                      },
                    ),
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
                      text: 'Logout',
                      icon: Icon(Icons.logout),
                      onTapFunction: () {
                        LogOutAlartDialog().showAlertDialog(context);
                      },
                    ),
                    DrawerItemList(
                        text: "Double or Single",
                        icon: Icon(Icons.single_bed),
                        onTapFunction:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleOrDouble()));
                        }),
                    DrawerItemList(
                        text: "Marcents",
                        icon: Icon(Icons.single_bed),
                        onTapFunction:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MarcentsAccount()));
                        }),
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
