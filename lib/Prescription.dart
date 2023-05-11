//import 'dart:html';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttervitualdoctor/AssessmentDetails.dart';
import 'package:fluttervitualdoctor/Appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Prescription extends StatefulWidget {
  final String patid;
  final String drid;
  const Prescription({Key key, this.drid, this.patid}) : super(key: key);


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _PrescriptionState createState() => _PrescriptionState(drid:drid,patid:patid);
}


class _PrescriptionState extends State<Prescription> with SingleTickerProviderStateMixin  {
  final String patid;
  final String drid;
  static  Map<String, dynamic> contents = new Map();
  static  Map<String, dynamic> content = new Map();
  static  Map<String, dynamic> content1 = new Map();
  static  Map<String, dynamic> content2 = new Map();
  static  Map<String, dynamic> content3 = new Map();
  static  Map<String, dynamic> content4 = new Map();
  static  Map<String, dynamic> content5 = new Map();
  //static Color color = HexColor('#f05b60');
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');
  static var _scaffoldKey = new GlobalKey<ScaffoldState>();
  static List<String> selectedValues = ['Panadol','3 times daily','5 Days'];
  static List<String> labTest = ['CBC'];
  static List<String> radiologyTest = ['X-Ray Hand'];
  static List<String> doctorNotes = ['Stay Hydrated', 'Drink Water'];


  _PrescriptionState({Key key, @required this.drid, this.patid});

  static _PrescriptionState stateObject = _scaffoldKey.currentContext.findAncestorStateOfType<_PrescriptionState>();
  static final myController = TextEditingController();

  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey_labTest = new GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey_radiologyTest = new GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey_docNotes = new GlobalKey<FormState>();

  static List<String> _frequencies = <String>['1 Time Daily', '2 Times Daily', '3 Times Daily'];
  static String frequency;
  static String _dosage;
  static List <String> spinnerItems = [
    '1 Tablet',
    '2 Tablets',
    '3 Tablets',
    '4 Tablets',
    '5 Tablets'
  ] ;
  static var dropdownValue = '1 Tablet';

  static String newValue;

  @override
  void initState() {
    super.initState();
    print('init $content');
  }

  List<Widget> containers = [

  ];

/*
  static _onDeleteItemPressed(item) {
    selectedValues.removeAt(item);
    stateObject.setState(() {
    });
  }
*/
 /* static Widget listviewBuilder(BuildContext context){
    ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemBuilder: (context, index) => buildItem(context, selectedValues[index], index),
      itemCount: selectedValues.length,
    );
  }
 */
 /*static Widget buildItem(BuildContext context, String array, int index) {
    return
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
                        Text('Medicine: ',textAlign: TextAlign.start,),
                        Text(array, style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Frequency: ',textAlign: TextAlign.start,),
                        Text(array, style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(array, style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,)
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.delete,
                  color: Colors.red,
                  ),
                  onPressed: removeItem(index),
                )

              ],
          )
              )
      );
  }
*/

/*
  static removeItem(int index) {
    selectedValues.removeAt(index);
    if (stateObject.mounted){
      stateObject.setState(() {
        selectedValues = List.from(selectedValues).removeAt(index);
      });
    }


  }
*/


