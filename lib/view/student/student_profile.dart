import 'package:flutter/material.dart';
import 'package:ksv_student_management/components/profile_appbar.dart';
import 'package:ksv_student_management/components/student/academic_info.dart';
import 'package:ksv_student_management/components/student/family_info.dart';
import 'package:ksv_student_management/components/student/personal_info.dart';


class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(100), child: ProfileAppbar()),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: size.width/1.8,
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: PersonalInfo(),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 30,top: 20,right: 30,bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: AcademicInfo(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 30,top: 20,right: 30,bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: FamilyInfo(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
