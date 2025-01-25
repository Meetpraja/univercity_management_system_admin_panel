import 'package:flutter/material.dart';

class AcademicInfo extends StatelessWidget {
  const AcademicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Academic',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
        Divider(
          height: 5,
          color: Colors.black,
          thickness: 2,
          endIndent: 730,
        ),
        SizedBox(height: 20,),
        Row(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Department', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('Course', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('Enrollment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('Class', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('Batch', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('Batch-year', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(width: 220,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(':', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text(':', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text(':', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text(':', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text(':', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text(':', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(width: 30,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bachelor of Engineering', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('Information Technology', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('21BEIT30109', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('IT-J', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('IT-02', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('2021-2025', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
