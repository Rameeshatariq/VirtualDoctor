import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttervitualdoctor/Profile.dart';
import 'package:fluttervitualdoctor/Prescription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:fluttervitualdoctor/main.dart';

class Appointment extends StatefulWidget {
  static String tag = 'assessment-page';
  final String patid;
  const Appointment({Key key, this.patid}) : super(key: key);

  @override
  _AppointmentState createState() => new _AppointmentState(patid: patid);
}

class _AppointmentState extends State<Appointment> {
  final String patid;
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');
  static String gender;
  _AppointmentState({Key key, @required this.patid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Appointmnet', style: TextStyle(color: Colors.white),),
          backgroundColor: tabBarColor,),
        body:
        new StreamBuilder(
        stream: Firestore.instance.collection("patient")
        .where('id', isEqualTo: patid)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Container(width: 0.0, height: 0.0,);
      }
      else if(snapshot.hasError){
        return Container(width: 0.0, height: 0.0,);
      }
      else {
        //DocumentSnapshot item = snapshot.data.documents;
        for (DocumentSnapshot doc in snapshot.data.documents) {
          if(doc['gender'] == 1){
            gender='Male';
          }
          else if(doc['gender'] == 2){
            gender='Female';
          }
          else{
            gender= 'Unknown';
          }

          return     Container(
              height: double.maxFinite,
              child: new Stack(
                  children: <Widget>[
                    Column(
                        children: [
                          SizedBox(height: 20,),
                          Row(

                              children: [
                                Container(child:
                                doc['imageURL'] != ""
                                    ? CachedNetworkImage(

                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                                    ),
                                    width: 70.0,
                                    height: 70.0,
                                    padding: EdgeInsets.all(15.0),
                                  ),

                                  imageUrl: doc['imageURL'],
                                  width: 70.0,
                                  height: 70.0,
                                  fit: BoxFit.cover,
                                ): Icon(
                                  Icons.account_circle,
                                  size: 70.0,
                                  color: Colors.lightBlueAccent,
                                ),
                                ),
                                /*Icon(Icons.supervised_user_circle,size: 70, color: Colors.lightBlueAccent,)
                                ),*/
                                Expanded(
                                    child:
                                    Column(
                                      children: [
                                        Container(
                                            child:
                                            Row(
                                                children: [
                                                  Text(doc['fullName'] , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 15),
                                                    textAlign: TextAlign.right,),
                                                ]
                                            )
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                            child:Row(
                                              children: [
                                                Container(
                                                    width: 100,
                                                    child:Text(' MR# '+ doc['MRNo'],style: TextStyle(color: Colors.grey,fontSize: 10,wordSpacing: 2),)
                                                ),
                                                SizedBox(width: 10,),
                                                Container(
                                                  width: 150,
                                                  child: Text(' Phone ' + doc["cellPhone"],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                        wordSpacing: 2
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                            child:Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text(' Gender '+gender, style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                      wordSpacing: 2
                                                  ),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Container(
                                                  width: 100,
                                                  child:Text(' Age ' + calculateAge(doc['dob']).toString() + ' years',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                        wordSpacing: 2
                                                    ),),
                                                )
                                              ],
                                            )
                                        )

                                      ],
                                    )
                                ),
                                SizedBox(height: 20,)
                              ]
                          ),
                          SizedBox(height: 15,),
                          Divider(color: Colors.grey, height: 1,),

                          Column(
                              children: [
                                SizedBox(height: 40,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    new GestureDetector(
                                      onTap: ()=> {},
                                      child: SizedBox(
                                        height: 120,
                                        width:  150,
                                        child: new Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0)),
                                          shadowColor: Colors.grey,
                                          child:
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment:  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.video_call,
                                                  size: 40,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                Text('Video Call', style: TextStyle(color: Colors.lightBlueAccent,
                                                ),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    new GestureDetector(
                                        onTap: ()=> {},
                                        child:
                                        SizedBox(
                                          height: 120,
                                          width:  150,
                                          child:
                                          new Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0)),
                                            shadowColor: Colors.grey,
                                            child:
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment:  MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    size: 40,
                                                    color: Colors.lightBlueAccent,
                                                  ),
                                                  Text('Voice Call', style: TextStyle(color: Colors.lightBlueAccent,
                                                  ),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                    )

                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    new GestureDetector(
                                      onTap: ()=> {Navigator.push(context, MaterialPageRoute(builder: (context) => Prescription(drid:doc['doctorId'], patid: doc['patienId'])))},
                                      child:
                                      SizedBox(
                                          height: 120,
                                          width:  150,
                                          child:
                                          new Card(
                                            elevation: 10,
                                            shadowColor: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0)),
                                            child:
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment:  MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.receipt,
                                                    size: 40,
                                                    color: Colors.lightBlueAccent,
                                                  ),
                                                  Text('Prescription', style: TextStyle(color: Colors.lightBlueAccent,
                                                  ),)
                                                ],
                                              ),
                                            ),
                                          )
                                      ),
                                    ),
                                    new GestureDetector(
                                        onTap: ()=> {Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(patid: patid))),
                                        },
                                        child:
                                        SizedBox(
                                          height: 120,
                                          width:  150,
                                          child:
                                          new Card(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0)),
                                              shadowColor: Colors.grey,
                                              child:
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment:  MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.library_books,
                                                      size: 40,
                                                      color: Colors.lightBlueAccent,
                                                    ),
                                                    Text('Patient Profile', style: TextStyle(color: Colors.lightBlueAccent,
                                                    ),)
                                                  ],
                                                ),
                                              )
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ]

                          ),
                        ]),
                    new Container(
                        margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: new Align(
                            alignment: FractionalOffset.bottomCenter,
                            child:
                            ButtonTheme(
                                minWidth: double.infinity, // match_parent
                                //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:     FlatButton(
                                  color: tabBarColor,
                                  padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
                                  onPressed: () => {},
                                  child:
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.video_call, color: Colors.white,),
                                        SizedBox(width: 10,),
                                        Text('End Consultation',style: TextStyle(color: Colors.white),),
                                      ]
                                  ),
                                )
                            )
                        )
                    )
/*
                      Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: ButtonTheme(
                              minWidth: double.infinity, // match_parent
                           //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child:     FlatButton(
                                color: tabBarColor,
                                padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
                                onPressed: () => {},
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.video_call, color: Colors.white,),
                                SizedBox(width: 10,),
                                Text('End Consultation',style: TextStyle(color: Colors.white),),
                              ]
                              ),
                            )
                            )
                        )
*/
                  ]
              )
          );

        }
      }
    }
        )


    );

  }
  static calculateAge(String birthDate) {

    DateFormat df = DateFormat("yyyy-MM-dd");
    DateTime dt = df.parse(birthDate);

    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dt.year;
    int month1 = currentDate.month;
    int month2 = dt.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = dt.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
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

