import 'package:flutter/material.dart';
import 'package:fluttervitualdoctor/Dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttervitualdoctor/main.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textemail = TextEditingController();
  final _textpassword = TextEditingController();
  static String doctorid;
  static String _email='';
  static String _password;
  static SharedPreferences sharedPreferences;
  static var _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final _formKey = GlobalKey<FormState>();
  static _LoginPageState stateObject = _scaffoldKey.currentContext.findAncestorStateOfType<_LoginPageState>();

  static bool _validateemail = false;
  static bool _validatepass = false;


  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/splash_logo_b.png'),
      ),
    );

    final emailText =Text('Email Address', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),);

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _textemail,
      onSaved: (value) => _email = value,
      //initialValue: 'alucard@gmail.com',
      decoration: InputDecoration(
        hintText: 'Email',
        errorText: _validateemail ? 'Email Can\'t Be Empty' : null,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),borderSide: BorderSide(color: HexColor('dbdbdb'))),
      ),
    );

    final passwordText=Text('Password', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),);


    final password = TextFormField(
      autofocus: false,
      //initialValue: 'some password',
      obscureText: true,
      controller: _textpassword,
      onSaved: (value) => _password = value,


      decoration: InputDecoration(
        hintText: 'Password',
        //errorText: _validatepass ? 'Value Can\'t Be Empty' : null,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),borderSide: BorderSide(color: HexColor('dbdbdb'))),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: () {
          _textemail.text.isEmpty ? _validateemail = true : _validateemail = false;
          _textpassword.text.isEmpty ? _validatepass = true : _validatepass = false;
          _formKey.currentState.save();
          login(context,_email);
        },
        padding: EdgeInsets.all(14),
        color: HexColor('#50ba58'),
        child: Text('LOGIN', style: TextStyle(color: Colors.white)),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 68.0),
            emailText,
            SizedBox(height: 5.0),
            email,
            SizedBox(height: 15.0),
            passwordText,
            SizedBox(height: 5.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            //forgotLabel
          ],
        ),
      )
      ),
    );
  }

  static void login(BuildContext context,email) async{
    if(!_validateemail){
      print('form is valid');
      print('email: $email');
      if(email == ''){
        Fluttertoast.showToast(msg: 'Email Can\'t Be Empty');
      }
      if(_password == ''){
        _password = null;
      }

      var result = await Firestore.instance
          .collection("doctor")
          .where("email", isEqualTo: _email)
          .getDocuments();
      result.documents.forEach((res) async{
        doctorid = res.data['id'];
        if(res.data['password'] == _password){
          print('correct email');

          print(res.data['id']);
          sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString('id', res.data['id']);

          print(sharedPreferences.getString('id'));


          //await new Future.delayed(new Duration(milliseconds: 500));
         // Navigator.of(_scaffoldKey.currentContext).pushNamed("/Dashboard");

          // Navigator.of(_scaffoldKey.currentContext).pushNamed('/Dashboard');
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(doctorid: sharedPreferences.getString('id'))));
        }
        else{
          Fluttertoast.showToast(msg: 'Invalid Email or Password');
          print('incorrect email');
        }
        print(res.data);
      });

/*

      Firestore.instance.collection('doctor').where('email', isEqualTo: _email)
          .snapshots().listen(
              (data) =>
                //  print('grower ${data.documents[0]['email']}')

    );
*/
          }
    else{
      Fluttertoast.showToast(msg: 'Invalid Email or Password');
      print('form is invalid');
    }
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

