import 'package:flutter/material.dart';
class SingleTon{
  static  final SingleTon role=SingleTon._internal();
  factory SingleTon()=>role;
  SingleTon._internal();
  String? userRole

  ;
}