import 'package:flutter/cupertino.dart';
import 'package:fluttervitualdoctor/AssessmentDetails.dart';
import 'package:fluttervitualdoctor/Appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Schedule extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _MyScheduleState createState() => _MyScheduleState();
}


class _MyScheduleState extends State<Schedule>  {

  //static Color color = HexColor('#f05b60');
  static List<String> arrays= ['123','4gt'];
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');

  static DateTime now = DateTime.now();
  static String formattedDate = DateFormat('EEEE d MMM, ''yyyy').format(now);



  static Widget buildItem(BuildContext context, String array) {
    return
    Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child:
      ClipRRect(
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
                              child: Text('Time Slot', style: TextStyle(color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      Text('12:00 to 13:00', style: TextStyle(color:Colors.white,)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 10, 5, 20),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            FlatButton(
                              color: Colors.white,
                              shape: CircleBorder(side: BorderSide(width: 2, color: Colors.lightBlueAccent, style: BorderStyle.solid)),
                              child: Text('6', style: TextStyle(color: Colors.lightBlueAccent),),
                            ),
                            Text(
                              'Total Appointments', style: TextStyle(color: Colors.lightBlueAccent),textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            FlatButton(
                              color: Colors.white,
                              shape: CircleBorder(side: BorderSide(width: 2, color: Colors.lightBlueAccent, style: BorderStyle.solid)),
                              child: Text('6', style: TextStyle(color: Colors.lightBlueAccent),),
                            ),
                            Text(
                              'Available Appointments', style: TextStyle(color: Colors.lightBlueAccent), textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            FlatButton(
                              color: Colors.white,
                              shape: CircleBorder(side: BorderSide(width: 2, color: Colors.lightBlueAccent, style: BorderStyle.solid)),
                              child: Text('0', style: TextStyle(color: Colors.lightBlueAccent),),
                            ),
                            Text(
                              'Booked Appointments', style: TextStyle(color: Colors.lightBlueAccent),textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          )
      )
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
          title: Text('Assessment Details', style: TextStyle(color: Colors.white),),
          backgroundColor: tabBarColor,),
        body: Container(
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
