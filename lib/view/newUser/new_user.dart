import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksv_student_management/components/colors.dart';
import 'package:ksv_student_management/components/empty_container.dart';
import 'package:ksv_student_management/components/form_TextField.dart';
import 'package:ksv_student_management/model/class/class_model.dart';
import 'package:ksv_student_management/model/users/users_model.dart';
import 'package:ksv_student_management/services/database_services.dart';
import '../../model/department/department_model.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var contactController = TextEditingController();
  var enrollmentController = TextEditingController();

   String? dropdownValue;
   List<String> roles = ['STUDENT' , 'FACULTY' , 'MENTOR' , 'HOD'];
   String? rolesValue;
  String? classValue;
  String? enrollmentNo;

  List<DepartmentsModel> departments = [];
  List<ClassModel> classes = [];
  @override
  void initState() {
    super.initState();
    _fetchDepartments();
  }

  bool isFetchingDepts = false;

  Future<void> _fetchDepartments() async {
      try{
        setState(() {
          isFetchingDepts = true;
        });
        final fetchedDepartments = await Services().fetchDepartments();
        departments = fetchedDepartments;
      }catch (e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }finally{
        setState(() {
          isFetchingDepts = false;
        });
      }
  }

  bool isButtonLoading = false;

  Future<void> _fetchClasses(String departmentName) async {
    try{
      setState(() {
        isLoading = true;
      });
      final fetchClasses = await Services().fetchClasses(departmentName);
      classes = fetchClasses;
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: secondary,width: 0.8)
              )
            ),
            child: Text('Add user',style: GoogleFonts.robotoMono(fontSize: 22,fontWeight: FontWeight.w700,color: secondary),),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 30,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 10,
                        children: [
                          Text('name',style: GoogleFonts.robotoMono(fontSize: 16,color: secondary),),
                          FormTextfield(
                              hint: 'name',
                              obsecure: false,
                              keyboardType: TextInputType.text,
                              controller: nameController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'name required';
                                }
                                return null;
                              }
                          ),
                          Text('contact',style: GoogleFonts.robotoMono(fontSize: 16,color: secondary),),
                          FormTextfield(
                              hint: 'contact',
                              obsecure: false,
                              keyboardType: TextInputType.text,
                              controller: contactController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'contact required';
                                }else if(value.length != 10){
                                  return 'enter valid contact no.';
                                }
                                return null;
                              }
                          ),
                          Text('role',style: GoogleFonts.robotoMono(fontSize: 16,color: secondary),),
                          DropdownButtonFormField<String>(
                            hint: const Text('select role'),
                            value: rolesValue,
                            elevation: 20,
                            icon: Icon(
                              Icons.filter_list_outlined,
                              color: secondary,
                            ),
                            style: GoogleFonts.openSans(color: secondary, fontSize: 18),
                            dropdownColor: const Color.fromRGBO(250, 250, 250, 1.0),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor:  Color.fromRGBO(250, 250, 250, 1.0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            onChanged: (String? value) {
                              setState(() {
                                rolesValue = value!;
                              });
                            }, items: [
                            for(var role in roles)
                              DropdownMenuItem(
                                  value: role,
                                  child: Text(role),
                              ),
                          ],
                            validator: (value) {
                              if(value == null){
                                return 'please select role';
                              }
                              return null;
                            },
                          ),
                          Text('enrollment no.',style: GoogleFonts.robotoMono(fontSize: 16,color: secondary),),
                          rolesValue != null && rolesValue == 'STUDENT'
                          ? FormTextfield(
                              hint: 'enrollment no',
                              obsecure: false,
                              keyboardType: TextInputType.text,
                              controller: enrollmentController,
                              validator: (value){
                                if(rolesValue!=null){
                                  if(value!.isEmpty){
                                    return 'enrollment no. required';
                                  }else{
                                    enrollmentNo = value.toString();
                                  }
                                }
                                return null;
                              }
                          ) :
                          const EmptyContainer(title:'only available for STUDENT')
                          // Text('only available for STUDENT')

                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 10,
                        children: [
                          Text('email',style: GoogleFonts.robotoMono(fontSize: 16,color: secondary),),
                          FormTextfield(
                              hint: 'email',
                              obsecure: false,
                              keyboardType: TextInputType.text,
                              controller: emailController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'email required';
                                }
                                return null;
                              }
                          ),
                          Text('department',style: GoogleFonts.robotoMono(fontSize: 16,color: secondary),),
                          isFetchingDepts ? const Center(child: CircularProgressIndicator(),)
                          : DropdownButtonFormField<String>(
                            hint: const Text('select department'),
                              value: dropdownValue,
                              elevation: 20,
                              icon: Icon(
                                Icons.filter_list_outlined,
                                color: secondary,
                              ),
                              style: GoogleFonts.openSans(color: secondary, fontSize: 18),
                              dropdownColor:  const Color.fromRGBO(250, 250, 250, 1.0),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor:  Color.fromRGBO(250, 250, 250, 1.0),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                  _fetchClasses(value);
                                });
                              }, items: [
                                for(var dept in departments)
                                  DropdownMenuItem(
                                    value: dept.name.toString(),
                                      child: Text(dept.name.toString())
                                  )
                          ],
                            validator: (value){
                              if(value == null){
                                return 'please select department';
                              }
                              return null;
                            },
                          ),

                          Text('class',style: GoogleFonts.robotoMono(fontSize: 16,color: secondary),),
                         dropdownValue != null ?
                         rolesValue != 'HOD' ?
                         rolesValue != null ?
                             !isLoading ?
                             DropdownButtonFormField<String>(
                               hint: const Text('select class'),
                               value: classValue,
                               elevation: 20,
                               icon: Icon(
                                 Icons.filter_list_outlined,
                                 color: secondary,
                               ),
                               style: GoogleFonts.openSans(color: secondary, fontSize: 18),
                               dropdownColor:  const Color.fromRGBO(250, 250, 250, 1.0),
                               decoration: const InputDecoration(
                                 filled: true,
                                 fillColor:  Color.fromRGBO(250, 250, 250, 1.0),
                               ),
                               borderRadius: BorderRadius.circular(10),
                               onChanged: (String? value) {
                                 setState(() {
                                   classValue = value!;
                                 });
                               }, items: [
                               for(var clas in classes)
                                 DropdownMenuItem(
                                   value: clas.name,
                                   child: Text(clas.name.toString()),
                                 )
                             ],
                               validator: (value) {
                                 if(dropdownValue!=null && rolesValue!='HOD' && rolesValue != null){
                                   if(value == null){
                                     return 'please select class';
                                   }
                                 }
                                 return null;
                               },
                             ) :
                                const  Center(child: CircularProgressIndicator(),)
                             :
                             const EmptyContainer(title: 'select role')
                             :
                             const Text('class not available for hod')
                             :
                             const EmptyContainer(title: 'select department first')

                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
          // Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      nameController.clear();
                      emailController.clear();
                      contactController.clear();
                      enrollmentController.clear();
                      dropdownValue = null;
                      rolesValue = null;
                      classValue = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.shade200,
                  ),
                  child: Text('reset',style: GoogleFonts.robotoMono(color: secondary,fontSize: 16),),
                ),
                const SizedBox(width: 2,),
                isButtonLoading ? const Center(child: CircularProgressIndicator(),)
                : ElevatedButton(
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      try{
                        setState(() {
                          isButtonLoading = true;
                        });
                        await Services().addUser(
                          UsersModel(
                            name: nameController.text,
                            email: emailController.text,
                            contact: contactController.text,
                            enrollment_no: enrollmentNo,
                            departmentName: dropdownValue,
                            className: classValue,
                            role: rolesValue
                          ),
                          context
                        );
                      }catch (e){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error : ${e.toString()}'))
                        );
                      }finally{
                        setState(() {
                          isButtonLoading = false;
                          nameController.clear();
                          emailController.clear();
                          contactController.clear();
                          enrollmentController.clear();
                          enrollmentNo = null;
                          dropdownValue = null;
                          rolesValue = null;
                          classValue = null;
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade300,
                  ),
                  child: Text('submit',style: GoogleFonts.robotoMono(color: secondary,fontSize: 16),),
                ),
              ],
            ),
          )
        ],
    );
  }
}
