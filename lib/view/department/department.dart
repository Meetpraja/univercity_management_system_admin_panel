import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksv_student_management/components/colors.dart';
import 'package:ksv_student_management/components/department/deptCard.dart';
import 'package:ksv_student_management/model/department/department_model.dart';
import 'package:ksv_student_management/services/database_services.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: secondary,width: 1))
          ),

          child: Text('DEPARTMENTS',style: GoogleFonts.robotoMono(fontSize: 24,color: secondary,fontWeight: FontWeight.w600),),
        ),
        FutureBuilder<List<DepartmentsModel>>(
          future: Services().fetchDepartments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snapshot.error.toString())));
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No departments available.'));
            }

            final depts = snapshot.data!;

            return Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.spaceBetween,
              spacing: 20,
              runSpacing: 20,
              children: [
                for(var dept in depts)
                  Deptcard(title: dept.name.toString()),
              ],
            );
          },
        ),

      ],
    );
  }
}
