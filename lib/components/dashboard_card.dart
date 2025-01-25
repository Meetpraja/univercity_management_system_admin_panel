import 'package:flutter/material.dart';
import 'package:ksv_student_management/components/colors.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.title,
    required this.count
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 500,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white
      ),
      child : Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title,style: TextStyle(fontSize: 24,color: secondary),textAlign: TextAlign.center,),
          Text('$count',style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold,color: secondary),)
        ],
      )
    );
  }
}
