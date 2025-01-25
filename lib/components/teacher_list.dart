import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/users/users_model.dart';
import '../services/database_services.dart';
import 'colors.dart';

class TeacherList extends StatefulWidget {
   const TeacherList({
    super.key,
    required this.users,
     required this.onDelete,
     required this.onUpdateUser
  });

  final List<UsersModel> users;
  final void Function(String,String,String,String,BuildContext) onDelete;
   final Function(UsersModel) onUpdateUser;

  @override
  State<TeacherList> createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return widget.users.isEmpty
        ? const Center(child: Text('no teachers found'),)
        : Container(
        color: tertiary,
        child:  Scrollbar(
          controller: _scrollController,
          thickness: 5,
          trackVisibility: true,
          thumbVisibility: true,
          radius: Radius.circular(1),
          scrollbarOrientation: ScrollbarOrientation.top,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: DataTable(
              headingTextStyle: GoogleFonts.openSans(color: secondary,fontWeight: FontWeight.w600,fontSize: 18),
              dataTextStyle: GoogleFonts.openSans(color: secondary),
              columnSpacing: 80,
              dividerThickness: 0.5,
              dataRowHeight: 60,
              columns: _dataColumn(),
              rows: widget.users.map((e)=>DataRow(cells: [
                DataCell(Text(e.name.toString())),
                DataCell(Text(e.email.toString())),
                DataCell(Text(e.contact.toString())),
                DataCell(Text(e.departmentName.toString())),
                DataCell(Text(e.className.toString())),
                DataCell(Row(
                  children: [
                    IconButton(onPressed: (){
                      widget.onUpdateUser(e);
                    }, icon: const Icon(Icons.edit)),
                    IconButton(onPressed: (){
                      widget.onDelete(e.id.toString(),e.name.toString(),e.departmentName.toString(),e.className.toString(),context);
                    }, icon: const Icon(Icons.delete)),
                  ],
                ))
              ])).toList(),
            ),
          ),
        )
    );
  }

  List<DataColumn> _dataColumn() {
    return [
      DataColumn(label: Text('name')),
      DataColumn(label: Text('email')),
      DataColumn(label: Text('contact')),
      DataColumn(label: Text('department')),
      DataColumn(label: Text('class')),
      DataColumn(label: Text('Edit / Delete'))
    ];
  }
}
