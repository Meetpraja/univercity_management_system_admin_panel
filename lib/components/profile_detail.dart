import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 10,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10,),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.lightBlue.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}
