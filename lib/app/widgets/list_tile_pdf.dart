import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_download/app/models/pdf.dart';
import '../modules/download/controllers/download_controller.dart';
import '../style/constantes.dart';

class ListTilePDF extends StatelessWidget {
  ListTilePDF({
    super.key,
    required this.pdf,
    this.downloaded = false,
    this.processing = false,
  });
  final PDF pdf;
  final bool downloaded;
  final bool processing;

  final controller = Get.put(DownloadController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          leading: Image.asset((pdf.extension == 'pdf')
              ? "assets/images/pdf36.png"
              : (pdf.extension == 'docx')
                  ? "assets/images/docx36.png"
                  : (pdf.extension == 'ppt')
                      ? "assets/images/ppt36.png"
                      : "assets/images/xlsx36.png"),
          title: Text(
            pdf.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${pdf.size} Mo'),
          trailing: (downloaded)
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                )
              : (processing)
                  ? IconButton(
                      onPressed: () {},
                      icon: Chip(
                        label: Text(pdf.status),
                        backgroundColor: (pdf.status == 'traitement')
                            ? Colors.blue.withOpacity(0.5)
                            : (pdf.status == 'ok')
                                ? Colors.green
                                : Colors.red,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        if (kIsWeb) {
                          controller.webDownloadFile(pdf.fileUrl, pdf.title);
                        } else {
                          controller.download(pdf.fileUrl, pdf.title);
                        }
                      },
                      icon: const Icon(
                        Icons.download_outlined,
                        color: kPrimaryColor,
                      ),
                    ),
        ),
        const Divider(indent: kDividerIndent, endIndent: kDividerIndent),
      ],
    );
  }
}
