import 'dart:ffi';

import 'package:employee_management/progress.dart';
import 'package:employee_management/trumpcard.dart';
import 'package:employee_management/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

import 'home.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  int _selectedIndex = 0;
  bool _isLoading = true;

  final databaseReference = FirebaseDatabase.instance.reference();
  User? current_user = FirebaseAuth.instance.currentUser;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    StatusScreen()
  ];

  late List<TrumpCard> _trumpCards = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getPolls();
  }

  getPolls() async {
    // var data = databaseReference..get();
    // print(data);
    // databaseReference.child("${current_user?.uid}").once().then((snapshot) async {
    //   // polls = _parseData(snapshot);
    //   // ignore: avoid_print
    //   print(snapshot);
    // });

    DatabaseEvent event =
        await databaseReference.child("${current_user?.uid}").once();
    print(event.snapshot.value);
    late Map<dynamic, dynamic>? leaves;
    if (event.snapshot.value != null) {
      leaves = event.snapshot.value as Map;
    } else {
      leaves = null;
    }
    if (leaves != null)
      leaves.forEach((k, v) {
        _trumpCards.add(TrumpCard(
            reason: v["reason"],
            noOfDays: v["noOfDays"],
            startDate: v["startdate"],
            endDate: v["enddate"],
            leaveid: k,
            status: v["status"]));
      });

    setState(() {
      _isLoading = false;
    });
  }

  // List<Map> logs = [];
  // for (var item in leaves.keys()) {
  //   print(leaves[item]);
  //   logs.add(leaves[item]);
  // }

  // List<Poll> _parseData(DataSnapshot dataSnapshot) {
  //   var companyList = <Poll>[];
  //   var mapOfMaps = Map<String, dynamic>.from(dataSnapshot.value);

  //   mapOfMaps.values.forEach((value) {
  //     companyList.add(Poll.fromJson(Map.from(value)));
  //   });
  //   return companyList;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Service Portal'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _trumpCards.length != 0
                        ? SingleChildScrollView(
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount: _trumpCards.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _trumpCards[index];
                                }))
                        : const Center(child: Text('No Leaves Taken')),
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        "Apply for leave",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                  ],
                )),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.edit),
      //       label: 'Apply',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.start),
      //       label: 'Status',
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: Icon(Icons.school),
      //     //   label: 'School',
      //     // ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Color.fromRGBO(46, 49, 140, 1),
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
