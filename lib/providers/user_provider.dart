import 'dart:convert';

import 'package:cinestream/data/models/user_model.dart';
import 'package:cinestream/data/services/auth_services.dart';
import 'package:cinestream/providers/navBar_provider.dart';
import 'package:cinestream/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernmaeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthServises authServises = AuthServises();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get securePassword => _securePassword;
  UserModel? userModel;
  bool _securePassword = true;
  void togglePassword() {
    _securePassword = !_securePassword;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      _isLoading = true;
      notifyListeners();
      userModel = await authServises.login(
        usernmaeController.text,
        passwordController.text,
        context,
      );
      notifyListeners();
      _isLoading = false;
    }
  }

  UserProvider() {
    loadData();
  }
  Future<void> logout(BuildContext context) async {
    final navProvider = Provider.of<NavProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogin');
    await prefs.remove('userData');
    await prefs.remove('favorite_movies');
    userModel = null;
    notifyListeners();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      navProvider.changeIndex(0);
    }
  }

  Future loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("userData");
    if (data != null) {
      print(data);
      dynamic da = jsonDecode(data);
      userModel = UserModel.fromJson(da);
      notifyListeners();
    } else {
      userModel = null;
    }
  }

  void clearControllers() {
    usernmaeController.value = TextEditingValue();
    passwordController.value = TextEditingValue();
  }
}
