import 'dart:convert';
import 'package:color_bracket/Screens/Home/home_screen.dart';
import 'package:color_bracket/Screens/Login/services/openURL.dart';
import 'package:color_bracket/Screens/Login/widget/login_background.dart';
import 'package:color_bracket/constants.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userIDControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  OpenURL openURL = OpenURL();

  @override
  void dispose() {
    userIDControler.dispose();
    passwordControler.dispose();
    super.dispose();
  }

  CompleteLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
        'https://retoolapi.dev/B13laa/getusers?user_id=${userIDControler.text}&password=${passwordControler.text}';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      if (user.length != 0) {
        prefs.setString('singinkey-CB', jsonEncode(user[0]));
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen(),
          ),
        );
      } else {
        final snackBar = SnackBar(
          content: const Text('Wrong credentials'),
          backgroundColor: (Colors.black12),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: height + 100,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.deepPurpleAccent],
            ),
          ),
          child: Stack(
            children: [
              LoginBkg(),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => openURL
                                .launchURLApp('http://www.colorbracket.com/'),
                            child: Padding(
                                padding: EdgeInsets.all(90),
                                child: Image.asset("assets/images/logo.png")),
                          ),
                          const Text(
                            "Here to Get",
                            style: TextStyle(
                                fontSize: 45,
                                color: Color.fromARGB(255, 252, 253, 255)),
                          ),
                          const Text(
                            "Welcomed !",
                            style: TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(255, 226, 227, 237)),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyle(color: Colors.white),
                            controller: userIDControler,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Enter your User id'),
                            validator: (value) {
                              if (value!.isEmpty
                                  // !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  // .hasMatch(value)
                                  ) {
                                return 'enter correct user id';
                              } else
                                return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: passwordControler,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Enter your Password',
                                prefixIcon: Icon(Icons.password_outlined)),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty && value.length < 6) {
                                return 'Please enter correct password';
                              } else
                                return null;
                            },
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Material(
                                elevation: 5.0,
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(30.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    final isValidForm =
                                        formKey.currentState!.validate();
                                    if (isValidForm) {
                                      CompleteLogin();
                                    }
                                  },
                                  minWidth: 200.0,
                                  height: 42.0,
                                  child: const Text(
                                    "login",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
