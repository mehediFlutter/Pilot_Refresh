import 'package:flutter/material.dart';
import 'package:pilot_refresh/admin/admin_double_vehicle_screen.dart';
import 'package:pilot_refresh/screens/auth/home_vehicle_store_backup.dart';
import 'package:pilot_refresh/screens/home_vehicle.dart';

class BottomNavBaseScreen extends StatefulWidget {
  final bool? isDoubleScreenSelected;
  final bool? isSingleScreenSelected;

  const BottomNavBaseScreen({
    Key? key,
    this.isDoubleScreenSelected,
    this.isSingleScreenSelected,
  }) : super(key: key);

  @override
  _BottomNavBaseScreenState createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;

@override
void initState() {
  super.initState();
  
  // Check if widget.isDoubleScreenSelected and widget.isSingleScreenSelected are not null
  if (widget.isDoubleScreenSelected != null && widget.isSingleScreenSelected != null) {
    // Set the default index based on the selected screen type
    _selectedScreenIndex = widget.isDoubleScreenSelected! ? 0 : widget.isSingleScreenSelected! ? 1 : 0;
  } else {
    // Handle the case where either widget.isDoubleScreenSelected or widget.isSingleScreenSelected is null
    // You may want to set a default value or handle this case differently based on your requirements.
    _selectedScreenIndex = 0;
  }
}

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
          setState(() {
            _selectedScreenIndex = index;
          });
        },
        items: _screens
            .map((screen) => BottomNavigationBarItem(
                  icon: Image.asset(
                    screen is AdminDoublVehicle
                        ? 'assets/images/two_car1.png'
                        : 'assets/images/car.png',
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                  label: screen is AdminDoublVehicle
                      ? "Double Screen"
                      : "Single Screen",
                ))
            .toList(),
      ),
    );
  }

  List<Widget> get _screens {
    return [
      AdminDoublVehicle(),
      HomeVehicleStoreBackup(),
    ];
  }
}