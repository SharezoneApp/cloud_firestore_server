import 'package:meta/meta.dart';
import 'firestore_api/document_id_extension.dart';
import 'internal/internal.dart';
import 'query_document_snapshot.dart';
import 'query_snapshot.dart';

class Query {
  final InstanceResources instanceResources;

  final String path;
  final String fieldPath;
  final String operation;
  final dynamic value;
  final int limitOfDocs;

  Query(
    this.instanceResources, {
    @required this.path,
    this.operation,
    this.limitOfDocs,
    this.fieldPath,
    this.value,
  });

  Future<QuerySnapshot> get() async {
    final docs = await runQuery(
      fieldPath: fieldPath,
      operation: operation,
      value: value,
      collectionId: Pointer(path).components.last,
      parentPath: Pointer(path).parentPathOrNull(),
      api: instanceResources.firestoreApi,
      client: instanceResources.client,
    );

    final queryDocs = docs
        .map((doc) => QueryDocumentSnapshot(doc.id, doc.fields.toPrimitives(),
            exists: true))
        .toList();
    return QuerySnapshot(queryDocs);
  }

  Query where(
    // TODO: Find out why this is not a string - because of FieldValues?
    dynamic field, {
    dynamic isEqualTo,
    dynamic isNotEqualTo,
    dynamic isLessThan,
    dynamic isLessThanOrEqualTo,
    dynamic isGreaterThan,
    dynamic isGreaterThanOrEqualTo,
    dynamic arrayContains,
    List<dynamic> arrayContainsAny,
    List<dynamic> whereIn,
    List<dynamic> whereNotIn,
    bool isNull,
  }) {
    return _copyWith(
      fieldPath: field as String,
      operation: arrayContains != null ? 'ARRAY_CONTAINS' : 'EQUAL',
      value: arrayContains ?? isEqualTo,
    );
  }

  Query limit(int limit) {
    return _copyWith(limit: limit);
  }

  Query _copyWith({
    String fieldPath,
    String operation,
    dynamic value,
    int limit,
  }) {
    return Query(
      instanceResources,
      path: path,
      fieldPath: fieldPath ?? this.fieldPath,
      limitOfDocs: limit ?? limitOfDocs,
      operation: operation ?? this.operation,
      value: value ?? this.value,
    );
  }
}
