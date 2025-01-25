import 'package:flutter/material.dart';

class NewButton extends StatelessWidget {
  const NewButton({
    super.key,
    required this.text,
    required this.onTap,

  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 550,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromRGBO(78, 138, 245, 1)
        ),
        child: Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
      ),
    );
  }
}
