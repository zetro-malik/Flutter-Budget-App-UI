 import 'package:flutter/material.dart';

MaterialColor getColor(percent){
  return percent >.5 ?  Colors.green : percent > .25? Colors.orange : Colors.red;
 }  