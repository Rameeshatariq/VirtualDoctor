import 'package:flutter/cupertino.dart';
import 'package:fluttervitualdoctor/AssessmentDetails.dart';
import 'package:fluttervitualdoctor/Appointment.dart';
import 'package:fluttervitualdoctor/AppointmentDetails.dart';
import 'package:fluttervitualdoctor/Schedule.dart';
import 'package:fluttervitualdoctor/Sync.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttervitualdoctor/History.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.doctorid}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String doctorid;

  @override
  _MyHomePageState createState() => _MyHomePageState(doctorid: doctorid);
}


class _MyHomePageState extends State<MyHomePage> {
  final String doctorid;
  static String _doctor_id;
  static String gender;
  static BuildContext _context;
  static var _scaffoldKey = new GlobalKey<ScaffoldState>();

  //static Color color = HexColor('#f05b60');
  static List<String> arrays= ['123','4gt'];
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');
  static Color navColor = HexColor('#333333');
  static SharedPreferences sharedPreferences;
  static DateTime now = DateTime.now();
  static String formattedDate = DateFormat('EEEE d MMM, ''yyyy').format(now);
  _MyHomePageState({Key key, @required this.doctorid});


  @override
  void initState()  {
    super.initState();
    print(this.doctorid);
    _context= context;
    _doctor_id = this.doctorid;
    print('hh'+_doctor_id);
    setdoctorid();
    print(_doctor_id);

  }

  static Future<String> setdoctorid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _doctor_id = pref.getString('id');
    return _doctor_id;
  }


  List<Widget> containers = [


  ];

  static Widget buildItem(BuildContext context, DocumentSnapshot documentSnapshot) {
    print('docid:'+documentSnapshot['doctorId']);
    print('docname:'+documentSnapshot['doctorName']);

    if(documentSnapshot['patGender'] == 1){
      gender = 'Male';
    }
    else if(documentSnapshot['patGender'] == 2){
      gender = 'Female';
    }
    else{
      gender = 'Unknown';
    }
    return
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
                      Text(documentSnapshot['appTimeStart'], style: TextStyle(color:Colors.white,)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 10, 5, 2),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                documentSnapshot['patName'],
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
                            margin: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                            child:
                            Row(
                              children: [
                                Icon(Icons.supervised_user_circle, color: Colors.grey,),
                                Text(' MR# ' + documentSnapshot["patMR"],
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
                                Text(' Phone' + documentSnapshot["patPhone"],
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
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                            child:
                            Row(
                              children: [
                                Icon(Icons.group, color: Colors.grey,),
                                Text(' Gender ' + gender, style: TextStyle(
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
                                Text(' Age ' +calculateAge(documentSnapshot["patDOB"]).toString()+ ' years',
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
                    margin: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    child: ButtonTheme(
                      minWidth: double.infinity, // match_parent
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      child:     FlatButton(
                        color: buttonColor,
                        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetail(drid: documentSnapshot['doctorId'],
                        patid:documentSnapshot['patientId']))),
                        },
                        child: Text('View Detail',style: TextStyle(color: Colors.white),),
                      ),
                    )
                )
              ],
            ),
          )
      );
  }

  static Widget buildItem2(BuildContext context, DocumentSnapshot documentSnapshot) {

    print('docid:'+documentSnapshot['doctorId']);
    print('docname:'+documentSnapshot['doctorName']);


    calculateAge(documentSnapshot['patDOB']);
    print(calculateAge(documentSnapshot['patDOB']));
    if(documentSnapshot['patGender'] == 1){
      gender = 'Male';
    }
    else if(documentSnapshot['patGender'] == 2){
      gender = 'Female';
    }
    else{
      gender = 'Unknown';
    }

    return
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
                      Text(documentSnapshot['appTimeStart'], style: TextStyle(color:Colors.white,)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 10, 5, 2),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                documentSnapshot['patName'],
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
                            margin: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                            child:
                            Row(
                              children: [
                                Icon(Icons.supervised_user_circle, color: Colors.grey,),
                                Text(' MR# ' + documentSnapshot["patMR"],
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
                                Text(' Phone' + documentSnapshot["patPhone"],
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
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                            child:
                            Row(
                              children: [
                                Icon(Icons.group, color: Colors.grey,),
                                Text(' Gender '+ gender, style: TextStyle(
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
                                Text(' Age ' +calculateAge(documentSnapshot["patDOB"]).toString()+ ' years',
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
                    margin: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    child: Row(
                      children: [
                        Flexible(
                            flex:2,
                            fit: FlexFit.tight,
                            child:
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
                                child: ButtonTheme(
                                    minWidth: double.minPositive,
                                    child: FlatButton(
                                      color: buttonColor,
                                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                                      onPressed: () => {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AssessmentDetail(appid: documentSnapshot['id']))),
                                    },
                                      child: Text('View Assessment',style: TextStyle(color: Colors.white, fontSize: 12),),
                                    )
                                )
                            )
                        ),
                        Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child:
                            Container(
                                margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                                child: ButtonTheme(
                                    minWidth: double.minPositive,
                                    child: FlatButton(
                                      color: Colors.green,
                                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                                      onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment(patid: documentSnapshot['patientId']))),
                                      },
                                      child: Text('Start Consultation',style: TextStyle(color: Colors.white, fontSize: 12),),
                                    )
                                )
                            )
                        ),
                      ],
                    )
                )
              ],
            ),
          )
      );





