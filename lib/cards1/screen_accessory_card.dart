import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pharm_admin/cards1/screen_medicine_card.dart';
import 'package:pharm_admin/class/screen_class_addition.dart';
import 'package:pharm_admin/connect_db/Links.dart';
import 'package:pharm_admin/home/screen_home_page.dart';

import '../connect_db/get_post.dart';
import '../main.dart';

class accessory extends StatefulWidget {
  const accessory({Key? key}) : super(key: key);

  @override
  State<accessory> createState() => _accessoryState();
}

class _accessoryState extends State<accessory> {
  String? scannedValue;
  List<String> data = [];
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController barcode = TextEditingController();
  TextEditingController commercial_name_ar = TextEditingController();
  TextEditingController commercial_name_en = TextEditingController();
  TextEditingController pharmacentical_form = TextEditingController();
  TextEditingController package = TextEditingController();
  TextEditingController com_id = TextEditingController();
  TextEditingController price_m = TextEditingController();
  TextEditingController price_i = TextEditingController();
  get_post _req = get_post();
  addAcc() async {
    var response = await _req.postRequset(linkAddAcc, {
      "barcode": barcode.text,
      "commercial_name_ar": commercial_name_ar.text,
      "commercial_name_en": commercial_name_en.text,
      "pharmacentical_form": pharmacentical_form.text,
      "package": package.text,
      "com_id": com_id.text,
      "price_m": price_m.text,
      "price_i": price_i.text,
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
      //Navigator.pop(context);
    } else if (response['status'] == "notEmpty") {
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
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text("موافق"))
          ],
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
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: barcode,
                        //TextEditingController(text: scannedValue),
                        style:
                            TextStyle(color: Color(0XFF1e224c), fontSize: 15),
                        cursorColor: Color(0XFF1e224c),
                        cursorHeight: 23,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.qr_code_scanner,
                              color: Color(0xff778da9),
                            ),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRViewExample()),
                              );
                              setState(() {
                                barcode.text = result as String? ?? '';
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabled: true,
                          labelText: " باركود",
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
                      width: 15,
                    ),
                    Expanded(
                      child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: com_id, // استخدام TextEditingController
                          style:
                              TextStyle(color: Color(0XFF1e224c), fontSize: 15),
                          cursorColor: Color(0XFF1e224c),
                          // cursorHeight: 23,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabled: true,
                            labelText: "اسم الشركة",
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
                        suggestionsCallback: (pattern) async {
                          return data
                              .where((item) => item.startsWith(pattern))
                              .toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          setState(() {
                            com_id.text = suggestion; // تحديث قيمة حقل النص
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: tff_add_items(
                          labelText: 'اسم عربي',
                          Controls: commercial_name_ar,
                          type: TextInputType.text),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: tff_add_items(
                          labelText: 'اسم اجنبي',
                          Controls: commercial_name_en,
                          type: TextInputType.text),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: tff_add_items(
                          labelText: 'العبوة',
                          Controls: package,
                          type: TextInputType.text),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: tff_add_items(
                          labelText: 'الشكل الصيدلاني',
                          Controls: pharmacentical_form,
                          type: TextInputType.text),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: tff_add_items(
                          labelText: 'سعر النت',
                          Controls: price_i,
                          type: TextInputType.number),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: tff_add_items(
                          labelText: 'سعر العموم',
                          Controls: price_m,
                          type: TextInputType.number),
                    ),
                  ],
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
                        print(barcode.text +
                            "--" +
                            commercial_name_ar.text +
                            "--" +
                            com_id.text +
                            "--" +
                            commercial_name_en.text +
                            "--" +
                            package.text +
                            "--" +
                            pharmacentical_form.text +
                            "--" +
                            price_i.text +
                            "--" +
                            price_m.text);
                        if (barcode.text.isEmpty ||
                            commercial_name_ar.text.isEmpty ||
                            com_id.text.isEmpty ||
                            commercial_name_en.text.isEmpty ||
                            package.text.isEmpty ||
                            pharmacentical_form.text.isEmpty ||
                            price_i.text.isEmpty ||
                            price_m.text.isEmpty) {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.info,
                            body: Center(
                              child: Text(
                                'يرجى تعبئة كافة الحقول',
                              ),
                            ),
                            title: 'خطأ',
                            desc: 'لم يتم اختيار التاريخ',
                          ).show();
                        } else {
                          addAcc();
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
      ),
    );
  }
}
