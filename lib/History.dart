import 'package:flutter/cupertino.dart';
import 'package:fluttervitualdoctor/AssessmentDetails.dart';
import 'package:fluttervitualdoctor/Appointment.dart';
import 'package:fluttervitualdoctor/Schedule.dart';
import 'package:fluttervitualdoctor/Sync.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {

  @override
  _HistoryState createState() => _HistoryState();
}


class _HistoryState extends State<History>  {

  //static Color color = HexColor('#f05b60');
  static List<String> arrays= ['123','4gt', 'hh','kk'];
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');
  static Color navColor = HexColor('#333333');

  static DateTime now = DateTime.now();
  static String formattedDate = DateFormat('EEEE d MMM, ''yyyy').format(now);
  

  static Widget buildItem(BuildContext context, String array) {
    return

    Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child:       ClipRRect(
          borderRadius:
          new BorderRadius.all(new Radius.circular(15.0)),
          child:
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(7, 2, 7, 2),
                  color: rowColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('Appointment Time', style: TextStyle(color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      Text('13:00', style: TextStyle(color:Colors.white,)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'John Ochleng',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ), /*3*/],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 130,
                            margin: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child:
                            Row(
                              children: [
                                Icon(Icons.supervised_user_circle, color: Colors.grey,),
                                Text(' MR# 401-44-45',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      wordSpacing: 2
                                  ),
                                ),
                              ],
                            )
                            ,
                          ),
                          Container(
                            width: 130,
                            margin: const EdgeInsets.fromLTRB(40, 2, 5, 2),
                            child:
                            Row(
                              children: [Icon(Icons.phone, color: Colors.grey,),
                                Text(' Phone 0335-1345267',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      wordSpacing: 2
                                  ),
                                ),],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 130,
                            margin: const EdgeInsets.fromLTRB(10, 0, 5, 2),
                            child:
                            Row(
                              children: [
                                Icon(Icons.group, color: Colors.grey,),
                                Text(' Gender Male', style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    wordSpacing: 2
                                ),
                                ),
                              ],
                            )
                            ,
                          ),
                          Container(
                            width: 130,
                            margin: const EdgeInsets.fromLTRB(40, 0, 5, 2),
                            child:
                            Row(
                              children: [
                                Icon(Icons.ac_unit, color:Colors.grey),
                                Text(' Age 29',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      wordSpacing: 2
                                  ),),],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: ButtonTheme(
                      minWidth: double.infinity, // match_parent
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      child:     FlatButton(
                        color: buttonColor,
                        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        onPressed: () => {},
                        child: Text('View Detail',style: TextStyle(color: Colors.white),),
                      ),
                    )
                )
              ],
            ),
          )
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('History', style: TextStyle(color: Colors.white),),
          backgroundColor: tabBarColor,),
        body:
        Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                color: buttonColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white,),
                    Text("  "+formattedDate, style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              Expanded(
                  child:
                  ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) => buildItem(context, arrays[index]),
                    itemCount: arrays.length,
                  )
              )
            ],
          ),
        ),
      ),
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
