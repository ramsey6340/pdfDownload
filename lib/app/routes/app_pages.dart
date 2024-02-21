import 'package:get/get.dart';

import '../modules/download/bindings/download_binding.dart';
import '../modules/download/views/download_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/views/sign_view.dart';
import '../modules/manageDoc/bindings/manage_doc_binding.dart';
import '../modules/manageDoc/views/manage_doc_view.dart';
import '../modules/safeguard/bindings/safeguard_binding.dart';
import '../modules/safeguard/views/safeguard_view.dart';
import '../modules/shared/bindings/shared_binding.dart';
import '../modules/shared/views/shared_view.dart';
import '../modules/upload/bindings/upload_binding.dart';
import '../modules/upload/views/select_academic_level.dart';
import '../modules/upload/views/select_pdf_view.dart';
import '../modules/upload/views/upload_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DOWNLOAD,
      page: () => DownloadView(),
      binding: DownloadBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD,
      page: () => UploadView(),
      binding: UploadBinding(),
    ),
    GetPage(
      name: _Paths.SAFEGUARD,
      page: () => const SafeguardView(),
      binding: SafeguardBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(name: '/selectPdf', page: () => SelectPdfView()),
    GetPage(name: '/selectAcademicLevel', page: () => SelectAcademicLevel()),
    GetPage(name: '/signView', page: () => SignView()),
    GetPage(
      name: _Paths.MANAGE_DOC,
      page: () => ManageDocView(),
      binding: ManageDocBinding(),
    ),
    GetPage(
      name: _Paths.SHARED,
      page: () => SharedView(),
      binding: SharedBinding(),
    ),
  ];
}
