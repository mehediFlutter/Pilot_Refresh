import 'package:flutter/material.dart';
import 'package:pilot_refresh/screens/bottom_nav_base-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarchentDashBoard extends StatefulWidget {
  const MarchentDashBoard({super.key});

  @override
  State<MarchentDashBoard> createState() => _MarchentDashBoardState();
}

class _MarchentDashBoardState extends State<MarchentDashBoard> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF313131),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      shadowColor: Colors.black,
                      elevation: 15,
                      color: Color(0xFF313131),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xFF313131),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
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
                            child: Text(
                              "Double",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 30,
                      shadowColor: Colors.black,
                      color: Color(0xFF313131),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xFF313131),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
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
                            child: Text(
                              "Single",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                shadowColor: Colors.black,
                elevation: 30,
                color: Color(0xFF313131),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFF313131),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                      onPressed: () {
                        print("Double pressed");
                      },
                      child: Text(
                        "List",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 50,
                  surfaceTintColor: Colors.black,
                  shadowColor: Colors.black,
                  color: Color(0xFF313131),
                  child: Container(
                    //height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFF313131),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                        onPressed: () {
                          print("Previewww pressed");
                        },
                        child: Text(
                          "Previewwww",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
