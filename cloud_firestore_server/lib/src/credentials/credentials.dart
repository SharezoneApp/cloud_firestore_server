import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

void _throwIfNullOrEmpty(String value, String name) {
  if (value == null) {
    throw ArgumentError.notNull(name);
  }
  if (value.isEmpty) {
    throw ArgumentError("Invalid Argument: $name can't be an empty string.");
  }
}

class ServiceAccountCredentials {
  static const credentialsVarName = 'GOOGLE_APPLICATION_CREDENTIALS';

  /// The email address of this service account.
  final String email;

  /// The clientId.
  final String clientId;

  /// Private key.
  final String privateKey;

  final String projectId;

  ServiceAccountCredentials({
    @required this.email,
    @required this.clientId,
    @required this.privateKey,
    @required this.projectId,
  }) {
    _throwIfNullOrEmpty(email, 'email');
    _throwIfNullOrEmpty(clientId, 'clientId');
    _throwIfNullOrEmpty(privateKey, 'privateKey');
    _throwIfNullOrEmpty(projectId, 'projectId');
  }

  factory ServiceAccountCredentials.fromPath(String path) {
    return ServiceAccountCredentials.fromFile(File(path));
  }

  factory ServiceAccountCredentials.fromFile(File credentialsFile) {
    final content = credentialsFile.readAsStringSync();
    return ServiceAccountCredentials.fromJson(content);
  }

  factory ServiceAccountCredentials.fromJson(String json) {
    return ServiceAccountCredentials.fromJsonMap(
      Map<String, dynamic>.from(jsonDecode(json) as Map),
    );
  }
  factory ServiceAccountCredentials.fromJsonMap(Map<String, dynamic> jsonMap) {
    final clientId = jsonMap['client_id'] as String;
    final privateKey = jsonMap['private_key'] as String;
    final email = jsonMap['client_email'] as String;
    final type = jsonMap['type'] as String;
    final projectId = jsonMap['project_id'] as String;

    if (type != 'service_account') {
      throw ArgumentError('The given credentials are not of type '
          'service_account (was: $type).');
    }

    return ServiceAccountCredentials(
      email: email,
      clientId: clientId,
      privateKey: privateKey,
      projectId: projectId,
    );
  }

  factory ServiceAccountCredentials.applicationDefault() {
    final pathToDefaultCredentials = Platform.environment[credentialsVarName];
    return ServiceAccountCredentials.fromPath(pathToDefaultCredentials);
  }
}
