import 'package:flutter/material.dart';
import '../../../data/datatest.dart';
import '../../../widgets/list_tile_pdf.dart';

class Downloaded extends StatelessWidget {
  const Downloaded({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.builder(
            itemCount: pdfs.length,
            itemBuilder: (context, index) {
              return ListTilePDF(
                pdf: pdfs[index],
                downloaded: true,
              );
            }));
  }
}
