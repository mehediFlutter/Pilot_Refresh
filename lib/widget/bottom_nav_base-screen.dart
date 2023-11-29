import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/double_vehicle_screen.dart';
import 'package:pilot_refresh/screens/home_vehicle.dart';



class BottomNavBaseScreen extends StatefulWidget {
   BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {

  int _selectedScreenIndex= 0 ;
  final List<Widget> _screens =  [
  HomeVehicle(),
  DoublVehicle(),
  HomeVehicle(),
  HomeVehicle(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[_selectedScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedScreenIndex,
          unselectedItemColor: Colors.grey,

          unselectedLabelStyle: const TextStyle(
            color: Colors.grey,
          ),
          showUnselectedLabels: true,
          selectedItemColor: Colors.green,
        onTap: (int index) {
          _selectedScreenIndex = index;
          if(mounted){
            setState(() {
              
            });
          }
        },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",),
        BottomNavigationBarItem(icon: Icon(Icons.view_agenda_outlined),label: "Double vehicle"),
        BottomNavigationBarItem(icon: Icon(Icons.cancel),label: "Cancel"),
        BottomNavigationBarItem(icon: Icon(Icons.done_all),label: "Completed"),
      ],
    ));
  }
}