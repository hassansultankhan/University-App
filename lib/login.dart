import 'package:flutter/material.dart';
import 'package:university_app_latest/List.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/sortedUniversities.dart';

class loginpage extends StatefulWidget {
  const loginpage();

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  // String countryName = "Pakistan";
  @override
  void initState() {
    logincheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UNIVERSITY TRACER'),
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
              icon: const Icon(
                Icons.playlist_add_check,
                // color: Colors.white,
              ),
              iconSize: 35,
              padding: EdgeInsets.only()),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/main background.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          children: [
            // Padding(padding:EdgeInsets.only(top: 100),
            Container(
              height: 50,
            ),
            Text("Your ultimate guide to\nuniversities around the world",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple[700],
                )),

            Container(
              height: 300,
            ),
            ElevatedButton(
              onPressed: () => login(),
              child: Text(
                'Select Country',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('login', true);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => countries(),
        ),
        (route) => false);
  }

  void logincheck() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool test = await pref.getBool('login') ?? false;
    if (test) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => countries(),
          ),
          (route) => false);
    }
  }
}
