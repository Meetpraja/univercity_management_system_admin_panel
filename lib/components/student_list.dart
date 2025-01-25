import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksv_student_management/components/colors.dart';
import 'package:ksv_student_management/services/database_services.dart';
import 'package:ksv_student_management/view/student/update_user.dart';
import '../model/users/users_model.dart';

class StudentList extends StatefulWidget {
   const StudentList({
    super.key,
    required this.users,
     required this.onDelete,
     required this.onUpdateuser
  });
  final List<UsersModel> users;
  final void Function(String,String,String,String,BuildContext) onDelete;
   final Function(UsersModel) onUpdateuser;

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {

  final ScrollController _scrollController = ScrollController();

  UsersModel? user;

  @override
  Widget build(BuildContext context) {

   return widget.users.isEmpty
       ? const Center(child: Text('no students found'),)
       : Container(
    color: tertiary,
          child:  Scrollbar(
            controller: _scrollController,
            thickness: 5,
            radius: Radius.circular(1),
            thumbVisibility: true,
            trackVisibility: true,
            scrollbarOrientation: ScrollbarOrientation.top,
            // interactive: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingTextStyle: GoogleFonts.openSans(color: secondary,fontWeight: FontWeight.w600,fontSize: 18),
                  dataTextStyle: GoogleFonts.openSans(color: secondary),
                columnSpacing: 80,
                dividerThickness: 0.5,
                dataRowHeight: 60,
                  columns: _dataColumn(),
                  rows: widget.users.map((e){
                    user = e;
                    return DataRow(cells: [
                      DataCell(Text(e.name.toString())),
                      DataCell(Text(e.enrollment_no.toString())),
                      DataCell(Text(e.email.toString())),
                      DataCell(Text(e.contact.toString())),
                      DataCell(Text(e.departmentName.toString())),
                      DataCell(Text(e.className.toString())),
                      DataCell(Row(
                        children: [
                          IconButton(
                              onPressed: (){
                                widget.onUpdateuser(e);
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(onPressed: (){
                            widget.onDelete(e.id.toString(),e.name.toString(),e.departmentName.toString(),e.className.toString(),context);
                          }, icon: const Icon(Icons.delete)),
                        ],
                      ))
                    ]);
                  }).toList(),
              ),
            ),
          )
    );

  }

  List<DataColumn> _dataColumn() {
    return [
      const DataColumn(label: Text('name')),
      const DataColumn(label: Text('enrollment')),
      const DataColumn(label: Text('email')),
      const DataColumn(label: Text('contact')),
      const DataColumn(label: Text('department')),
      const DataColumn(label: Text('class')),
      const DataColumn(label: Text('Edit / Delete'))
    ];
  }
}
