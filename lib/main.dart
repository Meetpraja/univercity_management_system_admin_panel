import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ksv_student_management/view/auth/auth_gate.dart';
import 'package:ksv_student_management/view/home/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:window_size/window_size.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  setWindowMinSize(const Size(1200, 800));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
