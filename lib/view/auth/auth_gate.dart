import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksv_student_management/view/auth/login_page.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../components/colors.dart';
import '../home/home.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final SupabaseClient client = Supabase.instance.client;
  User? _user;
  late StreamSubscription _authStateChangeSubscription;

  void _initializeAuthListener() {
    _user = client.auth.currentUser;

    _authStateChangeSubscription = client.auth.onAuthStateChange.listen((event) {
      setState(() {
        _user = event.session?.user;
      });
    });
  }

  // Navigate based on user's role or authentication status
  Future<void> _navigateUser() async {
    if (_user == null) {
      await Get.offAll(() => const LoginPage());
      return;
    }
    try {
      final userData = await client
          .from('admins')
          .select('email')
          .eq('email', _user!.email.toString())
          .single();

      if (userData == null) {
        throw Exception("User data not found");
      }

      final email = userData['email'];
      if (email == _user!.email.toString()) {
        await Get.offAll(() => const Home());
      } else {
        _showSnackBar('Unauthorized access');
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}');
    }
  }
  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void dispose() {
    _authStateChangeSubscription.cancel(); // Cancel the listener
    super.dispose();
  }

  // Future<void> _getPage() async{
  //   Timer(
  //     const Duration(seconds: 2),
  //       ()async{
  //         if(_user != null){
  //           try{
  //             final userData = await client
  //                 .from('users')
  //                 .select('id')
  //                 .eq('email', _user!.email.toString())
  //                 .single();
  //             print('User data: $userData');
  //             final userId = userData['id'];
  //
  //
  //             if(userData != null) {
  //
  //               final roleData = await client
  //                   .from('users')
  //                   .select('role')
  //                   .eq('id', userId)
  //                   .single();
  //
  //               final role = roleData['role'];
  //
  //               print('Role: $role');
  //               if (!mounted) return;
  //               if (role == 'ADMIN') {
  //                 await Get.offAll(() => const Home());
  //               }else {
  //                 print('Role : ${role}');
  //                 if (!mounted) return;
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(content: Text('Unauthorized access')),
  //                 );
  //               }
  //             }
  //           }catch (e) {
  //             if (!mounted) return;
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Error: ${e.toString()}')),
  //             );
  //           }
  //         }else{
  //           if (!mounted) return;
  //           await Get.offAll(()=>const LoginPage());
  //         }
  //       }
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _initializeAuthListener();
    // _getAuth();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _getPage();
      _navigateUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tertiary,
      body: Center(
        child: Lottie.asset('assets/loader.json'),
      ),
    );
  }
}
