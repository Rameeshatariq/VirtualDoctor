import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttervitualdoctor/Profile.dart';
import 'package:fluttervitualdoctor/Detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:fluttervitualdoctor/main.dart';

class Reports extends StatefulWidget {
  static String tag = 'assessment-page';
  final String doctype;
  final String patid;

  const Reports({Key key, this.doctype, this.patid}) : super(key: key);

  @override
  _ReportState createState() => new _ReportState(doctype: doctype, patid: patid);
}

class _ReportState extends State<Reports> {
  final String doctype;
  final String patid;
  static String mURL = "akdn-virtualdoc.appspot.com";
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');
  static String gender;
  static var _scaffoldKey = new GlobalKey<ScaffoldState>();
  _ReportState({Key key, @required this.doctype, this.patid});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('doctype: $doctype');
    print('patid: $patid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Reports', style: TextStyle(color: Colors.white),),
          backgroundColor: tabBarColor,),
        body:            StreamBuilder(
          stream: Firestore.instance.collection('document')
              .where('user_id', isEqualTo: patid).
          where('category', isEqualTo: doctype).
          snapshots(),
          builder: (context, snapshot2) {
            if (!snapshot2.hasData) {
              print('Nodata');
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            } else {
              print('data');
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                // padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) => buildItemReports(context, snapshot2.data.documents[index]),
                itemCount: snapshot2.data.documents.length,
              );
            }
          },
        ),



    );



  }

  static Widget buildItemReports(BuildContext context, DocumentSnapshot documentSnapshots) {
    print(documentSnapshots['name']);
    return
      new
      Container(
          child:
          GestureDetector(
              onTap: ()=> {Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(imageUrl: 'https://firebasestorage.googleapis.com/v0/b/' + mURL+'/o/' + documentSnapshots["name"] + '?alt=media&token=70e98a31-8b33-46cf-9e33-f35c7ec1d1fc')))},
              child: Hero(
                tag: 'imageHero'+documentSnapshots['name'],
                child:
                documentSnapshots['name'] != null
                    ? CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    width: 30.0,
                    height: 30.0,
                    padding: EdgeInsets.all(15.0),
                  ),
                  imageUrl: 'https://firebasestorage.googleapis.com/v0/b/' + mURL+'/o/' + documentSnapshots["name"] + '?alt=media&token=70e98a31-8b33-46cf-9e33-f35c7ec1d1fc',
                  width: 30.0,
                  height: 30.0,
                  fit: BoxFit.cover,
                )
                    : Icon(
                  Icons.account_circle,
                  size: 30.0,
                  color: Colors.grey,
                ),
              )
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

