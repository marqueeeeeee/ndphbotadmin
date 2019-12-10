import 'package:flutter/material.dart';
import 'package:ndph_xmas_admin/features/admin_settings/presentation/admin_settings_page.dart';
import 'package:ndph_xmas_admin/features/home_page/presentation/home_page.dart';
import 'package:ndph_xmas_admin/features/login/presentation/login_page.dart';
import 'package:ndph_xmas_admin/features/users/presentation/add_user_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/addUser': (context) => AddUserPage(),
        '/adminSettings': (context) => AdminSettingsPage()
      },
    );
  }
}

