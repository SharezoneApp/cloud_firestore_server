import 'package:meta/meta.dart';

import 'document_reference.dart';
import 'internal/instance_resources.dart';
import 'internal/pointer.dart';
import 'query.dart';

class CollectionReference extends Query {
  CollectionReference(
    InstanceResources instanceResources, {
    required String path,
  }) : super(
          instanceResources,
          path: path,
        );

  DocumentReference doc(String documentPath) {
    final _documentPath = Pointer(path).documentPath(documentPath);
    return DocumentReference(instanceResources, path: _documentPath);
  }
}
