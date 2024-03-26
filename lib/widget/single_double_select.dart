import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/bottom_nav_base-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleOrDouble extends StatefulWidget {
  const SingleOrDouble({Key? key}) : super(key: key);

  @override
  State<SingleOrDouble> createState() => _SingleOrDoubleState();
}

class _SingleOrDoubleState extends State<SingleOrDouble> {
  late bool isDoubleScreenSelected;

  @override
  void initState() {
    super.initState();
    // Load the saved value from shared preferences when the widget is initialized
    loadSelectedScreenType();
  }

  // Function to load the saved value from shared preferences
  Future<void> loadSelectedScreenType() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Use ?? to provide a default value in case the preference is not set
      isDoubleScreenSelected = prefs.getBool('isDoubleScreenSelected') ?? false;
    });
  }

  // Function to save the selected screen type to shared preferences
  Future<void> saveSelectedScreenType(bool isDouble) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDoubleScreenSelected', isDouble);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              isDoubleScreenSelected = true;
            });
            saveSelectedScreenType(true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBaseScreen(
                  isDoubleScreenSelected: true,
                  isSingleScreenSelected: false,
                ),
              ),
            );
          },
          child: Text("Double Screen"),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isDoubleScreenSelected = false;
            });
            saveSelectedScreenType(false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBaseScreen(
                  isDoubleScreenSelected: false,
                  isSingleScreenSelected: true,
                ),
              ),
            );
          },
          child: Text("Single Screen"),
        ),
      ],
    );
  }
}
