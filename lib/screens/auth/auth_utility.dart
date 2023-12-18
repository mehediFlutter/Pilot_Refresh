import 'dart:convert';
import 'package:pilot_refresh/screens/auth/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtility {

  static LoginModel userInfo = LoginModel();

  AuthUtility._();
 static Future<void> saveUserInfo(LoginModel model) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.setString('user-data', jsonEncode(model.toJson()));
      userInfo = model;
  }
    
  static  Future<LoginModel> getUserInfo() async{
      SharedPreferences _sharedPrefs = await SharedPreferences.getInstance(); 
     String value = _sharedPrefs.getString('user-data')!;
     return LoginModel.fromJson(jsonDecode(value));
   
    }

 static Future<void> clearUserInfo() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
  }

 static Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    bool isLogin =  _sharedPrefs.containsKey('user-data');
    if(isLogin){
     userInfo = await getUserInfo();
    }
    return isLogin;
  }
}