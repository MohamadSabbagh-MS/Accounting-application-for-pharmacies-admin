import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pharm_admin/connect_db/Links.dart';
import 'package:pharm_admin/connect_db/get_post.dart';
import 'package:pharm_admin/home/screen_home_page.dart';
import 'package:pharm_admin/main.dart';

class company_card extends StatefulWidget {
  const company_card({Key? key}) : super(key: key);

  @override
  State<company_card> createState() => _company_cardState();
}

class _company_cardState extends State<company_card> {
  List<String> data = [];
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController company_name = TextEditingController();

  get_post _req = get_post();
  addMed() async {
    var response = await _req.postRequset(linkeAdd, {
      "name": company_name.text,
      "user_id": sharedPref.getString("id"),
    });
    print("printer : ${response}");
    if (response['status'] == "success") {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.info,
        body: Column(
          children: [
            Center(
              child: Text(
                'تمت الإضافة  ',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => homepage()));
                },
                child: Text("موافق"))
          ],
        ),
        title: 'Agree',
        desc: 'Confirm Agree',
      ).show();
    } else if (response['status'] == "notEmpty") {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.info,
        body: Center(
          child: Text(
            'موجود مسبقا!! ',
          ),
        ),
        title: 'Agree',
        desc: 'Confirm Agree',
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.info,
        body: Center(
          child: Text(
            'عذرا حدث خطأ يرجى عادة المحاولة ',
          ),
        ),
        title: 'Agree',
        desc: 'Confirm Agree',
      ).show();
    }
  }

  Future<void> fetchData() async {
    var response = await _req.postRequset(linkviewcom, {
      "user_id": sharedPref.getString("id"),
    });
    print("printer : ${response}");
    print(sharedPref.getString("id"));
    if (response['status'] == "success") {
      var jsonData = response['data'];
      setState(() {
        data = List<String>.from(jsonData);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text("بطاقة شركة"),
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formstate,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: company_name,
                  //TextEditingController(text: scannedValue),
                  style: TextStyle(color: Color(0XFF1e224c), fontSize: 15),
                  cursorColor: Color(0XFF1e224c),
                  cursorHeight: 23,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabled: true,
                    labelText: " اسم الشركة",
                    labelStyle: TextStyle(
                      color: Color(0XFF1e224c),
                      fontSize: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Color(0XFF1e224c),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Color(0XFF1e224c),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                child: Container(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xffe18505),
                      ),
                    ),
                    onPressed: () {
                      if (company_name.text.isEmpty) {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.info,
                          body: Center(
                            child: Text(
                              'يرجى كتابة اسم الشركة',
                            ),
                          ),
                          title: 'خطأ',
                          desc: 'لم يتم اختيار التاريخ',
                        ).show();
                      } else {
                        addMed();
                      }
                    },
                    child: Text('اضافة'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
