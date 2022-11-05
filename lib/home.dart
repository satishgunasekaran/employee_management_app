import 'package:employee_management/status.dart';
import 'package:employee_management/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController startdateinput = TextEditingController();
  TextEditingController enddateinput = TextEditingController();
  TextEditingController reasoninput = TextEditingController();
  int _selectedIndex = 0;
  int noOfDays = 0;
  var uid = new Uuid();
  final databaseReference = FirebaseDatabase.instance.reference();
  User? current_user = FirebaseAuth.instance.currentUser;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    StatusScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    startdateinput.text = ""; //set the initial value of text field
    enddateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Service Portal'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          height: 700,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //
              TextField(
                controller: reasoninput,
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Reason',
                ),
              ),
              TextField(
                controller:
                    startdateinput, //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Start Date" //label text of field
                    ),
                // readOnly:
                //     true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    // print(
                    //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    // print(
                    //     formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      startdateinput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),

              TextField(
                controller: enddateinput, //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "End Date" //label text of field
                    ),
                // readOnly:
                //     true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    // print(
                    //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    // print(
                    //     formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      enddateinput.text =
                          formattedDate; //set output date to TextField value.
                      DateTime startDate =
                          DateTime.parse(startdateinput.value.text);
                      DateTime endDate =
                          DateTime.parse(enddateinput.value.text);
                      ;
                      print("start date ${startDate}");
                      noOfDays = (endDate.difference(startDate).inDays) + 1;
                      print("Boomer Karthi : ${noOfDays}");
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              SizedBox(
                height: 50,
              ),

              Text('Number of Days: ${noOfDays}', textAlign: TextAlign.left),
              SizedBox(height: 25),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  databaseReference
                      .child("${current_user?.uid}")
                      .child(uid.v1())
                      .set({
                    'startdate': startdateinput.value.text,
                    'enddate': enddateinput.value.text,
                    'noOfDays': noOfDays,
                    'reason': reasoninput.text,
                    "status": false,
                  });
                  Fluttertoast.showToast(
                      msg: "Application successfully submitted");
                  startdateinput.clear();
                  enddateinput.clear();
                  reasoninput.clear();
                  setState(() {
                    noOfDays = 0;
                  });
                },
                child: Text(
                  "Apply",
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
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => StatusScreen()));
                },
                child: Text(
                  "View Status",
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
