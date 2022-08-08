import 'dart:convert';

import 'package:color_bracket/Screens/Login/services/openURL.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
class DetailsScreen extends StatelessWidget {
  final int empid;
  DetailsScreen({Key? key, required this.empid}) : super(key: key);
  OpenURL openURL = OpenURL();

  getEmpDetails() async {
    String url = 'https://retoolapi.dev/H2F0Ui/getemployedetail?id=$empid';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: getEmpDetails(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(4, 9, 35, 1),
                          Color.fromRGBO(39, 105, 171, 1),
                        ],
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 73),
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spacebetween,
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    // AntDesign.arrowleft,
                                    color: Colors.white,
                                  ),
                                ),
                                // Icon(
                                //   Icons.logout,
                                //   // AntDesign.logout,
                                //   color: Colors.white,
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Company\nProfile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontFamily: 'Nisebuschgardens',
                              ),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(20)),
                                  child: Image.network(
                                    data[0]['company_logo'],
                                    // 'assets/img/profile.png',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.43,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  double innerHeight = constraints.maxHeight;
                                  double innerWidth = constraints.maxWidth;
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        top: 30,
                                        child: Container(
                                          height: innerHeight * 0.90,
                                          width: innerWidth,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 80,
                                              ),
                                              Text(
                                                data[0]['name'],
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      39, 105, 171, 1),
                                                  fontFamily: 'Nunito',
                                                  fontSize: 37,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Company Name',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontFamily: 'Nunito',
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        data[0]['company'],
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              39, 105, 171, 1),
                                                          fontFamily: 'Nunito',
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 25,
                                                      vertical: 20,
                                                    ),
                                                    child: Container(
                                                      height: 50,
                                                      width: 3,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Ratings',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontFamily: 'Nunito',
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        data[0]['rating'],
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              39, 105, 171, 1),
                                                          fontFamily: 'Nunito',
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Visit us on',
                                                    style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontFamily: 'Nunito',
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      openURL.launchURLApp(
                                                          data[0]['view_more']);
                                                    },
                                                    child: Text(
                                                      data[0]['view_more'],
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            39, 105, 171, 1),
                                                        fontFamily: 'Nunito',
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   top: 110,
                                      //   right: 20,
                                      //   child: Icon(
                                      //     Icons.settings,
                                      //     // AntDesign.setting,
                                      //     color: Colors.grey[700],
                                      //     size: 30,
                                      //   ),
                                      // ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: height * 0.3,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Job Descripton',
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontSize: 27,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2.5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      height: height * 0.18,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        data[0]['job_descripton'],
                                        style: TextStyle(fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // Container(
                                    //   height: height * 0.15,
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.grey,
                                    //     borderRadius: BorderRadius.circular(30),
                                    //   ),
                                    //   child: Text(
                                    //     data[0]['interests'],
                                    //     style: TextStyle(fontSize: 20),
                                    //     overflow: TextOverflow.ellipsis,
                                    //     // maxLines: 4,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          }
          return Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()));
        });
  }
}
