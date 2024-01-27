// token_provider.dart
import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  setToken(String? newToken) {
    _token = newToken;
    notifyListeners();
  }
}
