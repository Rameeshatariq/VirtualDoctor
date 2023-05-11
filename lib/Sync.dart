import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttervitualdoctor/Profile.dart';
import 'package:fluttervitualdoctor/Prescription.dart';
import 'package:fluttervitualdoctor/main.dart';

class Sync extends StatefulWidget {
  static String tag = 'sync-page';

  @override
  _SyncState createState() => new _SyncState();
}

class _SyncState extends State<Sync> {
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Sync Data', style: TextStyle(color: Colors.white),),
          backgroundColor: tabBarColor,),
        body:

        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            height: double.maxFinite,
            child: ListView(
              children: [
                new GestureDetector(
                  onTap: ()=> {},
                  child: SizedBox(
                    height: 170,
                    width:  double.infinity,
                    child: new Card(
                      elevation: 4,
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
                              Icons.shopping_cart,
                              size: 60,
                              color: Colors.lightBlueAccent,
                            ),
                            SizedBox(height: 10,),
                            Text('Sync Pharmacy', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20
                            ),),
                            SizedBox(height: 10,),
                            Text('The Pharmacy dictonary is synced.', style: TextStyle(color: Colors.grey,
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                new GestureDetector(
                  onTap: ()=> {},
                  child: SizedBox(
                    height: 170,
                    width:  double.infinity,
                    child: new Card(
                      elevation: 4,
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
                              Icons.colorize,
                              size: 60,
                              color: Colors.lightBlueAccent,
                            ),
                            SizedBox(height: 10,),
                            Text('Sync Laboratory', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20
                            ),),
                            SizedBox(height: 10,),
                            Text('The Laboratory dictonary is synced.', style: TextStyle(color: Colors.grey,
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                new GestureDetector(
                  onTap: ()=> {},
                  child: SizedBox(
                    height: 170,
                    width:  double.infinity,
                    child: new Card(
                      elevation: 4,
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
                              Icons.rate_review,
                              size: 60,
                              color: Colors.lightBlueAccent,
                            ),
                            SizedBox(height: 10,),
                            Text('Sync Radiology', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20
                            ),),
                            SizedBox(height: 10,),
                            Text('The Radiology dictonary is synced.', style: TextStyle(color: Colors.grey,
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
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

