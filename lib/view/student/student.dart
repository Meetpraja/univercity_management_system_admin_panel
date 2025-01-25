import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksv_student_management/components/colors.dart';

import 'package:ksv_student_management/components/student_list.dart';
import 'package:ksv_student_management/view/student/update_user.dart';
import '../../model/department/department_model.dart';
import '../../model/users/users_model.dart';
import '../../services/database_services.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {

  List<UsersModel> users = [];
  List<DepartmentsModel> departments = [];

  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    _fetchDepartments();
    _fetchUsers();
  }

  bool isFetchingDepts = false;

  Future<void> _fetchDepartments() async {
    try {
      setState(() {
        isFetchingDepts = true;
      });
      final fetchedDepartments = await Services().fetchDepartments();
      departments = fetchedDepartments;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isFetchingDepts = false;
      });
    }
  }

  bool isFetchingUser = false;

  Future<void> _fetchUsers() async {
    try {
      setState(() {
        isFetchingUser = true;
      });
      final fetchedUser = await Services().fetchUsers('STUDENT');
      users = fetchedUser;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isFetchingUser = false;
      });
    }
  }

  bool isDeleting = false;

  void _deleteUser(String id,String name,String department,String clas,BuildContext ctx)async{
    showDialog(
        context: ctx,
        builder: (BuildContext ctx) {
          return AlertDialog(
            alignment: Alignment.center,
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: const EdgeInsets.only(top: 20),
              height: 180,
              width: 400,
              child: Column(
                children: [
                  Text(
                    'are you sure ?',
                    style: GoogleFonts.openSans(
                        color: secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'you want to remove $name ?',
                    style: GoogleFonts.openSans(color: secondary, fontSize: 16),
                  ),
                  Text(
                    'department : $department',
                    style: GoogleFonts.openSans(color: secondary, fontSize: 16),
                  ),
                  Text(
                    'Class : $clas',
                    style: GoogleFonts.openSans(color: secondary, fontSize: 16),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20)),
                                color: Colors.green,
                              ),
                              child: Text('cancel',
                                  style: GoogleFonts.robotoMono(
                                      color: secondary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () async{
                              setState(() {
                                isDeleting = true;
                              });
                              await Services().delete(id).then(
                                    (value) {
                                  _fetchUsers();
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('user deleted successfully')));
                                  setState(() {
                                    isDeleting = false;
                                  });
                                  Get.back();
                                },
                              );
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(20)),
                                color: Colors.redAccent.withOpacity(0.8),
                              ),
                              child: Text('remove',
                                  style: GoogleFonts.robotoMono(
                                      color: secondary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
  bool isList = true;
  bool isUpdateUser = false;
  UsersModel? updateUser;

  void onBack(){
    _fetchUsers();
    setState(() {
      isList = true;
      isUpdateUser = false;
    });
  }

  void onUpdateUser(UsersModel user){
    updateUser = user;
    setState(() {
      isList = false;
      isUpdateUser = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isDeleting){
      return const Center(child: CircularProgressIndicator(),);
    }

    if (isFetchingDepts || isFetchingUser) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredUsers = dropdownValue == null
        ? users
        : users.where((user) => user.departmentName == dropdownValue).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        isList ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
              color: tertiary,
              border: Border(bottom: BorderSide(color: secondary, width: 1))
              ),
          child: Row(
            children: [
              Text('STUDENTS LIST',
                  style: GoogleFonts.robotoMono(
                      fontSize: 24,
                      color: secondary,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              isFetchingDepts
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : departments.isEmpty ?
                  const Text('no departments available') :
              Expanded(
                child: DropdownButtonFormField<String>(
                        hint: const Text('select department'),
                        value: dropdownValue,
                        elevation: 20,
                        icon: Icon(
                          Icons.filter_list_outlined,
                          color: secondary,
                        ),
                        style:
                            GoogleFonts.openSans(color: secondary, fontSize: 18),
                        dropdownColor: const Color.fromRGBO(250, 250, 250, 1.0),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(250, 250, 250, 1.0),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                            // users = users.where((user)=>user.departmentName == value).toList();
                            // print(value);
                          });
                        },
                        items:
                        departments.isEmpty ? [] :
                          departments.map((dept) {
                            return DropdownMenuItem(
                              value: dept.name.toString(),
                              child: Text(dept.name.toString()),
                            );
                          }).toList(),
                      ),
              ),
            ],
          ),
        ) : Container(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: secondary,width: 0.8)
              )
          ),
          child: Row(
            children: [
              IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back_outlined,size: 24,)),
              Text('Update user',style: GoogleFonts.robotoMono(fontSize: 22,fontWeight: FontWeight.w700,color: secondary),),
            ],
          ),
        ),
        isUpdateUser ? UpdateUser(user: updateUser!,onBack: onBack):
        isFetchingUser
            ? const Center(child: CircularProgressIndicator())
            : users.isEmpty
            ? const Center(child: Text('No students found'))
            : StudentList(users: filteredUsers,onDelete: _deleteUser,onUpdateuser: onUpdateUser,)

      ],
    );
  }
}
