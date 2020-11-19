import 'package:googleapis/firestore/v1.dart';

extension DocumentId on Document {
  String get id => name.split('/').last;
}
