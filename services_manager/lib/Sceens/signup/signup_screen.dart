import 'dart:math';

import 'package:services_manager/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/validators.dart';
import '../../models/user.dart' as UserModel;

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel.User user = UserModel.User();
    final Color primaryColor = Theme.of(context).primaryColor;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Criar conta"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Nome Completo'),
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'Campo obrigatorio';
                      } else if (name.trim().split(' ').length <= 1) {
                        return 'Preencha seu nome completo';
                      }
                      return null;
                    },
                    onSaved: (name) => user.name = name!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Campo obrigatorio';
                      } else if (!emailValid(email)) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                    onSaved: (email) => user.email = email!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    validator: (pass) {
                      if (pass!.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (pass.length < 6) {
                        return 'Senha muito curta';
                      }
                      return null;
                    },
                    onSaved: (pass) => user.password = pass!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Repita a senha'),
                    obscureText: true,
                    validator: (pass) {
                      if (pass!.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (pass.length < 6) {
                        return 'Senha muito curta';
                      }
                      return null;
                    },
                    onSaved: (pass) => user.confirmPassword = pass!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          if (user.password != user.confirmPassword) {
                            const snackBar = SnackBar(
                              content: Text('Senhas não coincidem'),
                              backgroundColor: Colors.red,
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          final userManager =
                              Provider.of<UserManager>(context, listen: false);
                          userManager.signUp(
                            user: user,
                            onSucces: () {
                              debugPrint('sucesso');
                              //TODO: POP
                            },
                            onFail: (e) {
                              final snackBar = SnackBar(
                                content: Text('Falha ao cadastrar: $e'),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Criar conta',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
