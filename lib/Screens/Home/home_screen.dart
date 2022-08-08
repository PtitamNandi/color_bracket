import 'dart:convert';
import 'package:color_bracket/Screens/Details/details_screen.dart';
import 'package:color_bracket/Screens/Login/Login_screen.dart';
import 'package:color_bracket/common/widget/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var LoginDecoded;
  getUser() async {
    String url = 'https://retoolapi.dev/GFHqAV/getemployees';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    }
  }

  getStoredData() async {
    // print('hi');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var logedindata = prefs.getString('singinkey-CB');
    LoginDecoded = jsonDecode(logedindata!);

    // print(LoginDecoded['id']);
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('singinkey-CB');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStoredData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(4, 9, 35, 1),
        title: const Center(
          child: Text(
            'Employees',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              remove();
            },
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.4, 0.5],
            colors: [
              Color.fromRGBO(4, 9, 35, 1),
              Color.fromRGBO(39, 105, 171, 1),
            ],
          ),
        ),
        child: FutureBuilder(
          future: getUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong"));
              }
              if (snapshot.hasData) {
                var data = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return data[index]['company_logo'] == null
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    empid: data[index]['id'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              height: 120,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    height: 110,
                                    width: 90,
                                    child: Image.network(
                                      data[index]['company_logo'],
                                      fit: BoxFit.contain,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Text('ð¢');
                                      },
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${data[index]['name']}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${data[index]['company']}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${data[index]['designation']}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            // color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.keyboard_arrow_right,
                                      color: Colors.black, size: 30.0),
                                ],
                              ),
                            ),
                          );
                  },
                );
              }
            }
            return shimmerLoading();
          },
        ),
      ),
    );
  }
}
