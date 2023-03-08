import 'package:cloud_firestore_server/src/internal/firestore_run_query_fixed_extension.dart';
import 'package:cloud_firestore_server/src/internal/firestore_value_conversion.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:googleapis/firestore/v1.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

Future<List<Document>> runQuery({
  required String fieldPath,
  required String operation,
  required dynamic value,
  required String collectionId,
  required String? parentPath,
  required ProjectsDatabasesDocumentsResourceApi api,
  required http.Client client,
  int? limit,
}) async {
  final chatFieldReference = FieldReference()..fieldPath = fieldPath;
  final fstoreValue = '$value'.toFirestoreValue();
  final fieldFilter = FieldFilter()
    ..field = chatFieldReference
    ..op = operation
    ..value = fstoreValue;
  final filter = Filter()..fieldFilter = fieldFilter;
  final structuredQuery = StructuredQuery()
    ..where = filter
    ..from = [CollectionSelector()..collectionId = collectionId];
  if (limit != null) {
    structuredQuery.limit = limit;
  }
  final runQueryRequest = RunQueryRequest()..structuredQuery = structuredQuery;

  final documents = await api.runQueryFixed(runQueryRequest,
      client: client, parent: parentPath,);
  return documents;
}

Future<List<Document>> runMultiConditionQuery({
  required List<Condition> conditions,
  required String collectionId,
  required String? parentPath,
  required ProjectsDatabasesDocumentsResourceApi api,
  required http.Client client,
}) async {
  final filters = conditions.map((condition) {
    final chatFieldReference = FieldReference()
      ..fieldPath = condition.fieldPath;
    final fstoreValue = '${condition.value}'.toFirestoreValue();
    final fieldFilter = FieldFilter()
      ..field = chatFieldReference
      ..op = condition.operation
      ..value = fstoreValue;
    return Filter()..fieldFilter = fieldFilter;
  }).toList();

  final compositeFilter = CompositeFilter()
    ..filters = filters
    ..op = 'AND';
  final filter = Filter()..compositeFilter = compositeFilter;
  final structuredQuery = StructuredQuery()
    ..where = filter
    ..from = [CollectionSelector()..collectionId = collectionId];
  final runQueryRequest = RunQueryRequest()..structuredQuery = structuredQuery;

  final documents = await api.runQueryFixed(runQueryRequest,
      client: client, parent: parentPath,);
  return documents;
}

class Condition {
  final String fieldPath;
  final String operation;
  final dynamic value;

  Condition({
    required this.fieldPath,
    required this.operation,
    required this.value,
  });
}
