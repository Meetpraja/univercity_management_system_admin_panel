import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.name,
    required this.course,
    required this.department,
    required this.enrollment
  });

  final String name;
  final String course;
  final String department;
  final String enrollment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      height: 60,
      // padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 170,
                    child: Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                SizedBox(
                  width: 200,
                    child: Text(course,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500))),
                SizedBox(
                  width: 200,
                    child: Text(department,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500))),
                SizedBox(
                  width: 150,
                    child: Text(enrollment,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500))),
                myEditable()
              ],
            ),
          ),
          // Spacer(),
          const SizedBox(height: 15,),
          const Divider(
            thickness: 1,
            color: Colors.grey,
            height: 2,

          ),
        ],
      ),
    );
  }
  Widget myEditable(){
    return Row(
      children: [
        IconButton(
          onPressed: (){},
          icon: const Icon(Icons.edit),
        ),
        const SizedBox(width: 10,),
        IconButton(
          onPressed: (){},
          icon: const Icon(Icons.delete),
        )
      ],
    );
  }
}
