// ignore: import_of_legacy_library_into_null_safe
import 'package:googleapis/firestore/v1.dart';

extension DocumentId on Document {
  String get id => name.split('/').last;
}
