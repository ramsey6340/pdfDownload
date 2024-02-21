import 'package:cloud_firestore/cloud_firestore.dart';

class PDF {
  String? id;
  String supplierId;
  String validatorEmail;
  String title;
  String size;
  String extension;
  String status;
  String author;
  String fileUrl;
  int publicationYear;
  String comment;
  List<String> docTypes;
  List<String> academicLevels;

  PDF({
    required this.id,
    required this.supplierId,
    required this.validatorEmail,
    required this.title,
    required this.size,
    required this.extension,
    required this.status,
    required this.author,
    required this.fileUrl,
    required this.publicationYear,
    required this.comment,
    required this.docTypes,
    required this.academicLevels,
  });

  set setId(String id) {
    this.id = id;
  }

  set setFileUrl(String fileUrl) {
    this.fileUrl = fileUrl;
  }

  factory PDF.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return PDF(
      id: data?['id'],
      supplierId: data?['supplierId'],
      validatorEmail: data?['validatorEmail'],
      title: data?['title'],
      size: data?['size'],
      extension: data?['extension'],
      status: data?['status'],
      author: data?['author'],
      fileUrl: data?['fileUrl'],
      publicationYear: data?['publicationYear'],
      comment: data?['comment'],
      docTypes: data?['docTypes'] is Iterable ? List.from(data?['docTypes']) : [],
      academicLevels: data?['academicLevels'] is Iterable ? List.from(data?['academicLevels']) : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "supplierId": supplierId,
      "validatorEmail": validatorEmail,
      "title": title,
      "size": size,
      "extension": extension,
      "status": status,
      "author": author,
      "fileUrl": fileUrl,
      "publicationYear": publicationYear,
      "comment": comment,
      "docTypes": docTypes,
      "academicLevels": academicLevels,
    };
  }
}
