import 'package:flutter/material.dart';
import 'package:ksv_student_management/model/class/class_model.dart';
import 'package:ksv_student_management/model/department/department_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ksv_student_management/model/users/users_model.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Services{
  var database = Supabase.instance.client.from('users');
  var adminDatabase = Supabase.instance.client.from('admins');

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // adding admin
  Future addAdmin(String email,String password,BuildContext context) async{


    String hashedPassword = hashPassword(password);
    try{
      await adminDatabase.insert(
          {
            'email': email,
            'pass_hash' : hashedPassword
          }
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('admin added'))
      );
    }catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
      );
    }
  }

  // adding user
  Future addUser(UsersModel newUser,BuildContext context) async{
    try{
      await database.insert(
          {
            'name': newUser.name,
            'email': newUser.email,
            'enrollment_no' : newUser.enrollment_no,
            'contact': newUser.contact,
            'role': newUser.role,
            'department_name': newUser.departmentName,
            'class_name': newUser.className,
          }
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('user added successfully'))
      );
    }catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }

  //fetching users based on role
  Future<List<UsersModel>> fetchUsers(String role) async {
    PostgrestList response;
    if(role == 'STUDENT'){
       response = await Supabase.instance.client
          .from('users')
          .select('*')
          .eq('role', role).order('enrollment_no',ascending: true);
    }else{
       response = await Supabase.instance.client
          .from('users')
          .select('*')
          .eq('role', role);
    }

    if (response.isEmpty) {
      print('empty data');
      return [];
    }
    return response.map((userMap) => UsersModel.fromMap(userMap as Map<String, dynamic>)).toList();
  }

  //count user
  Future<int> countUsersByRole(String role) async {
    try {
      final response = await Supabase.instance.client
          .from('users')
          .select('*')
          .eq('role', role)
          .count(CountOption.exact);
      return response.count ?? 0;
    } catch (e) {
      print('Error fetching $role count: $e');
      return 0;
    }
  }

  //count course
  Future<int> countCourses() async {
    try {
      final response = await Supabase.instance.client
          .from('departments')
          .select('*')
          .count(CountOption.exact);
      return response.count ?? 0;
    } catch (e) {
      print('Error fetching courses count: $e');
      return 0;
    }
  }

  //count classroom
  Future<int> countClassroom() async {
    try {
      final response = await Supabase.instance.client
          .from('classes')
          .select('*')
          .count(CountOption.exact);
      return response.count ?? 0;
    } catch (e) {
      print('Error fetching classes count: $e');
      return 0;
    }
  }

  //updating user
  Future updateUser(String userId,UsersModel userForUpdate,BuildContext context) async {
    try{
      await database.update({
        'name': userForUpdate.name,
        'email': userForUpdate.email,
        'enrollment_no' : userForUpdate.enrollment_no,
        'contact': userForUpdate.contact,
        'role': userForUpdate.role,
        'department_name': userForUpdate.departmentName,
        'class_name': userForUpdate.className,
      }).eq('id', userId).then((value){
        return ScaffoldMessenger.of(context)
            .showSnackBar(
            const SnackBar(content: Text('user updated successfully'))
        );
      }
      );
    }catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
      );
    }
  }

  //delete
  Future delete(String id) async{
    await database.delete().eq('id',id);
  }

  // fetching departments
  Future<List<DepartmentsModel>> fetchDepartments() async {
    final response = await Supabase.instance.client
        .from('departments')
        .select('*');

    if (response.isEmpty) {
      print('empty data');
      return [];
    }

    return response.map((userMap) => DepartmentsModel.fromMap(userMap as Map<String, dynamic>)).toList();
  }

  //fetching class
  Future<List<ClassModel>> fetchClasses(String departmentName) async {
    final response = await Supabase.instance.client
        .from('classes')
        .select('*')
        .eq('department_name', departmentName);

    if (response.isEmpty) {
      print('empty data');
      return [];
    }

    return response.map((userMap) => ClassModel.fromMap(userMap as Map<String, dynamic>)).toList();
  }


}