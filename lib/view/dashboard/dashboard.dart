import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksv_student_management/components/colors.dart';
import 'package:ksv_student_management/components/dashboard_card.dart';
import 'package:ksv_student_management/services/database_services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int? students;
  int? teachers;
  int? courses;
  int? classes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _counts();
  }

  void _counts()async{
   try{
     setState(() {
       isLoading = true;
     });
     students = await Services().countUsersByRole('STUDENT');
     teachers = await Services().countUsersByRole('FACULTY');
     courses = await Services().countCourses();
     classes = await Services().countClassroom();
   }catch (e){
     print('Error : $e');
   }finally{
     setState(() {
       isLoading = false;
     });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: tertiary,
            border: Border(bottom: BorderSide(color: secondary.withOpacity(0.8),width: 1))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/logo-ldrp.png',height: 80,),
              const SizedBox(width: 20,),
              Text('LDRP Institute of Technology and Research',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: secondary
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        isLoading
            ?  const Center(child: CircularProgressIndicator(),)
            : Padding(
          padding: const EdgeInsets.all(15),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.spaceBetween,
            spacing: 20,
            runSpacing: 20,
            children: [
              DashboardCard(
                title: 'Total Students',
                count: students!,
              ),
              DashboardCard(
                title: 'Total Teachers',
                count: teachers!,
              ),
              DashboardCard(
                title: 'Classrooms',
                count: classes!,
              ),
              DashboardCard(
                title: 'Courses',
                count: courses!,
              ),
              DashboardCard(
                title: 'Courses',
                count: 15,
              ),
              DashboardCard(
                title: 'Courses',
                count: 15,
              ),
            ],
          ),
        ),

      ],
    );
  }
}
