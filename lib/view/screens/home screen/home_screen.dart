import 'dart:io';

import 'package:core_exam_two/utils/colors.dart';
import 'package:core_exam_two/utils/global_variables.dart';
import 'package:core_exam_two/view/screens/add%20screen/add_screen.dart';
import 'package:core_exam_two/view/screens/detail%20screen/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/student_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void toggleState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    isForEditing = false;
    imgPath = null;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student List',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
                studentList.length,
                (index) => buildGestureDetector(context, index))
          ],
        ),
      ),
      floatingActionButton:
          floatingActionButton(context: context, toggleState: toggleState),
    );
  }

  GestureDetector buildGestureDetector(BuildContext context, int index) {
    return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailScreen(student: studentList[index],),));
                    },
                    child: Container(
                      width: width,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: secondaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            onPressed: () async {
                              ImagePicker imagePicker = ImagePicker();
                              final XFile? img = await imagePicker.pickImage(source: ImageSource.gallery);
                              studentList[index].img = File(img!.path);
                              toggleState();
                              imgPath = null;
                            },
                            padding: EdgeInsets.zero,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  FileImage(studentList[index].img!),
                            ),
                          ),

                          //info
                          Expanded(
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Name :  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(studentList[index]
                                              .student_name!),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'GRID :  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                              '${studentList[index].student_grid!}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Standard :  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                              '${studentList[index].student_standard!}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {

                                          isForEditing = true;
                                          Navigator.of(context)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddStudentData(
                                                      student:
                                                          studentList[index]),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          studentList.removeAt(index);
                                          toggleState();
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
  }

  FloatingActionButton floatingActionButton(
      {required BuildContext context,
      required final VoidCallback toggleState}) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: secondaryColor,
      onPressed: () {
        isForEditing = false;
        Student student = Student();
        txtName = TextEditingController();
        txtGrid = TextEditingController();
        txtStandard = TextEditingController();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AddStudentData(
            student: student,
          ),
        ));
      },
      child: const Icon(Icons.add),
    );
  }
}
