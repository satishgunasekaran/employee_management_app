import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TrumpCard extends StatefulWidget {
  var reason;
  var startDate;
  var endDate;
  var noOfDays;
  var leaveid;
  var status;

  TrumpCard(
      {reason, noOfDaysn, noOfDays, startDate, endDate, leaveid, status}) {
    this.reason = reason;
    this.noOfDays = noOfDays;
    this.startDate = startDate;
    this.endDate = endDate;
    this.leaveid = leaveid;
    this.status = status;
  }

  @override
  State<TrumpCard> createState() => _TrumpCardState();
}

class _TrumpCardState extends State<TrumpCard> {
  final databaseReference = FirebaseDatabase.instance.reference();
  User? current_user = FirebaseAuth.instance.currentUser;
  var gapSize = 20.0;

  Map data = {};

  var readingText = TextStyle(
    fontFamily: 'Lexend Deca',
    color: Color(0xFF090F13),
    fontSize: 22,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x25000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              child: Container(
                width: 4,
                height: 400,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(46, 49, 140, 1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leave Id\n',
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${widget.leaveid}',
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Date : ${widget.startDate}',
                              style: readingText,
                            ),
                            SizedBox(
                              height: gapSize,
                            ),
                            Text(
                              'End Date : ${widget.endDate}',
                              style: readingText,
                            ),
                            SizedBox(
                              height: gapSize,
                            ),
                            Text(
                              'Number of Days: ${widget.noOfDays}',
                              style: readingText,
                            ),
                            SizedBox(
                              height: gapSize,
                            ),
                            Text(
                              'Reason: ${widget.reason}',
                              style: readingText,
                            ),

                            SizedBox(height: 20,),
                            MaterialButton(
                              
                              color: Colors.red,
                              onPressed: () {
                                databaseReference
                                    .child("${current_user!.uid}")
                                    .child("${widget.leaveid}")
                                    .remove();

                                Fluttertoast.showToast(
                                    msg: "Leave Request deleted, kindly refresh application");
                              },
                              child: Text(
                                "Delete Request",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              // minWidth: 200,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                widget.status
                                    ? Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                      )
                                    : Container(),
                                Text(
                                  '${!widget.status ? " Pending" : " Approved"}',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: !widget.status
                                        ? Colors.red
                                        : Colors.green,
                                    fontSize: 30,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 28, horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
