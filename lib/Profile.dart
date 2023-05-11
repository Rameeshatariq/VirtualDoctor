import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttervitualdoctor/DocumentList.dart';
import 'package:fluttervitualdoctor/Detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  static String tag = 'profile-page';
  final String patid;
  const Profile({Key key, this.patid}) : super(key: key);

  @override
  _ProfileState createState() => new _ProfileState(patid:this.patid);
}

class _ProfileState extends State<Profile> {
  final String patid;
  static String patientID;
  static var _scaffoldKey = new GlobalKey<ScaffoldState>();
  static String gender;
  static BuildContext _context;
  static String mURL = "akdn-virtualdoc.appspot.com";
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');

  _ProfileState({Key key, @required this.patid});


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    patientID= this.patid;
    _context= this.context;

    print('init:$patientID');
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
          title: Text('Profile', style: TextStyle(color: Colors.white),),
          backgroundColor: tabBarColor,),
        body:
        new StreamBuilder(
        stream: Firestore.instance.collection("patient")
        .where('id', isEqualTo: patid)
        .snapshots(),
    builder: (context, snapshot) {
    if (!snapshot.hasData) {
     Text(
    'No Data...',
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
/*
              DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      constraints: BoxConstraints(maxHeight: 150.0),
                      child: Material(
                        color: Colors.black,
                        child: TabBar(
                          indicatorColor: Colors.white,
                          labelColor: Colors.white,
                          tabs: [
                            Tab(icon: Icon(Icons.history), text: 'History', ),
                            Tab(icon:Icon(Icons.receipt),text: 'Reports')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                          children: containers
                      ),
                    ),
                  ],
                ),

              ),
*/
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
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Material(
              color: Colors.black,
              child:

              TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: [
                  Tab(child:
                      Center(
                        child:Row(
                    children: <Widget>[
                      Icon(
                        Icons.history,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text("HISTORY",textAlign: TextAlign.center,),
                    ],
                  ),
                  )
                  ),
                  Tab(child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.library_books,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text("REPORTS", textAlign: TextAlign.center,),
                    ],
                  ),
                  ),
                ],
              ),
            ),
          ),

          Container(
         height: MediaQuery.of(context).size.height * 0.626,

    //constraints: BoxConstraints(maxHeight: double.maxFinite),
            child:
            TabBarView(
                children: [
                  Container(
                    child: Column(
                      children: <Widget>[

                        Expanded(
                          child: StreamBuilder(
                            stream: Firestore.instance.collection('appointment')
                                .where('patientId', isEqualTo: patid)
                                .where('isCompleted', isEqualTo: true).
                            orderBy('completedDateTime', descending: true).

                            snapshots(),
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
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Radiology Reports'),
                            FlatButton(
                              color: Colors.lightBlueAccent,
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                              onPressed: () => {Navigator.push(_context, MaterialPageRoute(builder: (context) => Reports(doctype:'Radiology',patid:patid)))},
                              child: Text('More',style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                        Expanded(
                          child:
                          StreamBuilder(
                            stream: Firestore.instance.collection('document')
                                .where('user_id', isEqualTo: patid).
                            where('category', isEqualTo: 'Radiology').
                            limit(3).snapshots(),
                            builder: (context, snapshot2) {
                              if (!snapshot2.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                                  ),
                                );
                              } else {
                                return GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  // padding: EdgeInsets.all(10.0),
                                  itemBuilder: (context, index) => buildItemRadiology(context, snapshot2.data.documents[index]),
                                  itemCount: snapshot2.data.documents.length,
                                );
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Laboratory Reports'),
                            FlatButton(
                              color: Colors.lightBlueAccent,
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                              onPressed: () => {Navigator.push(_context, MaterialPageRoute(builder: (context) => Reports(doctype:'Laboratory',patid:patid)))},
                              child: Text('More',style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                        Expanded(
                          child:
                          StreamBuilder(
                            stream: Firestore.instance.collection('document')
                                .where('user_id', isEqualTo: patid).
                            where('category', isEqualTo: 'Laboratory').
                            limit(3).snapshots(),
                            builder: (context, snapshot2) {
                              if (!snapshot2.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                  ),
                                );
                              } else {
                                return GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  // padding: EdgeInsets.all(10.0),
                                  itemBuilder: (context, index) => buildItemLaboratory(context, snapshot2.data.documents[index]),
                                  itemCount: snapshot2.data.documents.length,
                                );
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Others'),
                            FlatButton(
                              color: Colors.lightBlueAccent,
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                              onPressed: () => {Navigator.push(_context, MaterialPageRoute(builder: (context) => Reports(doctype:'Other',patid:patid)))},
                              child: Text('More',style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                        Expanded(
                          child:
                          StreamBuilder(
                            stream: Firestore.instance.collection('document')
                                .where('user_id', isEqualTo: patid).
                            where('category', isEqualTo: 'Other').
                            limit(3).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                                  ),
                                );
                              } else {
                                return GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  // padding: EdgeInsets.all(10.0),
                                  itemBuilder: (context, index) => buildItemOthers(context, snapshot.data.documents[index]),
                                  itemCount: snapshot.data.documents.length,
                                );
                              }
                            },
                          ),
                        )
                        // SizedBox(height: 40,),
                        /* Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Laboratory Reports'),
                  FlatButton(
                    color: Colors.lightBlueAccent,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () => {},
                    child: Text('More',style: TextStyle(color: Colors.white),),
                  )
                ],
              )
          ),
          SizedBox(height: 40,),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Other Reports'),
                  FlatButton(
                    color: Colors.lightBlueAccent,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () => {},
                    child: Text('More',style: TextStyle(color: Colors.white),),
                  )
                ],
              )
          ),
        */],
                    ),
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

