import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../style/constantes.dart';
import '../controllers/login_controller.dart';

class SignView extends StatelessWidget{
  SignView({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/images/logo64.png"),
                (controller.loginPageType.value == LoginPageType.signIn)
                    ?const Text("Connexion",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,)
                    :const Text("Inscription",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
                (controller.loginPageType.value == LoginPageType.signIn)
                    ?const Text("Veuillez fournir vos informations de connexion",
                  style: TextStyle(fontSize: 18, ),
                  textAlign: TextAlign.center,)
                    :const Text("Veuillez fournir vos informations d'inscription",
                  style: TextStyle(fontSize: 18, ),
                  textAlign: TextAlign.center,),
                const SizedBox(height: 80),
                // Les champs d'information
                TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      hintText: "Ex: idy@gmail.com",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )
                ),
                const SizedBox(height: 20),
                TextField(
                    controller: controller.passwordController,
                    obscureText: controller.showPassword.value,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: (){
                            controller.toggleShowPassword();
                          },
                          icon: (controller.showPassword.value)?const Icon(Icons.visibility_off)
                              :const Icon(Icons.visibility)),
                      labelText: "Mot de passe",
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if(controller.emailController.text.isNotEmpty && controller.passwordController.text.isNotEmpty){
                      (controller.loginPageType.value == LoginPageType.signIn)
                          ?await controller.signIn(controller.emailController.text, controller.passwordController.text)
                          :await controller.signUp(controller.emailController.text, controller.passwordController.text);
                      print('value: ${controller.errorText.value}');
                      if(controller.errorText.isNotEmpty) {
                        print("Exception: ${controller.errorText.value}");
                        if(context.mounted){
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: false,
                            dialogType: DialogType.error,
                            showCloseIcon: true,
                            title: 'Erreur',
                            desc: controller.errorText.value,
                            btnOkOnPress: () {controller.setErrorText('');},
                            btnOkIcon: Icons.cancel,
                            btnOkColor: Colors.red,
                            onDismissCallback: (type) {
                              controller.setErrorText('');
                              debugPrint('Dialog Dissmiss from callback $type');
                            },
                          ).show();
                        }
                      }
                    }
                    else{
                      if(context.mounted){
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.error,
                          showCloseIcon: true,
                          title: 'Erreur',
                          desc:
                          'Veuillez reverifier vos informations de connexion',
                          btnOkOnPress: () {
            
                          },
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                          onDismissCallback: (type) {
                            debugPrint('Dialog Dissmiss from callback $type');
                          },
                        ).show();
                      }
                    }
                  },
                  child: (controller.processingLogin.value)
                      ?const SizedBox(
                      width: 15, height: 15,
                      child: CircularProgressIndicator()):const Text("Valider",),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
