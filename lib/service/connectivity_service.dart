import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService with ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey;
  bool _isDeviceConnected = false;
  bool _isAlertShown = false;

  ConnectivityService(this.navigatorKey) {
    _checkConnectivity();
    _listenForChanges();
  }

  // Check initial connectivity
  Future<void> _checkConnectivity() async {
    _isDeviceConnected = await InternetConnectionChecker().hasConnection;
    _showAlertDialogIfNeeded();
  }

  // Listen for connectivity changes
  void _listenForChanges() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      _isDeviceConnected = await InternetConnectionChecker().hasConnection;
      _showAlertDialogIfNeeded();
    });
  }

  // Show alert dialog if needed
  void _showAlertDialogIfNeeded() {
    if (!_isDeviceConnected && !_isAlertShown) {
      _isAlertShown = true;
      showDialog(
        context: navigatorKey.currentContext!, // Use global navigator key (see later)
        builder: (context) => AlertDialog(
          title: Center(
            child: Text('No Internet Connection'),
          ),
          content: Text('Please check your internet connectivity.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _isAlertShown = false;
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