  @override
   static Widget _showDialog(BuildContext context)   {
      // flutter defined function
      showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) {
          // return object of type Dialog
          return
            Dialog(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
          //elevation: 10,
          child:
          Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           new Form(
               key: _formKey,
                            autovalidate: true,
                            child: new ListView(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              children: <Widget>[
                                new TextFormField(
                                  decoration: const InputDecoration(
                                 //   icon: const Icon(Icons.person),
                                    labelText: 'Medicines',
                                  ),
                                    onSaved: (val) => content1.addAll({'name':val})
                                ),
                                new TextFormField(
                                  decoration: const InputDecoration(
                               //     icon: const Icon(Icons.calendar_today),
                                    labelText: 'Type',
                                  ),
                                  keyboardType: TextInputType.text,
                                    onSaved: (val) => content2.addAll({'type':val})),

                                new FormField(
                                  builder: (FormFieldState state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                  //      icon: const Icon(Icons.color_lens),
                                        labelText: 'Dosage',
                                        labelStyle: TextStyle(fontSize: 22)
                                      ),
                                      isEmpty: _dosage == '',
                                      child: new DropdownButtonHideUnderline(
                                        child: new DropdownButton(
                                          value: _dosage,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            stateObject.setState(() {
                                             // newContact.favoriteColor = newValue;
                                              _dosage = newValue;
                                              state.didChange(newValue);
                                              content3.addAll({'dosage':newValue});
                                             // jsonArrayDosage.add(newValue);
                                            });
                                          },
                                          items: spinnerItems.map((String value) {
                                            return new DropdownMenuItem(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                new FormField(
                                  builder: (FormFieldState state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                //        icon: const Icon(Icons.color_lens),
                                        labelText: 'Frequency',
                                          labelStyle: TextStyle(fontSize: 22)
                                      ),
                                      isEmpty: frequency == '',
                                      child: new DropdownButtonHideUnderline(
                                        child: new DropdownButton(
                                          value: frequency,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            stateObject.setState(() {
                                              // newContact.favoriteColor = newValue;
                                              frequency = newValue;
                                              state.didChange(newValue);
                                              content4.addAll({"frequency":newValue});
                                             // jsonArrayFrequency.add(newValue);
                                            });
                                          },
                                          items: _frequencies.map((String value) {
                                            return new DropdownMenuItem(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),


                                new TextFormField(
                                  decoration: const InputDecoration(
                                  //  icon: const Icon(Icons.email),
                                    labelText: 'Duration',
                                  ),
                                  keyboardType: TextInputType.text,
                                  onSaved: (val) => content5.addAll( {"duration":val}),
                                ),
                                new Container(
                                    child:Padding(
                                      padding: EdgeInsets.symmetric(vertical: 18.0),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        onPressed: () {
                                          _submitForm();
                                          Navigator.pop(context);
                                        },
                                        padding: EdgeInsets.all(14),
                                        color: HexColor('#50ba58'),
                                        child: Text('Add', style: TextStyle(color: Colors.white)),
                                      ),
                                    )
                                ),
                              ],
                            ))
          ]
          )
            );
            },
      );
    }

  static Widget _showDialogLabTest(BuildContext context)   {
    // flutter defined function
    showDialog(
      context: _scaffoldKey.currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                //elevation: 10,
                child:
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                new Form(
                        key: _formKey_labTest,
                        autovalidate: true,
                        child: new ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          children: <Widget>[
                            new TextFormField(
                                decoration: const InputDecoration(
                                  //   icon: const Icon(Icons.person),
                                  labelText: 'Lab Test',
                                ),
                                onSaved: (val) => labTest.add(val)
                            ),
                            new Container(
                                child:Padding(
                                  padding: EdgeInsets.symmetric(vertical: 18.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    onPressed: () {
                                      _submitForm_labTest();
                                      Navigator.pop(context);
                                    },
                                    padding: EdgeInsets.all(14),
                                    color: HexColor('#50ba58'),
                                    child: Text('Add', style: TextStyle(color: Colors.white)),
                                  ),
                                )
                            ),
                          ],
                        )),
                ]
                )

              );
      },
    );
  }

  static Widget _showDialogRadiologyTest(BuildContext context)   {
    // flutter defined function
    showDialog(
      context: _scaffoldKey.currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return
          Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              //elevation: 10,
              child:
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Form(
                        key: _formKey_radiologyTest,
                        autovalidate: true,
                        child: new ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          children: <Widget>[
                            new TextFormField(
                                decoration: const InputDecoration(
                                  //   icon: const Icon(Icons.person),
                                  labelText: 'Radiology Test',
                                ),
                                onSaved: (val) => radiologyTest.add(val)
                            ),
                            new Container(
                                child:Padding(
                                  padding: EdgeInsets.symmetric(vertical: 18.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    onPressed: () {
                                      _submitForm_radioTest();
                                      Navigator.pop(context);
                                    },
                                    padding: EdgeInsets.all(14),
                                    color: HexColor('#50ba58'),
                                    child: Text('Add', style: TextStyle(color: Colors.white)),
                                  ),
                                )
                            ),
                          ],
                        )),
                  ]
              )

          );
      },
    );
  }

  static Widget _showDialogDoctorNotes(BuildContext context)   {
    // flutter defined function
    showDialog(
      context: _scaffoldKey.currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return
          Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              //elevation: 10,
              child:
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Form(
                        key: _formKey_docNotes,
                        autovalidate: true,
                        child: new ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          children: <Widget>[
                            new TextFormField(
                                decoration: const InputDecoration(
                                  //   icon: const Icon(Icons.person),
                                  labelText: 'Doctor Notes',
                                ),
                                onSaved: (val) => doctorNotes.add(val)
                            ),
                            new Container(
                                child:Padding(
                                  padding: EdgeInsets.symmetric(vertical: 18.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    onPressed: () {
                                      _submitForm_docNotes();
                                      Navigator.pop(context);
                                    },
                                    padding: EdgeInsets.all(14),
                                    color: HexColor('#50ba58'),
                                    child: Text('Add', style: TextStyle(color: Colors.white)),
                                  ),
                                )
                            ),
                          ],
                        )),
                  ]
              )

          );
      },
    );
  }


  static void _submitForm() {
    final FormState form = _formKey.currentState;

      form.save(); //This invokes each onSaved event
   // jsonArrayDosage.add(selectedValues[0]);

    content.addAll(content1);
    content.addAll(content2);
    content.addAll(content3);
    content.addAll(content4);
    content.addAll(content5);

    final signUp = Data.fromJson(content);
    print(signUp.toJson());

   //print(jsonDecode(content.toString()));
    // print('Medicines:'+ jsonArrayDuration.length.toString());
   // print('Medicines' +jsonArrayDuration[0]);
      print('Form save called, newContact is now up to date...');
      /*print('Medicines: ${selectedValues[2]}');
    print('Type: ${selectedValues[3]}');
    print('Dosage: ${selectedValues[0]}');
    print('Frequency: ${selectedValues[1]}');
    print('Duration: ${selectedValues[4]}');
     */print('TODO - we will write the submission part next...');
    }

  static void _submitForm_labTest() {
    final FormState form = _formKey_labTest.currentState;

    form.save(); //This invokes each onSaved event

    print('Form save called, newContact is now up to date...');
    print('Lab Test: ${labTest[0]}');
    print('TODO - we will write the submission part next...');
  }

  static void _submitForm_radioTest() {
    final FormState form = _formKey_radiologyTest.currentState;

    form.save(); //This invokes each onSaved event

    print('Form save called, newContact is now up to date...');
    print('Radiology Test: ${radiologyTest[0]}');
    print('TODO - we will write the submission part next...');
  }

  static void _submitForm_docNotes() {
    final FormState form = _formKey_docNotes.currentState;

    form.save(); //This invokes each onSaved event

    print('Form save called, newContact is now up to date...');
    print('Doctor Notes: ${doctorNotes[0]}');
    print('TODO - we will write the submission part next...');
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Prescriptions', style: TextStyle(color: Colors.white),),
          backgroundColor: tabBarColor,),
        body: DefaultTabController(
          length: 4,
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
                      Tab(icon: Icon(Icons.shopping_cart),text: 'MEDICINE',),
                      Tab(icon: Icon(Icons.colorize),text: 'LAB',),
                      Tab(icon: Icon(Icons.rate_review),text: 'RADIOLOGY',),
                      Tab(icon: Icon(Icons.note_add),text: 'NOTES',),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
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
                                                ListView.builder(
                                                  padding: EdgeInsets.all(10.0),
                                                  itemCount: content.length,
                                                  itemBuilder: (context, index) {
                                                    //   DocumentSnapshot user = snapshot.data.documents[0];
                                                    String name = content.keys.elementAt(0);
                                                    String frequency = content.keys.elementAt(2);
                                                    String duration = content.keys.elementAt(1);

                                                    print(name);
                                                    return Dismissible(
                                                      key: Key(name.toString()),
                                                      direction: DismissDirection.startToEnd,
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
                                                                          Text(
                                                                            'Medicine: ',
                                                                            textAlign: TextAlign.start,),
                                                                          Text(content[name], style: TextStyle(
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
                                                                          Text(content[frequency], style: TextStyle(
                                                                              fontWeight: FontWeight.bold),)
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: 10,),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(content[duration], style: TextStyle(
                                                                              fontWeight: FontWeight.bold),
                                                                            textAlign: TextAlign.start,)
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  IconButton(
                                                                      icon: Icon(Icons.delete,
                                                                        color: Colors.red,
                                                                      ), onPressed: () {
                                                                    stateObject.setState(() {
                                                                      selectedValues.removeAt(
                                                                          index);
                                                                      stateObject.initState();
                                                                    });
                                                                  }
                                                                  )

                                                                ],
                                                              )
                                                          )
                                                      ),

                                                      /*ListTile(
                                    title: Text(item),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete_forever),
                                      onPressed: () {
                                        stateObject.setState(() {
                                          selectedValues.removeAt(index);
                                          stateObject.initState();
                                        });
                                      },
                                    ),
                                  ),*/
                                                      onDismissed: (direction) {
                                                        stateObject.setState(() {
                                                          selectedValues.removeAt(index);
                                                        });
                                                      },
                                                    );
                                                  },


                                                )
                                ),


                                /*   Expanded(
                                    child:
                                    StreamBuilder(
                                        stream: Firestore.instance.collection('appointment')
                                            .where('patientId', isEqualTo: 'G1R8pm1SJVkbiHUJoQ7L')
                                            .where('doctorId', isEqualTo: 'PydRki0l3KaeV7J6OCVDtc97HcN2').
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
      print(doc['listPharmacy'][0]);
      print(doc['listPharmacy'][1]);
      print(item.length);

        return
          ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: item.length,
            itemBuilder: (context, index) {
           //   DocumentSnapshot user = snapshot.data.documents[0];
              final item2 = doc['listPharmacy'][index];
              print(item2);
              return Dismissible(
                key: Key(item2.toString()),
                direction: DismissDirection.startToEnd,
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
                            IconButton(
                                icon: Icon(Icons.delete,
                                  color: Colors.red,
                                ), onPressed: () {
                              stateObject.setState(() {
                                selectedValues.removeAt(
                                    index);
                                stateObject.initState();
                              });
                            }
                            )

                          ],
                        )
                    )
                ),

                */
                             /*ListTile(
                                    title: Text(item),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete_forever),
                                      onPressed: () {
                                        stateObject.setState(() {
                                          selectedValues.removeAt(index);
                                          stateObject.initState();
                                        });
                                      },
                                    ),
                                  ),*/
                             /*
                onDismissed: (direction) {
                  stateObject.setState(() {
                    selectedValues.removeAt(index);
                  });
                },
              );
            },


          );

    }

                                          }
                                        }
                                    )
                                ),
                             */   Align(
                                  alignment: Alignment.bottomRight,
                                  child:
                                  FloatingActionButton(
                                      child: Icon(Icons.add, color: Colors.white,),
                                      backgroundColor: tabBarColor,

                                      foregroundColor: Colors.white,
                                      onPressed: () {
                                        _showDialog(_scaffoldKey.currentContext);

                                      }
                                  ),
                                ),



                              ])
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
                                    ListView.builder(
                                      padding: EdgeInsets.all(10.0),
                                      itemCount: labTest.length,
                                      itemBuilder: (context, index) {
                                        final item = labTest[index];
                                        return Dismissible(
                                          key: Key(item),
                                          direction: DismissDirection.startToEnd,
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
                                                              Text(item, style: TextStyle(fontWeight: FontWeight.bold),)
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      IconButton(
                                                          icon: Icon(Icons.delete,
                                                            color: Colors.red,
                                                          ),onPressed: () {
                                                        stateObject.setState(() {
                                                          labTest.removeAt(
                                                              index);
                                                          stateObject.initState();
                                                        });
                                                      }
                                                      )

                                                    ],
                                                  )
                                              )
                                          ),

                                          /*ListTile(
                                    title: Text(item),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete_forever),
                                      onPressed: () {
                                        stateObject.setState(() {
                                          selectedValues.removeAt(index);
                                          stateObject.initState();
                                        });
                                      },
                                    ),
                                  ),*/
                                          onDismissed: (direction) {
                                            stateObject.setState(() {
                                              labTest.removeAt(index);
                                            });
                                          },
                                        );
                                      },

                                    )
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child:
                                  FloatingActionButton(
                                      child: Icon(Icons.add, color: Colors.white,),
                                      backgroundColor: tabBarColor,

                                      foregroundColor: Colors.white,
                                      onPressed: () {
                                        _showDialogLabTest(_scaffoldKey.currentContext);

                                      }
                                  ),
                                ),



                              ])
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
                                    ListView.builder(
                                      padding: EdgeInsets.all(10.0),
                                      itemCount: radiologyTest.length,
                                      itemBuilder: (context, index) {
                                        final item = radiologyTest[index];
                                        return Dismissible(
                                          key: Key(item),
                                          direction: DismissDirection.startToEnd,
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
                                                              Text(item, style: TextStyle(fontWeight: FontWeight.bold),)
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      IconButton(
                                                          icon: Icon(Icons.delete,
                                                            color: Colors.red,
                                                          ),onPressed: () {
                                                        stateObject.setState(() {
                                                          radiologyTest.removeAt(
                                                              index);
                                                          stateObject.initState();
                                                        });
                                                      }
                                                      )

                                                    ],
                                                  )
                                              )
                                          ),

                                          /*ListTile(
                                    title: Text(item),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete_forever),
                                      onPressed: () {
                                        stateObject.setState(() {
                                          selectedValues.removeAt(index);
                                          stateObject.initState();
                                        });
                                      },
                                    ),
                                  ),*/
                                          onDismissed: (direction) {
                                            stateObject.setState(() {
                                              radiologyTest.removeAt(index);
                                            });
                                          },
                                        );
                                      },

                                    )
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child:
                                  FloatingActionButton(
                                      child: Icon(Icons.add, color: Colors.white,),
                                      backgroundColor: tabBarColor,

                                      foregroundColor: Colors.white,
                                      onPressed: () {
                                        _showDialogRadiologyTest(_scaffoldKey.currentContext);

                                      }
                                  ),
                                ),



                              ])
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
                                    ListView.builder(
                                      padding: EdgeInsets.all(10.0),
                                      itemCount: doctorNotes.length,
                                      itemBuilder: (context, index) {
                                        final item = doctorNotes[index];
                                        return Dismissible(
                                          key: Key(item),
                                          direction: DismissDirection.startToEnd,
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
                                                              Text(item, style: TextStyle(fontWeight: FontWeight.bold),)
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      IconButton(
                                                          icon: Icon(Icons.delete,
                                                            color: Colors.red,
                                                          ),onPressed: () {
                                                        stateObject.setState(() {
                                                          doctorNotes.removeAt(
                                                              index);
                                                          stateObject.initState();
                                                        });
                                                      }
                                                      )

                                                    ],
                                                  )
                                              )
                                          ),

                                          /*ListTile(
                                    title: Text(item),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete_forever),
                                      onPressed: () {
                                        stateObject.setState(() {
                                          selectedValues.removeAt(index);
                                          stateObject.initState();
                                        });
                                      },
                                    ),
                                  ),*/
                                          onDismissed: (direction) {
                                            stateObject.setState(() {
                                              doctorNotes.removeAt(index);
                                            });
                                          },
                                        );
                                      },

                                    )
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child:
                                  FloatingActionButton(
                                      child: Icon(Icons.add, color: Colors.white,),
                                      backgroundColor: tabBarColor,

                                      foregroundColor: Colors.white,
                                      onPressed: () {
                                        _showDialogDoctorNotes(_scaffoldKey.currentContext);

                                      }
                                  ),
                                ),



                              ])
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



class SignUpResponse {
  Data data;

  SignUpResponse({this.data});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String name;
  String frequency;
  String dosage;
  String duration;
  String type;
  Data(
      {this.name,
        this.frequency,
        this.dosage,
        this.duration,
        this.type});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    frequency = json['frequecy'];
    dosage = json['dosage'];
    duration = json['duration'];
    type = json['type'];
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['frequency'] = this.frequency;
    data['dosage'] = this.dosage;
    data['duration'] = this.duration;
    data['type'] = this.type;
    return data;
  }
}

