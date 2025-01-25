import 'package:flutter/material.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.lightBlue.withOpacity(0.7),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back,size: 30,color: Colors.black,weight: 700,),
          ),
          const SizedBox(width: 20,),
          Text(
            'Student Profile',
            style: TextStyle(fontSize: 26,color: Colors.black,fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          InkWell(
            child: myButton(Colors.lightBlue.withOpacity(0.8), 'Edit info'),
            onTap: (){},
          ),
          const SizedBox(width: 10,),
          InkWell(
            child: myButton(Colors.redAccent.withOpacity(0.9), 'Remove Student'),
            onTap: (){},
          ),
        ],
      ),
    );
  }
  Widget myButton(Color color,String text){
    return Container(
      height: 40,
      width: 170,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color,
      ),
      child: Text(text),
    );
  }
}
