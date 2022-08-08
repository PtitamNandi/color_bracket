import 'package:color_bracket/Screens/Home/home_screen.dart';
import 'package:color_bracket/Screens/Login/Login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var finalLogin;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getValidation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var logedindata = (prefs.getString('singinkey-CB'));
    setState(() {
      finalLogin = logedindata;
    });
  }

  @override
  void initState() {
    super.initState();
    getValidation().whenComplete(() => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                finalLogin == null ? LoginScreen() : HomeScreen(),
          ),
        ));
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('singinkey-CB');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
