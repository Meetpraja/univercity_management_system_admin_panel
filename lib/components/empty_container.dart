import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({
    super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(title,style: GoogleFonts.robotoMono(),),
    );
  }
}
