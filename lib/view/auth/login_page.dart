import 'package:flutter/material.dart';
import 'package:ksv_student_management/components/my_button.dart';
import 'package:ksv_student_management/components/my_textfield.dart';
import 'package:ksv_student_management/view/home/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  SupabaseClient client = Supabase.instance.client;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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

  bool isLoading = false;

  Future<void> login() async{
    setState(() {
      isLoading = true;
    });
    final email = emailController.text;
    final password = passwordController.text;

    try{
      final userData = await client
          .from('admins')
          .select('email')
          .eq('email', email)
          .single();

      final adminEmail = userData['email'];

      if(adminEmail == email){
        final response = await client.auth.signInWithPassword(
          email: email,
          password: password,
        );
        if (response.user != null) {

          Get.offAll(()=>const Home());

        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('invalid credentials for admin'))
          );
        }
        emailController.clear();
        passwordController.clear();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('invalid credentials for admin'))
        );
      }

    }on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message.toString()}')),
      );
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error : invalid credentials for admin'))
      );
    }
    finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  // Colors.deepOrangeAccent.shade200.withOpacity(0.1)
                  Colors.lightBlue.shade200.withOpacity(0.5)
                ],
            ),
        ),
        child:Stack(
          children: [
            const SizedBox(
              height: 500,
              width: 550,
            ),
            Positioned(
              top: 100,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                height:400,
                width: 550,
               decoration: BoxDecoration(
                 color: const Color.fromRGBO(217, 217, 217, 0.2),
                 borderRadius: BorderRadius.circular(30)
               ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 150,),
                      MyTextfield(
                          hint: 'email',
                          obsecure: false,
                          noTapIcon: const Icon(Icons.supervised_user_circle),
                          keyboardType: TextInputType.text,
                          controller: emailController,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'email required';
                            }else if(!value.contains('@')){
                              return 'enter valid email';
                            }
                            else{
                              return null;
                            }
                          },
                      ),
                      const SizedBox(height: 20,),
                      MyTextfield(
                          hint: 'password',
                          obsecure: isPassSecure,
                          keyboardType: TextInputType.text,
                          icon: IconButton(
                              onPressed: togglePass,
                              icon: icon,
                          ),
                          controller: passwordController,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'email required';
                            }else if(value.length < 8){
                              return 'minimum 8 character required';
                            }
                            else{
                              return null;
                            }
                          },
                      ),
                      const SizedBox(height: 30,),
                     isLoading ? const CircularProgressIndicator()
                         :  MyButton(
                       text: 'Login',
                       onTap: (){
                         if(_formKey.currentState!.validate()){
                           login();
                         }
                       },
                     )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 175,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset('assets/student.jpg',height: 200,width: 200,fit: BoxFit.cover,),
              )
            ),
          ],
        ),
      ),
    );
  }
}
