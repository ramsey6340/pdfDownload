import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf_download/app/controllers/global_controller.dart';
import 'package:pdf_download/app/models/pdf.dart';
import 'package:pdf_download/app/style/constantes.dart';
import '../controllers/upload_controller.dart';
import 'package:text_divider/text_divider.dart';

class SelectPdfView extends StatelessWidget {
  SelectPdfView({Key? key}) : super(key: key);
  final controller = Get.put(UploadController());
  final globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    globalController.firebaseAuth
        .userChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        globalController.setCurrentUser(user);
      }
    });
    controller.chooseAdmin();

    return Obx(() => Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un document'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () async {
                controller.updateUploaded(UploadStatus.uploading);
                DateTime now = DateTime.now();
                final doc = await controller.db.collection(CollectionNames.documents.name)
                    .doc(controller.fileName.value).get();
                if(doc.exists) {
                  controller.updateUploaded(UploadStatus.finished);
                  if(context.mounted) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: false,
                      title: 'Erreur',
                      desc:
                      'Un document avec le même nom existe déjà',
                      btnOkOnPress: () {},
                      btnOkIcon: Icons.cancel,
                      btnOkColor: Colors.red,
                    ).show();
                  }
                }
                else if(
                controller.fileName.value != "" &&
                    controller.fileSize.value != "" &&
                    kAllowedFileExtensions.contains(controller.fileExtension.value) &&
                    controller.publicationYearController.value.text.length == 4 &&
                    int.parse(controller.publicationYearController.value.text)<=now.year &&
                    controller.authorNameController.value.text.isNotEmpty &&
                    controller.authorNameController.value.text.length>3 &&
                    globalController.currentUSer.value?.uid != null
                ){
                  print(globalController.userRole.value);
                  // Preparation d'une nouvelle instance pour être enregistrer dans la base de donnée
                  PDF newPdf = PDF(
                    id: null,
                    supplierId: globalController.currentUSer.value!.uid,
                    validatorEmail: controller.adminEmail.value,
                    title: controller.fileName.value,
                    size: controller.fileSize.value,
                    extension: controller.fileExtension.value,
                    status:(globalController.userRole.value == Role.admin.name)
                        ? DocStatus.ok.name:DocStatus.traitement.name,
                    author: controller.authorNameController.value.text,
                    fileUrl: '',
                    publicationYear: int.parse(controller.publicationYearController.value.text),
                    comment: controller.commentController.value.text,
                    docTypes: controller.selectedTypes.toList(),
                    academicLevels: controller.selectedAcademicLevel.toList(),
                  );
                  controller.showProgressDialog();

                  final ref = controller.dbStorage.ref('${CollectionNames.documents.name}/${controller.fileName.value}');
                  final uploadTask = ref.putData(controller.fileBytes.value);

                  uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
                    // Vous pouvez accéder aux informations sur la progression ici
                    double progress = snapshot.bytesTransferred / snapshot.totalBytes;
                    controller.uploadProgress.value = progress;
                    print('Upload progress: ${progress * 100}%');
                  }, onError: (Object e) {
                    // Gérez les erreurs ici
                    print('Error during upload: $e');
                  });

                  // Attendre la fin de l'upload
                  final TaskSnapshot completedTask = await uploadTask;
                  final downloadURL = await completedTask.ref.getDownloadURL();

                  /*// Ajout du fichier dans Firestorage
                  await controller.dbStorage.ref('${CollectionNames.documents.name}/${controller.fileName.value}')
                      .putData(controller.fileBytes.value);

                  // Récupérer le lien vers le fichier uploader
                  String downloadURL = await controller.dbStorage
                      .ref('${CollectionNames.documents.name}/${controller.fileName.value}')
                      .getDownloadURL();
                  newPdf.setFileUrl = downloadURL;*/

                  // Ajout du pdf dans firestore
                  final docRef = controller.db
                      .collection(CollectionNames.documents.name)
                      .withConverter(
                    fromFirestore: PDF.fromFirestore,
                    toFirestore: (PDF pdf, options) => pdf.toFirestore(),
                  ).doc(controller.fileName.value);
                  newPdf.setId=docRef.id;

                  await docRef.set(newPdf);

                  // Popup de confirmation
                  if(context.mounted){
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.leftSlide,
                      headerAnimationLoop: false,
                      dialogType: DialogType.success,
                      showCloseIcon: true,
                      title: 'Succes',
                      desc:
                      'Votre document a bien etait enregistrer.\nMerci pour votre contribution',
                      btnOkOnPress: () {

                      },
                      btnOkIcon: Icons.check_circle,
                      onDismissCallback: (type) {
                        debugPrint('Dialog Dissmiss from callback $type');
                      },
                    ).show();
                  }
                  controller.updateUploaded(UploadStatus.finished);
                }
                else{
                  controller.updateUploaded(UploadStatus.finished);
                  if(context.mounted) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: false,
                      title: 'Erreur',
                      desc:
                      'Veuillez fournir correctement tous les informations obligatoire',
                      btnOkOnPress: () {},
                      btnOkIcon: Icons.cancel,
                      btnOkColor: Colors.red,
                    ).show();
                  }
                }
              },
              child: (controller.uploaded.value == UploadStatus.finished)?
              const Text("Suivant"):
              const SizedBox(width: 15, height: 15,child: CircularProgressIndicator(),))
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Text(
            "Selectionner un document",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                children: [
                  Image.asset("assets/images/pdf.png"),
                  (controller.fileName.value != "")?Text(controller.fileName.value,
                    style: const TextStyle(fontWeight: FontWeight.bold),):const SizedBox.shrink(),
                  (controller.fileSize.value != "")?Text(controller.fileSize.value):const SizedBox.shrink(),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: kAllowedFileExtensions,
                        );

                        if (result != null && result.files.isNotEmpty) {
                          controller.updateFileBytes(result.files.first.bytes!);
                          controller.updateFileName(result.files.first.name);
                          controller.updateFileExtension(result.files.first.extension);
                          controller.updateFileSize(result.files.first.size);

                        } else {
                          Get.snackbar(
                            "Erreur",
                            "Une erreur est intervenue lors du chargement du document",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: const Text("Choisir un document")),
                  const SizedBox(height: 40,),
                  TextDivider.horizontal(text: const Text('Quelques informations')),
                  const SizedBox(height: 20,),

                  TextField(
                      controller: controller.publicationYearController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      cursorColor: kPrimaryColor,
                      maxLength: 4,
                      decoration: const InputDecoration(
                        labelText: "Année de publication *",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        hintText: "Ex: 2022",
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
                  const SizedBox(height: 10,),
                  TextField(
                      controller: controller.authorNameController,
                      cursorColor: kPrimaryColor,
                      maxLength: 20,
                      decoration: const InputDecoration(
                        labelText: "Nom de l'auteur *",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        hintText: "Ex: Pierre Giraud",
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
                  const SizedBox(height: 10,),
                  TextField(
                      controller: controller.commentController,
                      cursorColor: kPrimaryColor,
                      maxLength: 50,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
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
                ]
            ),
          ),
        ),
      ),
    ));
  }
}

