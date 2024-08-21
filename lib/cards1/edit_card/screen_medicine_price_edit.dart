import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pharm_admin/class/screen_class_addition.dart';

import '../../connect_db/Links.dart';
import '../../connect_db/get_post.dart';
import '../../home/screen_home_page.dart';
import '../../main.dart';

class med_price_edit extends StatefulWidget {
  const med_price_edit({Key? key}) : super(key: key);

  @override
  State<med_price_edit> createState() => _med_price_editState();
}

class _med_price_editState extends State<med_price_edit> {
  TextEditingController pricem = TextEditingController();
  TextEditingController priceh = TextEditingController();
  TextEditingController priceq = TextEditingController();
  TextEditingController pricep = TextEditingController();
  @override
  get_post _req = get_post();
  addMed() async {
    var response = await _req.postRequset(linkeEPrice, {
      "motamem": pricem.text,
      "marhame": priceh.text,
      "qtrat": priceq.text,
      "baqy": pricep.text,
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

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: tff_add_items(
                labelText: 'مراهم',
                Controls: priceh,
                type: TextInputType.number),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: tff_add_items(
                labelText: 'قطرات',
                Controls: priceq,
                type: TextInputType.number),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: tff_add_items(
                labelText: 'متممات',
                Controls: pricem,
                type: TextInputType.number),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: tff_add_items(
                labelText: 'باقي الادوية',
                Controls: pricep,
                type: TextInputType.number),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60),
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
                  addMed();
                },
                child: Text('اضافة'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
