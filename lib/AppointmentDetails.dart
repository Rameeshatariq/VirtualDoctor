import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttervitualdoctor/DocumentList.dart';
import 'package:fluttervitualdoctor/Detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class AppointmentDetail extends StatefulWidget {
  static String tag = 'appointment-detail-page';
  final String patid;
  final String drid;
  const AppointmentDetail({Key key,this.drid, this.patid}) : super(key: key);

  @override
  _AppointmentDetailState createState() => new _AppointmentDetailState(drid:drid,patid:this.patid);
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  final String patid;
  final String drid;
  static var _scaffoldKey = new GlobalKey<ScaffoldState>();
  static String gender;
  static BuildContext _context;
  static String mURL = "akdn-virtualdoc.appspot.com";
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');

  _AppointmentDetailState({Key key, @required this.drid,this.patid});


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _context= this.context;
    print('init:$patid');
  }


  static Widget buildItemRadiology(BuildContext context, DocumentSnapshot documentSnapshots) {
    //print(patientID);
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
                )
            )
        ),
      );

  }
  static Widget buildItemLaboratory(BuildContext context, DocumentSnapshot documentSnapshots) {
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
  static Widget buildItemOthers(BuildContext context, DocumentSnapshot documentSnapshots) {
    return
      new
      Container(
          child:
          GestureDetector(
              onTap: ()=> {Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(imageUrl: 'https://firebasestorage.googleapis.com/v0/b/' + mURL+'/o/' + documentSnapshots["name"] + '?alt=media&token=70e98a31-8b33-46cf-9e33-f35c7ec1d1fc')))},
              child: Hero(
                tag: 'imageHero'+documentSnapshots['name'],
                child: documentSnapshots['name'] != null
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

  static Widget buildItem2(BuildContext context, DocumentSnapshot documentSnapshot) {

    print('historypatid: '+documentSnapshot["patientId"]);
    print('historypatname: '+documentSnapshot["patName"]);

    //print(documentSnapshot['id']);

    Timestamp date = documentSnapshot['completedDateTime'];
    DateTime datee = date.toDate();
    String formattedTime = DateFormat('hh:mm a').format(datee);
    String formattedDate = DateFormat.yMd().format(datee);
    print('time:' + formattedTime+ 'date:'+formattedDate);

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
      new Card(
        // margin: EdgeInsets.all(20),
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        shadowColor: Colors.grey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dated:', style: TextStyle(color: Colors.grey, fontWeight:FontWeight.bold)),
                        Text(formattedDate, style: TextStyle(color: Colors.grey, fontSize: 10 )),
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Time:', style: TextStyle(color:Colors.grey, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                        Text(formattedTime, style: TextStyle(color:Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
              color: Colors.white,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Row(
                          children: [
                            Text(
                              'Complaint: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              documentSnapshot['patComplaint'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ]
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          children: [
                            Text(
                              'Notes: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              documentSnapshot['DrNotes'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ]
                      ),

                    ],
                  ), /*3*/],
              ),
            ),

            SizedBox(
              height: 10,
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
                    onPressed: () => {},
                    child: Text('View Detail',style: TextStyle(color: Colors.white),),
                  ),
                )
            )              ],
        ),
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




  @override
  Widget build(BuildContext context) {
    print('Main:$patid');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Appointment Details', style: TextStyle(color: Colors.white),),
          backgroundColor: tabBarColor,),
        body:
        new StreamBuilder(
            stream: Firestore.instance.collection("patient")
                .where('id', isEqualTo: patid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
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
                  return
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
                                  color: Colors.black,
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
                          SizedBox(height: 20,),
                          _tabSection(context)
                        ]
                    );
                }
              }
            }
        )

    );
  }


  Widget _tabSection(BuildContext context) {
    print('patient   ' +patid);
    return DefaultTabController(
      length: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxHeight: 150.0),
            child: Material(
              color: Colors.black,
              child: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: [
                  Tab(icon: Icon(Icons.shopping_cart),
                    child: Text('MEDICINE',style: TextStyle(fontSize: 10),),),
                  Tab(icon: Icon(Icons.colorize),
                    child: Text('LAB',style: TextStyle(fontSize: 10),),),
                  Tab(icon: Icon(Icons.rate_review),
                    child: Text('RADIOLOGY',style: TextStyle(fontSize: 10),),),
                  Tab(icon: Icon(Icons.note_add),
                    child: Text('NOTES',style: TextStyle(fontSize: 10),),),
                ],
              ),
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height * 0.58,

            //constraints: BoxConstraints(maxHeight: double.maxFinite),
            child:
            TabBarView(
                children: [
                  Container(
                      width: 0,
                      height: 0,
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                      child:
                      Column(
                          mainAxisSize: MainAxisSize.max ,
                          children: [
                            Expanded(
                                    child:
                                    StreamBuilder(
                                        stream: Firestore.instance.collection('appointment')
                                            .where('patientId', isEqualTo: 'vJ4dzkRyG1OXMY4dmm69')
                                            .where('doctorId', isEqualTo: drid).
                                        snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                                              ),
                                            );
                                          } else {
                                            for (DocumentSnapshot doc in snapshot.data.documents) {
                                              print(doc['listPharmacy']);
                                              List<dynamic> item = doc['listPharmacy'];
                                             // print(doc['listPharmacy'][0]);
                                             // print(doc['listPharmacy'][1]);
                                              print(item.length);
                                              return
                                                ListView.builder(
                                                    padding: EdgeInsets.all(10.0),
                                                    itemCount: item.length,
                                                    itemBuilder: (context, index) {
                                                      final item2 = doc['listPharmacy'][index];
                                                      print(item2);
                                                      return Card(
                                                          shadowColor: Colors.grey,
                                                          elevation: 10,
                                                          shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0)),
                                                          child:
                                                          Container(
    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
    child:
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Text(
    'Medicine: ',
    textAlign: TextAlign.start,),
    Text(item2['name'], style: TextStyle(
    fontWeight: FontWeight.bold),)
    ],
    ),
    SizedBox(height: 10,),
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Text(
    'Frequency: ',
    textAlign: TextAlign.start,),
    Text(item2['frequency'], style: TextStyle(
    fontWeight: FontWeight.bold),)
    ],
    ),
    SizedBox(height: 10,),
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Text(item2['duration'], style: TextStyle(
    fontWeight: FontWeight.bold),
    textAlign: TextAlign.start,)
    ],
    ),
    ],
    ),
    ],
    )
    )
                                                      );
                                                    }
                                                    );
                                            }
                                          }
                                        }
                                        )
                            )
                          ]
                      )
                  ),
                  Container(
                      width: 0,
                      height: 0,
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                      child:
                      Column(
                          mainAxisSize: MainAxisSize.max ,
                          children: [
                            Expanded(
                                child:
                                StreamBuilder(
                                    stream: Firestore.instance.collection('appointment')
                                        .where('patientId', isEqualTo: 'vJ4dzkRyG1OXMY4dmm69')
                                        .where('doctorId', isEqualTo: drid).
                                    snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                                          ),
                                        );
                                      } else {
                                        for (DocumentSnapshot doc in snapshot.data.documents) {
                                          print(doc['listLab']);
                                          List<dynamic> item = doc['listLab'];
                                          // print(doc['listPharmacy'][0]);
                                          // print(doc['listPharmacy'][1]);
                                          print(item.length);
                                          return
                                            ListView.builder(
                                                padding: EdgeInsets.all(10.0),
                                                itemCount: item.length,
                                                itemBuilder: (context, index) {
                                                  final item2 = doc['listLab'][index];
                                                  print(item2);
                                                  return Card(
                                                      shadowColor: Colors.grey,
                                                      elevation: 10,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0)),
                                                      child:
                                                      Container(
                                                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(

                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Text(item2['name'], style: TextStyle(
                                                                          fontWeight: FontWeight.bold),)
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                      )
                                                  );
                                                }
                                            );
                                        }
                                      }
                                    }
                                )
                            )
                          ]
                      )
                  ),
                  Container(
                      width: 0,
                      height: 0,
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                      child:
                      Column(
                          mainAxisSize: MainAxisSize.max ,
                          children: [
                            Expanded(
                                child:
                                StreamBuilder(
                                    stream: Firestore.instance.collection('appointment')
                                        .where('patientId', isEqualTo: 'vJ4dzkRyG1OXMY4dmm69')
                                        .where('doctorId', isEqualTo: drid).
                                    snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                                          ),
                                        );
                                      } else {
                                        for (DocumentSnapshot doc in snapshot.data.documents) {
                                          print(doc['listRadio']);
                                          List<dynamic> item = doc['listRadio'];
                                          // print(doc['listPharmacy'][0]);
                                          // print(doc['listPharmacy'][1]);
                                          print(item.length);
                                          return
                                            ListView.builder(
                                                padding: EdgeInsets.all(10.0),
                                                itemCount: item.length,
                                                itemBuilder: (context, index) {
                                                  final item2 = doc['listRadio'][index];
                                                  print(item2);
                                                  return Card(
                                                      shadowColor: Colors.grey,
                                                      elevation: 10,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0)),
                                                      child:
                                                      Container(
                                                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(

                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Text(item2['name'], style: TextStyle(
                                                                          fontWeight: FontWeight.bold),)
                                                                    ],
                                                                  ),
                                                                 ],
                                                              ),
                                                            ],
                                                          )
                                                      )
                                                  );
                                                }
                                            );
                                        }
                                      }
                                    }
                                )
                            )
                          ]
                      )
                  ),
                  Container(
                      width: 0,
                      height: 0,
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child:
                      Column(
                          mainAxisSize: MainAxisSize.max ,
                          children: [
                            Expanded(
                                child:
                                StreamBuilder(
                                    stream: Firestore.instance.collection('appointment')
                                        .where('patientId', isEqualTo: 'vJ4dzkRyG1OXMY4dmm69')
                                        .where('doctorId', isEqualTo: drid).
                                    snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                                          ),
                                        );
                                      } else {
                                        for (DocumentSnapshot doc in snapshot.data.documents) {
                                          print(doc['DrNotes']);
                                          //List<dynamic> item = doc['listPharmacy'];
                                          // print(doc['listPharmacy'][0]);
                                          // print(doc['listPharmacy'][1]);
                                         // print(item.length);
                                                 return
                                                   SizedBox(
                                                       height: 120,
                                                       width:  double.infinity,
                                                       child:
                                                   Card(
                                                      shadowColor: Colors.grey,
                                                      elevation: 10,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0)),
                                                      child:

                                                              Container(
                                                                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                                                  child:
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Text('Doctor Notes:'),
                                                                              Text(doc['DrNotes'], style: TextStyle(
                                                                                  fontWeight: FontWeight.bold),)
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  )
                                                              ),

                                                                                                            )
                                                   );
                                        }
                                      }
                                    }
                                )
                            )
                          ]
                      )
                  ),

                ]
              //containers
            ),
          )
        ],
      ),
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

