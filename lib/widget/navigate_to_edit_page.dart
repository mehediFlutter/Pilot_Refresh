import 'package:flutter/material.dart';
import 'package:pilot_refresh/add_screen.dart';

class NavigationUtils {
  static void navigateToEditPage(BuildContext context, {
    required String vehicleName,
    required String price,
    required String registration,
    required String condition,
    required String mileage,
  }) {
    final route = MaterialPageRoute(
      builder: (context) => EditScreen(
        name: vehicleName,
        price: price,
       
      ),
    );
    Navigator.push(context, route);
  }

  // Add other navigation methods if needed
}