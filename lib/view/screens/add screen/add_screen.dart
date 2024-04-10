import 'dart:io';

import 'package:core_exam_two/utils/global_variables.dart';
import 'package:core_exam_two/view/screens/home%20screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/student_model.dart';
import '../../../utils/colors.dart';

class AddStudentData extends StatefulWidget {
  final Student student;

  const AddStudentData({super.key, required this.student});

  @override
  State<AddStudentData> createState() => _AddStudentDataState();
}

class _AddStudentDataState extends State<AddStudentData> {
  void toggleState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isForEditing) {
      txtName = TextEditingController(text: widget.student.student_name);
      txtGrid = TextEditingController(text: '${widget.student.student_grid}');
      txtStandard =
          TextEditingController(text: '${widget.student.student_standard}');
      imgPath = widget.student.img;
    } else {
      txtName = TextEditingController();
      txtGrid = TextEditingController();
      txtStandard = TextEditingController();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Add Student',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
        
            //name
            Form(
              key: key,
              child: Column(
                children: [
                  textField(context: context, title: 'Name', controller: txtName),
        
                  //gr id
                  textField(
                    context: context,
                    title: 'GRID',
                    textInputType: TextInputType.number,
                    controller: txtGrid,
                  ),
        
                  //standard
                  textField(
                      context: context,
                      title: 'Standard',
                      textInputType: TextInputType.number,
                      controller: txtStandard),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                imgPath == null ? const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ) : CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(imgPath!),
                ),

                const SizedBox(width: 10,),

                TextButton(onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  final XFile? img = await imagePicker.pickImage(source: ImageSource.gallery);
                  imgPath = File(img!.path);
                  toggleState();
                  if(isForEditing){
                    widget.student.img = imgPath;
                  }



                }, child:  Text('Pick image', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: primaryColor
                ),),),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
        
            //submit button
        ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            foregroundColor: MaterialStatePropertyAll(primaryColor),
            backgroundColor: MaterialStatePropertyAll(secondaryColor),
          ),
          onPressed: () {
            if (!key.currentState!.validate() || imgPath == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text('Please fill!'), duration: Duration(seconds: 1),)
              );
            } else {
              if(isForEditing){
                widget.student.student_name = txtName.text;
                widget.student.student_grid = int.parse(txtGrid.text);
                widget.student.student_standard = int.parse(txtStandard.text);
                widget.student.img = imgPath;
                toggleState();

              } else {
                Student student = Student(student_name: txtName.text, student_grid: int.parse(txtGrid.text), student_standard: int.parse(txtStandard.text), img: imgPath);
                studentList.add(student);
                txtName.clear();
                txtGrid.clear();
                txtStandard.clear();
                imgPath = null;
                toggleState();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saved!'), duration: Duration(seconds: 1),)
              );
            }
          },
          child: const Text('Save'),
        ),
          ],
        ),
      ),
    );
  }



  Column textField(
      {required BuildContext context,
      required String title,
      TextInputType? textInputType,
      TextInputAction? textInputAction,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Student $title : ',
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: TextFormField(
            controller: controller,
            validator: (value) =>
                value!.isEmpty || value == '' ? 'Please fill' : null,
            keyboardType: textInputType ?? TextInputType.name,
            textInputAction: textInputAction ?? TextInputAction.next,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            cursorColor: primaryColor,
            style: TextStyle(color: primaryColor),
            decoration: InputDecoration(
              labelText: 'Student $title',

              //normal border
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: secondaryColor, width: 1)),

              //enabled border
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: secondaryColor, width: 1)),

              //focus border border
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: primaryColor, width: 2)),
            ),
          ),
        ),
      ],
    );
  }
}
