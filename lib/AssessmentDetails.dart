import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttervitualdoctor/Dashboard.dart';
import 'package:fluttervitualdoctor/main.dart';

class AssessmentDetail extends StatefulWidget {
  const AssessmentDetail({Key key, this.appid}) : super(key: key);

  static String tag = 'assessment-page';
  final String appid;

  @override
  _AssessmentDetailState createState() => new _AssessmentDetailState(appid: appid);
}

class _AssessmentDetailState extends State<AssessmentDetail> {

  _AssessmentDetailState({Key key, @required this.appid});
  final String appid;
  static String appointment_id, complaint, bp, temp,oxysaturation, gRandom, gFasting;
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appointment_id=appid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Assessment Details', style: TextStyle(color: Colors.white),),
        backgroundColor: tabBarColor,),
      body:
          new StreamBuilder(
        stream: Firestore.instance.collection("appointment")
            .where('id', isEqualTo: appid)
            .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(child: Text("NO DATA"));
      } else {
      //DocumentSnapshot item = snapshot.data.documents;
      for (DocumentSnapshot doc in snapshot.data.documents) {
        if(doc['patTemp'] == ""){
          temp='Nil';
        }
        else{
          temp=doc['patTemp'];
        }

        if(doc['patBP'] == ""){
          bp='Nil';
        }
        else{
          bp=doc['patBP'];
        }
        if(doc['patComplaint'] == ""){
          complaint='Nil';
        }
        else{
          complaint=doc['patComplaint'];
        }
        if(doc['patOxS'] == ""){
          oxysaturation='Nil';
        }
        else{
          oxysaturation=doc['patOxS'];
        }
        if(doc['patGVFasting'] == ""){
          gFasting='Nil';
        }
        else{
          gFasting=doc['patGVFasting'];
        }
        if(doc['patGVRandom'] == ""){
          gRandom='Nil';
        }
        else{
          gRandom=doc['patGVRandom'];
        }

        return       Padding(padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
            child:
            ListView(children: [
              ClipRRect(borderRadius:new BorderRadius.all(new Radius.circular(15.0)),
                  child:
                  Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(12, 20, 12, 6),
                                      child: Text('Chief compliants', style: TextStyle(color: Colors.grey)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(12, 6, 12, 20),
                                      child: Text(complaint),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  )
              ),
              SizedBox(height: 24.0),
              Text('Vital Signs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 24.0),
              ClipRRect(borderRadius:new BorderRadius.all(new Radius.circular(15.0)),
                  child:
                  Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(12, 20, 12, 6),
                                      child: Text('Blood pressure', style: TextStyle(color: Colors.grey)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(12, 6, 12, 20),
                                      child: Text(bp),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  )
              ),

              SizedBox(height: 24.0),
              ClipRRect(borderRadius:new BorderRadius.all(new Radius.circular(15.0)),
                  child:
                  Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(12, 20, 12, 6),
                                      child: Text('Oxygen saturation', style: TextStyle(color: Colors.grey)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(12, 6, 12, 20),
                                      child: Text(oxysaturation),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  )
              ),

              SizedBox(height: 24.0),
              ClipRRect(borderRadius:new BorderRadius.all(new Radius.circular(15.0)),
                  child:
                  Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(12, 20, 12, 6),
                                      child: Text('Temperature', style: TextStyle(color: Colors.grey)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(12, 6, 12, 20),
                                      child: Text(temp),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  )
              ),

              SizedBox(height: 24.0),


              ClipRRect(borderRadius:new BorderRadius.all(new Radius.circular(15.0)),
                  child:
                  Column(
                      children: [
                        Container(
                            color: Colors.white,
                            child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Text('Glucose value (mg/dl)', style: TextStyle(color: Colors.red, ), textAlign: TextAlign.center,),
                                  SizedBox(height: 10,),
                                  Divider(height: 1, color: Colors.grey,),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(12, 20, 12, 6),
                                              child: Text('Random', style: TextStyle(color: Colors.grey)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(12, 6, 12, 20),
                                              child: Text(gRandom),
                                            ),

                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(12, 20, 12, 6),
                                              child: Text('Fasting', style: TextStyle(color: Colors.grey)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(12, 6, 12, 20),
                                              child: Text(gFasting),
                                            ),

                                          ],
                                        ),
                                      ),

                                    ],

                                  ),
                                ] //children
                            )
                        ),

                      ]
                  )
              ),

            ],
            )
        );
      }


    }
    }
          )

    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

