import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksv_student_management/components/colors.dart';

class Deptcard extends StatelessWidget {
  const Deptcard({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: 150,
          width: 500,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white
          ),
          child : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(title,style: GoogleFonts.robotoMono(fontSize: 24,fontWeight: FontWeight.w500),),
              Icon(Icons.navigate_next_rounded,size: 50,)
            ],
          )
      ),
    );
  }
}
