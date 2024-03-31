import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void click(String Uniname, BuildContext c) {
  AwesomeDialog(
    context: c,
    dialogType: DialogType.info,
    animType: AnimType.scale,
    dialogBackgroundColor: Colors.white70,
    title: 'SELECTION LIST UPDATED',
    desc: '${Uniname} has been added to list',
    descTextStyle: TextStyle(fontSize: 15),
    btnOkOnPress: () {},
  ).show();
}
