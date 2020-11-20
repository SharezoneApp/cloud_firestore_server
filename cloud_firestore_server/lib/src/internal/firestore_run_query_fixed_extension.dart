import 'dart:convert';

import 'package:googleapis/firestore/v1.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

extension FirestoreRunQueryFixedExtension
    on ProjectsDatabasesDocumentsResourceApi {
  /// Runs a query.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [parent] - The parent resource name. In the format:
  /// `projects/{project_id}/databases/{database_id}/documents` or
  /// `projects/{project_id}/databases/{database_id}/documents/{document_path}`.
  /// For example:
  /// `projects/my-project/databases/my-database/documents` or
  /// `projects/my-project/databases/my-database/documents/chatrooms/my-chatroom`
  /// Value must have pattern
  /// "^projects/[^/]+/databases/[^/]+/documents/[^/]+/.+$".
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [RunQueryResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  Future<List<Document>> runQueryFixed(RunQueryRequest request,
      {@required http.Client client, @required String parent}) async {
    final urlParentAddition = parent != null ? '/$parent' : '';
    final url =
        'https://firestore.googleapis.com/v1/projects/sharezone-debug/databases/(default)/documents$urlParentAddition:runQuery';
    final body = json.encode(request.toJson());
    final response = await client.post(url, body: body);
    final resBody = response.body;
    final List<dynamic> decoded = json.decode(resBody) as List;
    if (decoded[0]['error'] != null) {
      throw Exception('Firestore Error: $resBody!');
    }
    final docs = [
      for (final docJson in decoded)
        if (docJson['document'] != null)
          Document.fromJson(docJson['document'] as Map)
    ];
    return docs;
  }
}
