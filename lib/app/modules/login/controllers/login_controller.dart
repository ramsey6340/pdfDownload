import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pdf_download/app/controllers/global_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../style/constantes.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final globalController = Get.put(GlobalController());

  final firebaseAuth = FirebaseAuth.instance;
  final showPassword = true.obs;
  final processingLogin = false.obs;
  final loginPageType = LoginPageType.signIn.obs;
  final errorText = ''.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setLoginPageType(LoginPageType type) {
    loginPageType(type);
  }

  void toggleShowPassword() {
    showPassword(!showPassword.value);
  }

  Future<void> setRole(String emailAddress) async {
    final docRef = await FirebaseFirestore.instance
        .collection(CollectionNames.admins.name)
        .doc("emails");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        dynamic emails = data['emails'] ?? [];
        if (emails.contains(emailAddress)) {
          globalController.setRole(Role.admin.name);
        } else {
          globalController.setRole(Role.user.name);
        }

        print(globalController.userRole.value);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<void> signIn(String emailAddress, String password) async {
    processingLogin(true);

    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      if (credential.user != null) {
        //FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.LOCAL);
        processingLogin(false);
        globalController.setCurrentUser(credential.user);
        await setRole(emailAddress);
        print(globalController.userRole.value);
        Get.offAllNamed(Routes.HOME);
      } else {
        processingLogin(false);
        setErrorText('Email ou mot de passe incorrect');
      }
    } on FirebaseAuthException catch (e) {
      processingLogin(false);
      setErrorText('Email ou mot de passe incorrect');

      /*if (e.code == 'user-not-found') {
        processingLogin(false);
        print('No user found for that email.');
        errorText('Email ou mot de passe incorrect');
      } else if (e.code == 'wrong-password') {
        processingLogin(false);
        errorText('Email ou mot de passe incorrect');
      }*/
    }
  }

  void setErrorText(String text) {
    errorText(text);
  }

  Future<void> signUp(String emailAddress, String password) async {
    processingLogin(true);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (credential.user != null) {
        //FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.LOCAL);
        processingLogin(false);
        globalController.setCurrentUser(credential.user);
        setRole(emailAddress);
        Get.offAllNamed(Routes.HOME);
      } else {
        processingLogin(false);
        errorText('Une erreur est survenue');
        debugPrint("Une inconnue");
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      print(e.code);
      debugPrint(e.message);
      processingLogin(false);
      setErrorText('Une erreur est survenue');
      /*if (e.code == 'weak-password') {
        processingLogin(false);
        print('The password provided is too weak.');
        errorText('Le mot de passe est trop faible');
      } else if (e.code == 'email-already-in-use') {
        processingLogin(false);
        print('The account already exists for that email.');
        errorText('Cet email existe déjà');
      }*/
    } catch (e) {
      processingLogin(false);
      print(e);
      debugPrint(e.toString());
      errorText('Une erreur est survenue');
    }
  }
}
