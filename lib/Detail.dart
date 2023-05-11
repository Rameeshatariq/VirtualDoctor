import 'package:flutter/cupertino.dart';
import 'package:fluttervitualdoctor/AssessmentDetails.dart';
import 'package:fluttervitualdoctor/Appointment.dart';
import 'package:fluttervitualdoctor/Schedule.dart';
import 'package:fluttervitualdoctor/Sync.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Detail extends StatefulWidget {
final String imageUrl;
const Detail({Key key, this.imageUrl}) : super(key: key);

  @override
  _DetailState createState() => _DetailState(imageUrl: imageUrl);
}


class _DetailState extends State<Detail>  {
  final String imageUrl;
  //static Color color = HexColor('#f05b60');
  static List<String> arrays= ['123','4gt', 'hh','kk'];
  static Color tabBarColor = HexColor('#f05b60');
  static Color buttonColor= HexColor('#1bbfdd');
  static Color rowColor = HexColor('#4c667f');
  static Color navColor = HexColor('#333333');

  static DateTime now = DateTime.now();
  static String formattedDate = DateFormat('EEEE d MMM, ''yyyy').format(now);

  _DetailState({Key key, @required this.imageUrl});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('image: $imageUrl');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold (
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('History', style: TextStyle(color: Colors.white),),
          backgroundColor: tabBarColor,),
        body: Center(
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => Container(
                child: CircularProgressIndicator(
                  strokeWidth: 1.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
            ),
          ),
        ),
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
