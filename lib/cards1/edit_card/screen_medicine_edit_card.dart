import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pharm_admin/class/screen_class_addition.dart';
import 'package:pharm_admin/connect_db/Links.dart';
import 'package:pharm_admin/connect_db/get_post.dart';
import 'package:pharm_admin/home/screen_home_page.dart';
import 'package:pharm_admin/main.dart';

class med_edit_card extends StatefulWidget {
  final edit;
  const med_edit_card({Key? key, this.edit}) : super(key: key);

  @override
  State<med_edit_card> createState() => _med_edit_cardState();
}

class _med_edit_cardState extends State<med_edit_card> {
  String? scannedValue;
  List<String> data = [];
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController barcode = TextEditingController();
  TextEditingController commercial_name_ar = TextEditingController();
  TextEditingController commercial_name_en = TextEditingController();
  TextEditingController scientific_name_ar = TextEditingController();
  TextEditingController scientific_name_en = TextEditingController();
  TextEditingController caliber = TextEditingController();
  TextEditingController pharmacentical_form = TextEditingController();
  TextEditingController package = TextEditingController();
  TextEditingController com_id = TextEditingController();
  TextEditingController price_m = TextEditingController();
  TextEditingController price_i = TextEditingController();

  bool isLoading = false;

  editMed() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _req.postRequset(linkUpdateMed, {
        "barcode": barcode.text.toString(),
        "commercial_name_ar": commercial_name_ar.text.toString(),
        "commercial_name_en": commercial_name_en.text.toString(),
        "scientific_name_ar": scientific_name_ar.text.toString(),
        "scientific_name_en": scientific_name_en.text.toString(),
        "caliber": caliber.text.toString(),
        "pharmacentical_form": pharmacentical_form.text.toString(),
        "package": package.text.toString(),
        "com_id": com_id.text.toString(),
        "price_m": price_m.text.toString(),
        "price_i": price_i.text.toString(),
        "user_id": sharedPref.getString("id"),
        "med_id": widget.edit['med_id'].toString(),
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.info,
          body: Column(
            children: [
              Center(
                child: Text(
                  'تم التعديل  ',
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
  }

  get_post _req = get_post();
  // addMed() async {
  //   var response = await _req.postRequset(linkAddMed, {
  //     "barcode": barcode.text,
  //     "commercial_name_ar": commercial_name_ar.text,
  //     "commercial_name_en": commercial_name_en.text,
  //     "scientific_name_ar": scientific_name_ar.text,
  //     "scientific_name_en": scientific_name_en.text,
  //     "caliber": caliber.text,
  //     "pharmacentical_form": pharmacentical_form.text,
  //     "package": package.text,
  //     "com_id": com_id.text,
  //     "price_m": price_m.text,
  //     "price_i": price_i.text,
  //     "user_id": sharedPref.getString("id"),
  //   });
  //   print("printer : ${response}");
  //   if (response['status'] == "success") {
  //     AwesomeDialog(
  //       context: context,
  //       animType: AnimType.scale,
  //       dialogType: DialogType.info,
  //       body: Column(
  //         children: [
  //           Center(
  //             child: Text(
  //               'تم التعديل  ',
  //             ),
  //           ),
  //           ElevatedButton(
  //               onPressed: () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => MyHomePage()));
  //               },
  //               child: Text("موافق"))
  //         ],
  //       ),
  //       title: 'Agree',
  //       desc: 'Confirm Agree',
  //     ).show();
  //   } else if (response['status'] == "notEmpty") {
  //     AwesomeDialog(
  //       context: context,
  //       animType: AnimType.scale,
  //       dialogType: DialogType.info,
  //       body: Center(
  //         child: Text(
  //           'موجود مسبقا!! ',
  //         ),
  //       ),
  //       title: 'Agree',
  //       desc: 'Confirm Agree',
  //     ).show();
  //   } else {
  //     AwesomeDialog(
  //       context: context,
  //       animType: AnimType.scale,
  //       dialogType: DialogType.info,
  //       body: Center(
  //         child: Text(
  //           'عذرا حدث خطأ يرجى عادة المحاولة ',
  //         ),
  //       ),
  //       title: 'Agree',
  //       desc: 'Confirm Agree',
  //     ).show();
  //   }
  // }

  // Future<void> fetchData() async {
  //   var response = await _req.postRequset(linkviewcom, {
  //     "user_id": sharedPref.getString("id"),
  //   });
  //   print("printer : ${response}");
  //   print(sharedPref.getString("id"));
  //   if (response['status'] == "success") {
  //     var jsonData = response['data'];
  //     setState(() {
  //       data = List<String>.from(jsonData);
  //     });
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
  //
  // void initState() {
  //   fetchData();
  //   super.initState();
  // }

  void initState() {
    barcode.text = widget.edit['barcode'].toString();
    commercial_name_ar.text = widget.edit['commercial_name_ar'].toString();
    commercial_name_en.text = widget.edit['commercial_name_en'].toString();
    scientific_name_ar.text = widget.edit['scientific_name_ar'].toString();
    scientific_name_en.text = widget.edit['scientific_name_en'].toString();
    caliber.text = widget.edit['caliber'].toString();
    pharmacentical_form.text = widget.edit['pharmacentical_form'].toString();
    package.text = widget.edit['package'].toString();
    com_id.text = widget.edit['com_id'].toString();
    price_m.text = widget.edit['price_m'].toString();
    price_i.text = widget.edit['price_i'].toString();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('بطاقة تعديل دواء'),
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: barcode,
                            //TextEditingController(text: scannedValue),
                            style: TextStyle(
                                color: Color(0XFF1e224c), fontSize: 15),
                            cursorColor: Color(0XFF1e224c),
                            cursorHeight: 23,
                            decoration: InputDecoration(
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
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: tff_add_items(
                              labelText: 'اسم تجاري عربي',
                              Controls: commercial_name_ar,
                              type: TextInputType.text),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: tff_add_items(
                              labelText: 'اسم تجاري اجنبي',
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
                              labelText: 'اسم علمي عربي',
                              Controls: scientific_name_ar,
                              type: TextInputType.text),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: tff_add_items(
                              labelText: 'اسم علمي اجنبي',
                              Controls: scientific_name_en,
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
                              labelText: 'العيار',
                              Controls: caliber,
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
                              labelText: 'العبوة',
                              Controls: package,
                              type: TextInputType.text),
                        ),
                        SizedBox(
                          width: 15,
                        ),
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
                  ],
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
                      if (barcode.text.isEmpty ||
                          commercial_name_ar.text.isEmpty ||
                          com_id.text.isEmpty ||
                          commercial_name_en.text.isEmpty ||
                          scientific_name_ar.text.isEmpty ||
                          scientific_name_en.text.isEmpty ||
                          caliber.text.isEmpty ||
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
                        editMed();
                      }
                    },
                    child: Text('تعديل'),
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
