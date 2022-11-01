import 'package:flutter/material.dart';

class PersonSearchModel{
  String? image;
  String name;
  int id;
  bool isSelcted=false;
  PersonSearchModel({  this.image , required this.name , required this.id  });
}