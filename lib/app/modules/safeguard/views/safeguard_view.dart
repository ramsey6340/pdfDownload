import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pdf_download/app/style/constantes.dart';
import '../controllers/safeguard_controller.dart';
import 'downloaded.dart';
import 'uploaded.dart';

class SafeguardView extends GetView<SafeguardController> {
  const SafeguardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sauvegarde'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Container(
              height: 40,
              child: TabBar(
                indicatorColor: kPrimaryColor,
                indicator: UnderlineTabIndicator(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: kPrimaryColor, // Couleur noire avec opacité
                    width: 2, // Largeur de la ligne de délimitation
                  ),
                ),
                labelStyle: Theme.of(context).textTheme.bodyLarge,
                tabs: const [
                  Tab(
                      icon: Text(
                        "Téléchargements",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Tab(
                      icon: Text("Uploades",
                          style:
                          TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle_outlined),
            )
          ],
        ),
        body: TabBarView(
          children: [
            Downloaded(),
            Uploaded(),
          ]
        ),
      ),
    );
  }
}

