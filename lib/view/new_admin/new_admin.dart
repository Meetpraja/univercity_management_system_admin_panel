import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksv_student_management/components/newButton.dart';
import 'package:ksv_student_management/services/database_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/colors.dart';
import '../../components/form_TextField.dart';

class NewAdmin extends StatefulWidget {
  const NewAdmin({super.key});

  @override
  State<NewAdmin> createState() => _NewAdminState();
}

class _NewAdminState extends State<NewAdmin> {

  final _formKey = GlobalKey<FormState>();
  final client = Supabase.instance.client;

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confPassController = TextEditingController();

  bool isPassSecure = true;
  Icon icon = const Icon(Icons.remove_red_eye);
  bool showPassIcon = true;

  void togglePass() {
    setState(() {
      isPassSecure = !isPassSecure;
      showPassIcon = !showPassIcon;
    });
    if (!showPassIcon) {
      icon = const Icon(Icons.remove_red_eye_outlined);
    }
    if (showPassIcon) {
      icon = const Icon(Icons.remove_red_eye);
    }
  }
  bool isConfPassSecure = true;
  Icon confIcon = const Icon(Icons.remove_red_eye);
  bool showConfPassIcon = true;

  void toggleConfPass() {
    setState(() {
      isConfPassSecure = !isConfPassSecure;
      showConfPassIcon = !showConfPassIcon;
    });
    if (!showConfPassIcon) {
      confIcon = const Icon(Icons.remove_red_eye_outlined);
    }
    if (showConfPassIcon) {
      confIcon = const Icon(Icons.remove_red_eye);
    }
  }
  bool isLoading = false;


  Future<bool> doesEmailExist(String email) async {
    final response = await Supabase.instance.client
        .from('admins')
        .select('email')
        .eq('email', email);

    return response.isNotEmpty;
  }

  void _addAdmin() async {
    setState(() {
      isLoading = true;
    });

    final email = emailController.text;
    final password = passController.text;

    bool exists = await doesEmailExist(email);


    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('email already exist')));
      setState(() {
        isLoading = false;
      });
    } else {
      await Services().addAdmin(email,password,context).then(
          (value) {
            signUp(email, password);
          },
      );
    }
  }

  Future<void> signUp(String email,String password) async{

    try{
      await client.auth.signUp(
          email: email,
          password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('admin added successful!')),
      );
      emailController.clear();
      passController.clear();
      confPassController.clear();
    }on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message.toString()}')),
      );
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
          child: Text('Add New Admin',style: GoogleFonts.robotoMono(fontSize: 22,fontWeight: FontWeight.w700,color: secondary),),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child:Expanded(
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
                    Text('password',style: GoogleFonts.robotoMono(fontSize: 16,color: secondary),),
                    FormTextfield(
                        hint: 'password',
                        obsecure: isPassSecure,
                        keyboardType: TextInputType.text,
                        controller: passController,
                        icon: IconButton(
                            onPressed: (){
                              togglePass();
                            }, icon: icon),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'password required';
                          }else if(value.length < 8){
                            return 'must contain atLeast 8 characters';
                          }
                          return null;
                        }
                    ),
                    Text('confirm password',style: GoogleFonts.robotoMono(fontSize: 16,color: secondary),),
                    FormTextfield(
                        hint: 'confirm password',
                        obsecure: isConfPassSecure,
                        keyboardType: TextInputType.text,
                        controller: confPassController,
                        icon: IconButton(onPressed: (){
                          toggleConfPass();
                        }, icon: confIcon),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'please confirm password';
                          }else if(value != passController.text){
                            return 'password not matched';
                          }
                          return null;
                        }
                    ),
                  ],
                ),
              )
          ),
        ),
        NewButton(
            text: 'Add',
            onTap: (){
              if(_formKey.currentState!.validate()){
                _addAdmin();
              }
            },
        )
        // Spacer(),
      ],
    );
  }
}
