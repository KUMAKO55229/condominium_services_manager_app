import 'package:services_manager/Sceens/login/login_screen.dart';
import 'package:services_manager/Sceens/signup/signup_screen.dart';
import 'package:services_manager/common/custum_drawer/custom_drawer.dart';
import 'package:services_manager/models/page_manager.dart';
import 'package:services_manager/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final Color primaryColor = Theme.of(context).primaryColor;
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const LoginScreen(),
        Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Home2'),
          ),
        ),
        Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Home3'),
          ),
        ),
        Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Home4'),
          ),
        ),
        /*    Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.green,
          )*/
      ],
    );
  }
}
