import 'package:cloud_firestore_server/src/credentials/credentials.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:googleapis_auth/auth.dart' as googleapis_auth;
// ignore: import_of_legacy_library_into_null_safe
import 'package:googleapis/firestore/v1.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:googleapis_auth/auth_io.dart' as googleapis_auth;
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

/// Bundles often used Firestore-Api classes.
/// This just helps readability as we don't have to pass each class one by one.
class InstanceResources {
  final http.Client client;
  final ProjectsDatabasesDocumentsResourceApi firestoreApi;
  final String projectId;
  String get databasePath => 'projects/$projectId/databases/(default)';

  InstanceResources({
    required this.client,
    required this.firestoreApi,
    required this.projectId,
  });
}

/// Creates [InstanceResources] via given [credentials] with the Firstore-Api
/// from googleapis. Uses googleapis_auth to create an
/// [googleapis_auth.AuthClient] for authenticated calls to Firestore.
Future<InstanceResources> createInstanceResources(
    ServiceAccountCredentials credentials) async {
  final _creds = googleapis_auth.ServiceAccountCredentials(
      credentials.email,
      googleapis_auth.ClientId.serviceAccount(credentials.clientId),
      credentials.privateKey);

  const _scopes = [FirestoreApi.DatastoreScope];
  final client = await googleapis_auth.clientViaServiceAccount(_creds, _scopes);

  final ProjectsDatabasesDocumentsResourceApi api =
      FirestoreApi(client).projects.databases.documents;

  return InstanceResources(
    client: client,
    firestoreApi: api,
    projectId: credentials.projectId,
  );
}
