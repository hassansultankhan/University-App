import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:university_app_latest/database/dbfiles.dart';
import 'package:university_app_latest/webview.dart';

class sortedUniversities extends StatefulWidget {
  const sortedUniversities();

  @override
  State<sortedUniversities> createState() => _sortedUniversitiesState();
}

class _sortedUniversitiesState extends State<sortedUniversities> {
  int universityCount = 0;
  List UniversityList = [];
  var dbfiles = Dbfiles();

  final List<int> _list = List.generate(50, (i) => i);
  final List<bool> _selected = List.generate(50, (i) => false);

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text("Selected Universities"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            },
            icon: Icon(
              Icons.refresh_rounded,
            ),
            iconSize: 25,
            padding: EdgeInsets.only(right: 25),
          ),
        ],
      ),
      body: buildUniversityList(),
    );
  }

  ListView buildUniversityList() {
    return ListView.builder(
        padding: EdgeInsets.only(top: 15),
        itemCount: universityCount,
        itemBuilder: (BuildContext context, int countNumber) {
          return Card(
            child: InkWell(
              child: ListTile(
                tileColor: _selected[countNumber]
                    ? Color.fromARGB(255, 134, 194, 243)
                    : Color.fromARGB(255, 210, 225, 250),
                title: Text(
                  this.UniversityList[countNumber].name,
                  style: TextStyle(color: Colors.purple),
                ),
                subtitle: Text(
                  this.UniversityList[countNumber].url +
                      " Serial:" +
                      this.UniversityList[countNumber].id.toString(),
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Container(
                  child: InkWell(
                    child: Icon(
                      Icons.delete,
                      color: Colors.blueGrey,
                      size: 35,
                    ),
                    onTap: (() {
                      remove(UniversityList[countNumber].id);
                    }),
                  ),
                ),
                onTap: () {
                  setState(
                      () => _selected[countNumber] = !_selected[countNumber]);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => webview_widget(
                            UniversityList[countNumber].url,
                            UniversityList[countNumber].name),
                      ));
                },
              ),
            ),
          );
        });
  }

  void getdata() async {
    var universitiesFuture = dbfiles.getuniversities();
    universitiesFuture.then((data) {
      setState(() {
        this.UniversityList = data;
        universityCount = data.length;
      });
    });
  }

  remove(int count) async {
    await dbfiles.delete(count);
    getdata();
  }
}
