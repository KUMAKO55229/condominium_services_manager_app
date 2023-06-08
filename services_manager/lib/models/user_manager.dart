import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:services_manager/helpers/firebase_erros.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:services_manager/models/user.dart' as UserModel;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserModel.User? user;

  bool _loading = false;
  //User user;

  bool get loading => _loading;

  Future<void> signIn(
      {required UserModel.User user,
      required Function onFail,
      required Function onSucces}) async {
    loading = true;
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
              email: user.email, password: user.password);
      // this.user = userCredential.user;
      // this.user = userCredential.user! ;
      await _loadCurrentUser(firebaseUser: userCredential.user);
      onSucces();
      //  await Future.delayed(const Duration(seconds: 4));
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp(
      {required UserModel.User user,
      required Function onFail,
      required Function onSucces}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      // this.user!.id = result.user!.uid;
      user.id = result.user!.uid;
      await user.saveData();
      onSucces();
    } on PlatformException catch (e) {
      onFail(getErrorString((e.code)));
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User? currentUser = firebaseUser ?? (await auth.currentUser);
    //final User currentUser = firebaseUser ?? await auth.currentUser!;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      // user = UserModel.User.fromDocument(docUser);
      user = UserModel.User.fromDocument(docUser);
      final docAdmin = await firestore.collection('admins').doc(user!.id).get();
      if (docAdmin.exists) {
        user!.admin = true;
      }

      // DocumentSnapshot snapshot =
      //     await firestore.collection('users').doc(user!.id).get();

      // // Verificar se o documento existe
      // if (snapshot.exists) {
      //   // Acessar o campo do array no documento
      //   List<String> tasksIds = snapshot.get(['Tasks']);
      //   List<DocumentSnapshot> tasks = await buscarTarefasPorIDs(tasksIds);

      //   for (DocumentSnapshot tarefa in tasks) {
      //     print(tarefa.data());
      //   }
      // }

      print('user name ${user!.name}');
      // Exibir as tarefas encontradas
    }
    notifyListeners();
  }

// Função para buscar tarefas com base em uma lista de IDs
  Future<List<DocumentSnapshot>> buscarTarefasPorIDs(List<String> ids) async {
    // Referência para a coleção de tarefas
    CollectionReference tarefasCollection = firestore.collection('tarefas');

    // Lista para armazenar as tarefas encontradas
    List<DocumentSnapshot> tarefasEncontradas = [];

    // Percorrer o array de IDs
    for (String id in ids) {
      // Realizar a consulta para cada ID
      DocumentSnapshot snapshot = await tarefasCollection.doc(id).get();

      // Verificar se o documento existe
      if (snapshot.exists) {
        // Adicionar a tarefa encontrada à lista
        tarefasEncontradas.add(snapshot);
        // print("task ${snapshot.}");
      }
    }
    return tarefasEncontradas;
  }

  bool get isLoggedIn => user != null;
  bool get adminEnabled => user != null && user!.admin;
}
