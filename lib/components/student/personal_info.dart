import 'package:flutter/material.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'prajapatimv15@gamil.com',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              Text(
                '6351225930',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              Text(
                'O+',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                'MIT PRAJAPATI',
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Spacer(),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(300)),
          child: Image.asset(
            'assets/student.jpg',
            height: 250,
            width: 250,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
