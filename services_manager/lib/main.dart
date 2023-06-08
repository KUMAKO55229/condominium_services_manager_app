import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:services_manager/Sceens/qrcode/qrcode_screen.dart';
import 'package:services_manager/Sceens/signup/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_manager/Sceens/tasks/task_list.dart';

import 'Sceens/base/base_screen.dart';
import 'models/page_manager.dart';
import 'models/user_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  //FirebaseFirestore.instance.collection('teste4').add({'teste':'teste4'});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<PageManager>(
              create: (_) => PageManager(pageController)),
          ChangeNotifierProvider<UserManager>(create: (_) => UserManager()),
        ],
        child: MaterialApp(
          title: 'Controle de Serviços',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: const Color.fromARGB(255, 4, 125, 141),
              scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: const AppBarTheme(elevation: 0)),
          initialRoute: '/base',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/signup':
                return MaterialPageRoute(builder: (_) => SignUpScreen());
              case '/qrcodescreen':
                return MaterialPageRoute(builder: (_) => QrCodeScreen());
              case '/listartarefas':
                return MaterialPageRoute(builder: (_) => TasksList());
              case '/base':
              default:
                return MaterialPageRoute(builder: (_) => BaseScreen());
            }
          },
        ));
  }
}
