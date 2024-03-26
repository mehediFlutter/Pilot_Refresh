import 'package:flutter/material.dart';
import 'package:pilot_refresh/For_Customer_Care/screens/C_double_vehicle_screen.dart';
import 'package:pilot_refresh/For_Customer_Care/screens/C_home_single-vehicle_screen.dart';
import 'package:pilot_refresh/admin/another_token_class.dart';

class C_BottomNavBaseScreen extends StatefulWidget {
  final bool? isDoubleScreenSelected;
  final bool? isSingleScreenSelected;
  final String? token;
  final bool? isLogedIn;
  final bool? isCustomerDetails;

  const C_BottomNavBaseScreen({
    Key? key,
    this.isDoubleScreenSelected,
    this.isSingleScreenSelected,
    this.token,
    this.isLogedIn,
    this.isCustomerDetails = false,
  }) : super(key: key);

  @override
  _C_BottomNavBaseScreenState createState() => _C_BottomNavBaseScreenState();
}

class _C_BottomNavBaseScreenState extends State<C_BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;
  late String tokeno;

  @override
  initState() {
    super.initState();
    print("i am bottom nav base screen token is ${widget.token}");

    setState(() {
      tokeno = widget.token ?? '';
    });

    // Check if widget.isDoubleScreenSelected and widget.isSingleScreenSelected are not null
    if (widget.isDoubleScreenSelected != null &&
        widget.isSingleScreenSelected != null) {
      // Set the default index based on the selected screen type
      _selectedScreenIndex = widget.isDoubleScreenSelected!
          ? 0
          : widget.isSingleScreenSelected!
              ? 1
              : 0;
    } else {
      // Handle the case where either widget.isDoubleScreenSelected or widget.isSingleScreenSelected is null
      // You may want to set a default value or handle this case differently based on your requirements.
      _selectedScreenIndex = 0;
    }
    getToken();
  }

  Future getToken() async {
    String? token = await GlobalVariables.authToken;
    print('token Global $token');
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
                    screen is C_AdminDoublVehicle
                        ? 'assets/images/two_car1.png'
                        : 'assets/images/car.png',
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                  label: screen is C_AdminDoublVehicle
                      ? "Double Screen"
                      : "Single Screen",
                ))
            .toList(),
      ),
    );
  }

  List<Widget> get _screens {
    return [
      C_AdminDoublVehicle(),
      C_HomeVehicle(),
    ];
  }
}
