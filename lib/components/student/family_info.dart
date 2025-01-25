import 'package:flutter/material.dart';

class FamilyInfo extends StatelessWidget {
  const FamilyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Family',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
        Divider(
          height: 5,
          color: Colors.black,
          thickness: 2,
          endIndent: 550,
        ),
        SizedBox(height: 20,),
        Text('parents information ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
        SizedBox(height: 10,),
        Row(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('father\'s name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('mother\'s name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('father\'s occupation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('mothers\'s occupation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('father\'s contact', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('mother\'s contact', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('email', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(width: 30,),
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
                  Text(':', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(width: 30,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('vishnubhai r prajpati', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                  Text('nishaben v prajpati', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                  Text('Teacher', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  Text('house wife', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  Text('9978515689', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  Text('6359512259', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  Text('prajaptivr27@gmail.com', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
        Text('guardian information ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
        SizedBox(height: 10,),
        Row(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('guardian\'s name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('guardian\'s occupation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('guardian\'s contact', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text('email', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(width: 30,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text('sachin prajpati', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                  Text('bank manager', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                  Text('5689225632', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  Text('sachin334@gmail.com', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
