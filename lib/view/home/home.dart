import 'dart:convert';

import 'package:animated_sidebar/animated_sidebar.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksv_student_management/components/colors.dart';
import 'package:ksv_student_management/components/form_TextField.dart';
import 'package:ksv_student_management/view/auth/login_page.dart';
import 'package:ksv_student_management/view/department/department.dart';
import 'package:ksv_student_management/view/dashboard/dashboard.dart';
import 'package:ksv_student_management/view/newUser/new_user.dart';
import 'package:ksv_student_management/view/new_admin/new_admin.dart';
import 'package:ksv_student_management/view/teacher/teacher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import '../student/student.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _formKey = GlobalKey<FormState>();


  SupabaseClient client = Supabase.instance.client;
  var passController = TextEditingController();
  bool isLoading = false;

  int activeTab = 0;
  Widget activepage = const Dashboard();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: const EdgeInsets.only(top: 20),
            height: 150,
            width: 350,
            child: Column(
              children: [
                Text(
                  'are you leaving ?',
                  style: GoogleFonts.openSans(
                      color: secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'are you sure you want to logout ? ',
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
                          onTap: () async {
                            await client.auth.signOut();
                            await Supabase.instance.client.dispose();
                            Get.offAll(() => const LoginPage());
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(20)),
                              color: Colors.redAccent.withOpacity(0.8),
                            ),
                            child: Text('logout',
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
      },
    );
  }

  Future<void> _showMyDialogForPass() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(500),
          child: AlertDialog(
            alignment: Alignment.center,
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: const EdgeInsets.only(top: 20),
              height: 180,
              width: 350,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'enter password for admins',
                      style: GoogleFonts.robotoMono(
                          color: secondary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FormTextfield(
                          hint: 'password',
                          obsecure: true,
                          keyboardType: TextInputType.text,
                          controller: passController,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'password required';
                            }
                          },
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  activeTab = 0;
                                  activepage = Dashboard();
                                });
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
                              onTap: () async {
                                    _giveAccess().then((value){
                                      Get.back();
                                    });
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20)),
                                  color: Colors.redAccent.withOpacity(0.8),
                                ),
                                child: isLoading
                                    ? const Center(child: CircularProgressIndicator(),)
                                    : Text('Go',
                                    style: GoogleFonts.robotoMono(
                                        color: secondary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600))
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> checkPassword(String enteredPassword, String storedHash) async {
    String hashedEnteredPassword = hashPassword(enteredPassword);
    return hashedEnteredPassword == storedHash; // Compare hashes
  }

  Future<void> _giveAccess() async{
    print('giving access');
    setState(() {
      isLoading = true;
      print('loading....');
    });
    final password = passController.text;

    try{
      if(client.auth.currentUser != null) {
        final email = client.auth.currentUser!.email;

        final userData = await client
            .from('admins')
            .select('pass_hash')
            .eq('email', email.toString())
            .single();

        if (userData != null) {
          String storedHash = userData['pass_hash'];

          bool isPasswordCorrect = await checkPassword(password, storedHash);

          if (isPasswordCorrect) {
            passController.clear();
            setState(() {
              activepage = const NewAdmin();
            });
          } else {
            print('not matched');
            _showSnakbar('Incorrect password');
            _showMyDialogForPass();
            passController.clear();
          }
        } else {
          _showSnakbar('User not found');
          passController.clear();
        }
      }else{
        _showSnakbar('User not found');
        passController.clear();
      }
    }catch (e){
      _showSnakbar('Error : invalid admin');
      passController.clear();
    }
    finally{
      setState(() {
        print('loading stop...');
        isLoading = false;
      });
    }
  }

  void _showSnakbar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  void switchScreen() {
    switch (activeTab) {
      case 0:
        activepage = const Dashboard();
        return;
      case 1:
        activepage = const Student();
        return;
      case 2:
        activepage = const Teacher();
        return;
      case 3:
        activepage = const Courses();
        return;
      case 4:
        activepage = const NewUser();
        return;
      case 5:
         _showMyDialogForPass();
        return;
      case 6:
        _showMyDialog();
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.lightBlue.withOpacity(0.7),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          AnimatedSidebar(
            selectedIndex: activeTab,
            items: [
              SidebarItem(
                text: 'dashboard',
                icon: Icons.dashboard,
              ),
              SidebarItem(
                text: 'students',
                icon: Icons.person,
              ),
              SidebarItem(
                text: 'teacher',
                icon: Icons.person,
              ),
              SidebarItem(
                text: 'courses',
                icon: Icons.book,
              ),
              SidebarItem(
                text: 'add user',
                icon: Icons.add_circle,
              ),
              SidebarItem(
                text: 'admins',
                icon: Icons.admin_panel_settings,
              ),
              SidebarItem(
                text: 'Logout',
                icon: Icons.logout,
              ),
            ],
            onItemSelected: (index) => setState(() {
              activeTab = index;
              switchScreen();
            }),
            frameDecoration: BoxDecoration(color: tertiary
                // color: Colors.lightBlue.withOpacity(0.7),
                // borderRadius: BorderRadius.circular(10)
                ),
            autoSelectedIndex: false,
            // expanded: false,
            duration: const Duration(milliseconds: 900),
            minSize: 90,
            maxSize: 250,
            itemIconSize: 24,
            itemIconColor: secondary,
            itemHoverColor: Colors.black.withOpacity(0.15),
            itemSelectedColor: Colors.black.withOpacity(0.15),
            itemTextStyle:
                GoogleFonts.robotoMono(fontSize: 20, color: secondary),
            itemMargin: 16,
            itemSpaceBetween: 8,
            headerIcon: Icons.school,
            headerIconSize: 40,
            headerIconColor: secondary,
            headerTextStyle: GoogleFonts.openSans(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: secondary,
                letterSpacing: 2),
            headerText: '  ADMIN',
          ),
          Expanded(
            child: Container(
              height: size.height,
              margin: const EdgeInsets.only(top: 15, right: 15, bottom: 15),
              decoration: BoxDecoration(color: tertiary
                  // color: Colors.lightBlue.withOpacity(0.7),
                  // borderRadius: BorderRadius.circular(10)
                  ),
              child: SingleChildScrollView(child: activepage),
            ),
          ),
        ],
      ),
    );
  }
}
