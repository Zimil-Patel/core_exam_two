import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/student_model.dart';

List<Student> studentList = [];

double? width;
GlobalKey<FormState> key = GlobalKey<FormState>();

TextEditingController txtName = TextEditingController();
TextEditingController txtGrid = TextEditingController();
TextEditingController txtStandard = TextEditingController();
File? imgPath;

bool isForEditing = false;