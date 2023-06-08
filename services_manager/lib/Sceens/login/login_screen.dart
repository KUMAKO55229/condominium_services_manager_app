import 'dart:developer';

import 'package:services_manager/helpers/validators.dart';
import 'package:services_manager/models/user.dart';
import 'package:services_manager/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Entrar'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/signup');
              } /*, style:TextButton.styleFrom(
            backgroundColor: Colors.white,

          )*/

              ,
              child: const Text(
                "CRIAR CONTA",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, child) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email!)) return 'E-mail invalido';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: passController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        obscureText: true,
                        autocorrect: false,
                        validator: (pass) {
                          if (pass!.isEmpty || pass.length < 6) {
                            return 'Senha invalida';
                          }
                          return null;
                        },
                      ),
                      child!,
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 44,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: userManager.loading
                                ? MaterialStateProperty.all(
                                    primaryColor.withAlpha(100))
                                : MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    userManager.signIn(
                                        user: User(
                                            email: emailController.text
                                                .toString()
                                                .trim(),
                                            password: passController.text
                                                .toString()
                                                .trim()),
                                        onFail: (e) {
                                          final snackBar = SnackBar(
                                            content:
                                                Text('Falha ao entrar: $e'),
                                            // duration: const Duration(seconds: 2),
                                            backgroundColor: Colors.red,
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                        onSucces: () {
                                          //TODO: FECHAR A TELA DE LOGIN
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/qrcodescreen');
                                          // print("esta OK");
                                        });
                                  }
                                },
                          child: userManager.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      )
                    ],
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      padding:
                          MaterialStateProperty.all((const EdgeInsets.all(0))),
                    ),
                    onPressed: () {},
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
