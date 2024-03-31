import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university_app_latest/detail.dart';
import 'package:university_app_latest/login.dart';
import 'package:university_app_latest/universtiy.dart';

import 'database/sortedUniversities.dart';

class homescreen extends StatefulWidget {
  String countryName = "";
  homescreen(this.countryName);
  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  TextStyle listTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.purple,
  );
  bool loading = true;

  @override
  void initState() {
    getdata();
    super.initState();
    loading = false;
  }

  List<university> unidata = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select University'),
        centerTitle: true,
        elevation: 5.0,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => sortedUniversities(),
                    ));
              },
              icon: Icon(
                Icons.playlist_add_check,
                // color: Colors.blue,
              ),
              iconSize: 30,
              padding: EdgeInsets.only()),
        ],
      ),
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: loading == false
                  ? Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          color: Colors.purpleAccent[300],
                          strokeWidth: 10,
                        ),
                      ),
                    )

                  // OR
                  : ListView.builder(
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: unidata.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                              child: InkWell(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${unidata[index].name}',
                                                    style: listTextStyle,
                                                  ),
                                                  Text(
                                                    '${unidata[index].state}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black54),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ]),
                                ),
                                onTap: () => move(unidata[index]),
                              ),
                            ),
                            Container(
                                height: 2,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 119, 87, 199))),
                          ],
                        );
                      })),
        ],
      )),
    );
  }

  getdata() async {
    var countryPointer = widget.countryName.toString();
    var url = Uri.parse(
        'http://universities.hipolabs.com/search?country=$countryPointer');
    var response = await http.get(url);
    List<dynamic> data = jsonDecode(response.body);
    if (mounted) {
      setState(() {
        unidata = university.getuniveritydata(data);
        loading = true;
      });
    }
  }

  move(university U) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => details(U)));
  }

  void logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const loginpage(),
        ),
        (Route<dynamic> route) => false);

    // await prefs.setBool('login', false);
    // await prefs.remove('login');
    // prefs.clear() delete all key value pairs
    // prefs.remove('LOGIN) delete single key value pairs
  }
}
