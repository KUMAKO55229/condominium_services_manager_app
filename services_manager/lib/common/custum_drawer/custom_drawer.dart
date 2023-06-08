import 'package:flutter/material.dart';
import 'package:services_manager/common/custum_drawer/custom_drawer.dart';
import 'package:services_manager/common/custum_drawer/custom_drawer_header.dart';
import 'package:services_manager/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:services_manager/common/custum_drawer/drawer_tile.dart';
import 'package:services_manager/models/user_manager.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(),
              const DrawerTile(
                iconData: Icons.home,
                title: 'Início',
                page: 0,
              ),
              // const DrawerTile(
              //   iconData: Icons.list,
              //   title: 'Produtos',
              //   page: 1,
              // ),
              const DrawerTile(
                iconData: Icons.playlist_add_check,
                title: 'Minhas tarefas',
                page: 1,
              ),
              const DrawerTile(
                iconData: Icons.location_on,
                title: 'Condominios',
                page: 2,
              ),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnabled) {
                    return const Column(
                      children: <Widget>[
                        Divider(),
                        DrawerTile(
                          iconData: Icons.list,
                          title: 'Usuários',
                          page: 3,
                        ),
                        // DrawerTile(
                        //   iconData: Icons.list,
                        //   title: 'Cadastrar tarefas',
                        //   page: 4,
                        // ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
