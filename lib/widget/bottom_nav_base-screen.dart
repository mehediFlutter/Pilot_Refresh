import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/all_vehicle.dart';
import 'package:pilot_refresh/screens/double_vehicle_screen.dart';
import 'package:pilot_refresh/screens/home_vehicle.dart';

class BottomNavBaseScreen extends StatefulWidget {
  BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;
  final List<Widget> _screens = [
    DoublVehicle(),
    HomeVehicle(),
    AllVehicle(),
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
            if (mounted) {
              setState(() {});
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/two_car1.png',
                width: 20,
                fit: BoxFit.cover,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/car.png',
                  width: 20,
                  fit: BoxFit.cover,
                ),
                label: "Double vehicle"),
            BottomNavigationBarItem(   icon: Image.asset(
                  'assets/images/all_car.png',
                  width: 20,
                  fit: BoxFit.cover,
                ), label: "All Vehicle"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/all_car.png',
                  width: 20,
                  fit: BoxFit.cover,
                ), label: "Completed"),
          ],
        ));
  }
}
