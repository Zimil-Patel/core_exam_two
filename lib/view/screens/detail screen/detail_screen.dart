import 'package:core_exam_two/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../models/student_model.dart';
import '../../../utils/global_variables.dart';
import '../add screen/add_screen.dart';
import '../home screen/home_screen.dart';

class DetailScreen extends StatefulWidget {
  final Student student;

  const DetailScreen({super.key, required this.student});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(widget.student.student_name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(widget.student.img!),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name :  ',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(widget.student.student_name!),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'GRID :  ',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Text('${widget.student.student_grid!}'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Standard :  ',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Text('${widget.student.student_standard!}'),
                    ],
                  ),
                ],
              ),
            ),

            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                foregroundColor: MaterialStatePropertyAll(primaryColor),
                backgroundColor: MaterialStatePropertyAll(secondaryColor),
              ),
              onPressed: () {
                isForEditing = true;
                Navigator.of(context)
                    .pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        AddStudentData(
                            student:
                            widget.student),
                  ),
                );
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
