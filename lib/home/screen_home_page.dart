import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pharm_admin/cards1/edit_card/screen_accessory_edit.dart';
import 'package:pharm_admin/cards1/edit_card/screen_medicine_edit.dart';
import 'package:pharm_admin/cards1/edit_card/screen_medicine_price_edit.dart';
import 'package:pharm_admin/cards1/screen_accessory_card.dart';
import 'package:pharm_admin/cards1/screen_company_card.dart';
import 'package:pharm_admin/cards1/screen_medicine_card.dart';
import 'package:pharm_admin/log%20in/screen_login.dart';
import 'package:pharm_admin/main.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _page = 0;
  String _displayText = 'اضافة دواء';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text(_displayText),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image(
                image: AssetImage('images/logo1.png'),
              ), //Text('القائمة'),
              //decoration: BoxDecoration(
              // color: Colors.blue,
              //),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.sanitizer_outlined,
                  color: Color(0XFF1e224c),
                ),
                textColor: Colors.black,
                title: Text(
                  "إضافة شركة",
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => company_card()),
                  );
                },
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.sanitizer_outlined,
                  color: Color(0XFF1e224c),
                ),
                textColor: Colors.black,
                title: Text(
                  "تعديل دواء",
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => med_edit()),
                  );
                },
              ),
            ),
            Container(
              child: ListTile(
                textColor: Colors.black,
                leading: Icon(
                  Icons.sanitizer_outlined,
                  color: Color(0XFF1e224c),
                ),
                title: Text(
                  "تعديل اكسسوار",
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => acc_edit()),
                  );
                },
              ),
            ),
            Container(
              child: ListTile(
                textColor: Colors.black,
                leading: Icon(
                  Icons.exit_to_app,
                  color: Color(0XFF1e224c),
                ),
                title: Text(
                  "تسجيل خروج",
                  style: TextStyle(
                    color: Color(0XFF1e224c),
                  ),
                ),
                onTap: () {
                  sharedPref.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => login()));
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.medication_outlined,
            color: Colors.white,
            size: 30.0,
          ),
          Icon(
            Icons.medical_services_outlined,
            color: Colors.white,
            size: 30.0,
          ),
          Icon(
            Icons.update,
            color: Colors.white,
            size: 30.0,
          ),
        ],
        color: Color(0XFF1e224c),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
            switch (_page) {
              case 0:
                _displayText = 'إضافة دواء';
                break;
              case 1:
                _displayText = 'اضافة اكسسوار';
                break;
              case 2:
                _displayText = 'تعديل اسعار الدواء';
                break;
            }
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Container(
          width: double.infinity,
          height: double.maxFinite,
          child: page(_page),
        ),
      ),
    );
  }
}

Widget page(value) {
  if (value == 0) {
    return medicine();
  } else if (value == 1) {
    return accessory();
  } else {
    return med_price_edit();
  }
}