/*        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: document['photoUrl'] != null
                    ? CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                    ),
                    width: 50.0,
                    height: 50.0,
                    padding: EdgeInsets.all(15.0),
                  ),
                  imageUrl: document['photoUrl'],
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                )
                    : Icon(
                  Icons.account_circle,
                  size: 50.0,
                  color: greyColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Nickname: ${document['nickname']}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'About me: ${document['aboutMe'] ?? 'Not available'}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {

            _channelController= document.documentID + currentUserId;

            sendNotification(document.documentID, name, _channelController);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallPage(
                    channelName: _channelController,
                  ),

                )
            );
          },
          color: greyColor2,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );*/
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


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Theme(
        data: Theme.of(context).copyWith(
      canvasColor: navColor, //This will change the drawer background to blue.
      //other styles
    ), child: NavDrawer(),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset('assets/aghakhan.jpg',fit: BoxFit.cover, width: 220,),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 150.0),
                child: Material(
                  color: tabBarColor,
                  child: TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    tabs: [
                      Tab(text: 'Queue',),
                      Tab(text: 'Completed')
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                    children: [
                      Stack(
                        children:[
                          Image.asset(
                            "assets/pattren_g.png",
                            height: MediaQuery.of(_context).size.height,
                            width: MediaQuery.of(_context).size.width,
                            fit: BoxFit.fitHeight,
                          ),

                          Column(
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
                                child: StreamBuilder(
                                  stream: Firestore.instance.collection('appointment')
                                      .where('isCompleted', isEqualTo: true).
                                  where('doctorId', isEqualTo: _doctor_id).
                                  where('acceptStatus', isEqualTo: 1).
                                  where('isPaid', isEqualTo: 2).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                                        ),
                                      );
                                    } else {
                                      return ListView.builder(
                                        padding: EdgeInsets.all(10.0),
                                        itemBuilder: (context, index) => buildItem(context, snapshot.data.documents[index]),
                                        itemCount: snapshot.data.documents.length,
                                      );
                                    }
                                  },
                                ),
                              ),

                              /*Expanded(
              child:
              ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) => buildItem2(context, arrays[index],_doctor_id),
                itemCount: arrays.length,
              )
          )
        */],
                          )
                        ],
                      ),


        Stack(
          children:[
          Image.asset(
          "assets/pattren_g.png",
          height: MediaQuery.of(_context).size.height,
          width: MediaQuery.of(_context).size.width,
          fit: BoxFit.fitHeight,
        ),

         Column(
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
                              child: StreamBuilder(
                                stream: Firestore.instance.collection('appointment').where('isCompleted', isEqualTo: true).
                                where('doctorId', isEqualTo: _doctor_id).
                                orderBy('completedDateTime', descending: true ).
                                limit(301).snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                                      ),
                                    );
                                  } else {
                                    return ListView.builder(
                                      padding: EdgeInsets.all(10.0),
                                      itemBuilder: (context, index) => buildItem2(context, snapshot.data.documents[index]),
                                      itemCount: snapshot.data.documents.length,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
        ]
                      ),

                    ]
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }

}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: HexColor('#333333')
            ),
            child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 60,
                        color: Colors.grey,
                      ),
                      Text(
                        'John David', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ],
                  ),
          ),

          Container(
              child:
              Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.brightness_1, color: Colors.white,),
                      title: Text('DASHBOARD', style: TextStyle(color: Colors.white),),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(Icons.brightness_1, color: Colors.white,),
            title: Text('SCHEDULE',style: TextStyle(color: Colors.white),),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Schedule())),
            },
          ),
                    ListTile(
                      leading: Icon(Icons.brightness_1, color: Colors.white,),
            title: Text('HISTORY',style: TextStyle(color: Colors.white),),
                        onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => History()))}
          ),
                    ListTile(
                      leading: Icon(Icons.brightness_1, color: Colors.white,),
            title: Text('SYNC DATA',style: TextStyle(color: Colors.white),),
                        onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Sync()))}
                    ),
                    ListTile(
                      leading: Icon(Icons.brightness_1, color: Colors.white,),
            title: Text('LOGOUT',style: TextStyle(color: Colors.white),),
            onTap: () => {Navigator.of(context).pop()},
          ),
    ]
    )
          )
        ],
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
