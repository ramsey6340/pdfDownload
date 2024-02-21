import '../models/docType.dart';
import '../models/pdf.dart';
import '../style/constantes.dart';

List<PDF> pdfs = [
  /*PDF(id: '1', title: 'Les 33 lois de la guerre', size: '10', docTypes: [docTypes[0].name, docTypes[1].name], status: DocStatus.traitement.name, author: 'Nelson Mandela', publicationYear: 2000, comment: '', academicLevels: [], supplierId: '', fileUrl: '', extension: 'pdf', validatorEmail: ''),
  PDF(id: '2', title: 'Power', size: '10', docTypes: [docTypes[0].name, docTypes[2].name], status: DocStatus.ok.name, author: 'Pierre Giraud', publicationYear: 1999, comment: '', academicLevels: [], supplierId: '', fileUrl: '', extension: 'pdf', validatorEmail: ''),
  PDF(id: '3', title: 'Le théorème de la relativité', size: '10', docTypes: [docTypes[3].name, docTypes[1].name], status: DocStatus.ok.name, author: 'Paul Kaba', publicationYear: 1985, comment: '', academicLevels: [], supplierId: '', fileUrl: '', extension: 'docx', validatorEmail: ''),
  PDF(id: '4', title: 'La loi de la grapvité', size: '10', docTypes: [docTypes[4].name, docTypes[5].name], status: DocStatus.refuse.name, author: 'Abdoulaye Goita', publicationYear: 2001, comment: '', academicLevels: [], supplierId: '', fileUrl: '', extension: 'ppt', validatorEmail: ''),
  PDF(id: '5', title: 'La mathématique en 5 étapes', size: '10', docTypes: [docTypes[3].name, docTypes[1].name], status: DocStatus.ok.name, author: 'Drissa Sidiki Traore', publicationYear: 1900, comment: '', academicLevels: [], supplierId: '', fileUrl: '', extension: 'docx', validatorEmail: ''),
  PDF(id: '6', title: 'Le langage de programmation C', size: '50', docTypes: [docTypes[2].name, docTypes[5].name], status: DocStatus.traitement.name, author: 'Kamara Laye', publicationYear: 2020, comment: '', academicLevels: [], supplierId: '', fileUrl: '', extension: 'pdf', validatorEmail: ''),
  PDF(id: '7', title: 'Les 33 lois de la guerre', size: '10', docTypes: [docTypes[0].name, docTypes[1].name], status: DocStatus.ok.name, author: 'Balmar Slave', publicationYear: 2013, comment: '', academicLevels: [], supplierId: '', fileUrl: '', extension: 'pdf', validatorEmail: ''),
  PDF(id: '8', title: 'Power', size: '10', docTypes: [docTypes[0].name, docTypes[2].name], status: DocStatus.ok.name, author: 'Nicola Tasla', publicationYear: 1896, comment: '', academicLevels: [], supplierId: '', fileUrl: '', extension: 'pdf', validatorEmail: ''),
  */
];

List<DocType> docTypes = [
  DocType(id: '1', name: 'Mathématique', image: 'assets/images/mathematical36.png'),
  DocType(id: '2', name: 'Physique', image: 'assets/images/physical36.png'),
  DocType(id: '3', name: 'Chimie', image: 'assets/images/chimistry36.png'),
  DocType(id: '4', name: 'Informatique', image: 'assets/images/computer36.png'),
  DocType(id: '5', name: 'Biologie', image: 'assets/images/biology36.png'),
  DocType(id: '6', name: 'Developpement', image: 'assets/images/coding36.png'),
];