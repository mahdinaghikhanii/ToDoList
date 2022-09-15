import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'model/task_model.dart';
import 'pages/home_page.dart';

const taskBoxName = 'TASKS';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TaskModel>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: primaryVariantColor));

  runApp(const MyApp());
}

const primaryColor = Color(0xff794cFF);
const primaryVariantColor = Color(0xff5C0AFF);
const Color secondaryTextColor = Color(0xffAFBED0);
const normalPriority = Color(0xffF09819);
const lowPriority = Color(0xff3BE1F1);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xff1D2830);
    const Color secondaryTextColor = Color(0xffAFBED0);

    return MaterialApp(
      title: 'ToDoList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(const TextTheme(
              titleLarge: TextStyle(fontWeight: FontWeight.bold))),
          inputDecorationTheme: const InputDecorationTheme(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(color: secondaryTextColor),
              focusedBorder: null,
              border: InputBorder.none,
              iconColor: secondaryTextColor),
          colorScheme: const ColorScheme.light(
              primary: Color(0xff794cFF),
              primaryVariant: primaryVariantColor,
              onPrimary: Colors.white,
              background: Color(0xffF3F5F8),
              onBackground: primaryTextColor,
              secondary: primaryColor,
              onSecondary: Colors.white,
              onSurface: primaryTextColor)),
      home: HomePage(),
    );
  }
}
