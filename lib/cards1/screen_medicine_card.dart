import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pharm_admin/home/screen_home_page.dart';
import 'package:pharm_admin/main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../class/screen_class_addition.dart';
import '../connect_db/Links.dart';
import '../connect_db/get_post.dart';

class medicine extends StatefulWidget {
  const medicine({Key? key}) : super(key: key);

  @override
  State<medicine> createState() => _medicineState();
}

class _medicineState extends State<medicine> {
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
  get_post _req = get_post();
  addMed() async {
    var response = await _req.postRequset(linkAddMed, {
      "barcode": barcode.text,
      "commercial_name_ar": commercial_name_ar.text,
      "commercial_name_en": commercial_name_en.text,
      "scientific_name_ar": scientific_name_ar.text,
      "scientific_name_en": scientific_name_en.text,
      "caliber": caliber.text,
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
                            keyboardType: TextInputType.number,
                            controller: barcode,
                            //TextEditingController(text: scannedValue),
                            style: TextStyle(
                                color: Color(0XFF1e224c), fontSize: 15),
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
                              controller:
                                  com_id, // استخدام TextEditingController
                              style: TextStyle(
                                  color: Color(0XFF1e224c), fontSize: 15),
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
                        )
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

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool onpress = false;
  String? scannedvalue;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: FloatingActionButton(
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.orange,
                ),
              ),
              backgroundColor:
                  onpress == false ? Colors.transparent : Colors.orange,
              child: Icon(Icons.flash_on_outlined),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {
                  if (onpress == false) {
                    onpress = true;
                  } else {
                    onpress = false;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.orange,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        scannedvalue = scanData.code;
      });
      if (scannedvalue != null) {
        controller.pauseCamera();
        Navigator.pop(context, scannedvalue);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
